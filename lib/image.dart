import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_crop/image_crop.dart';
import 'package:flutter/cupertino.dart';
import 'package:tflite_example/text.dart';

File _image;
List _recognitions;

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => new _Screen1State();
}
final cropKey = GlobalKey<CropState>();


class _Screen1State extends State<Screen1> {




  Future getImageGallery() async {

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    recognizeImage(image);
    _cropImage(image);

    setState(() {
      // _image = image;
    });
  }
  Future getImageCamera() async{
    File image=await ImagePicker.pickImage(source: ImageSource.camera);
    _cropImage(image);
    //recognizeImage(image);
    setState((){
      //    _image=image;
    });
  }
  Future _cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 200,
      maxHeight: 200,
    );
    recognizeImage(croppedFile);
    setState(() {
      _image=croppedFile;
    });
  }


  /* Future cropImage(File image) async {

    }*/
  @override
  void initState() {
    super.initState();
    loadModel();
  }



  Future loadModel() async {
    try {
      String res = await Tflite.loadModel(
        model: "assets/Disease2.tflite",
        labels: "assets/Disease.txt",
      );
      print(res);
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Uint8List imageToByteList(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(i, j);
        buffer[pixelIndex++] = (((pixel >> 16) & 0xFF) - mean) / std;
        buffer[pixelIndex++] = (((pixel >> 8) & 0xFF) - mean) / std;
        buffer[pixelIndex++] = (((pixel) & 0xFF) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Future recognizeImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print(recognitions);
    setState(() {
      _recognitions = recognitions;
    });
  }

  Future recognizeImageBinary(File image) async {
    var imageBytes = (await rootBundle.load(image.path)).buffer;
    img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    img.Image resizedImage = img.copyResize(oriImage, 224, 224);
    var recognitions = await Tflite.runModelOnBinary(
      binary: imageToByteList(resizedImage, 224, 127.5, 127.5),
      numResults: 6,
      threshold: 0.05,
    );
    print(recognitions);
    setState(() {
      _recognitions = recognitions;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold( // 1

      body:new Container(
        child:Column(

          children:<Widget>[



            Center(
              child: _image == null
                  ? ActionChip(avatar: CircleAvatar(foregroundColor: Colors.black, backgroundColor: Colors.brown,),
                label: Text('Pick Image From Gallery'),onPressed: getImageGallery,) : Image.file(_image),
            ),
            Center(
              child: Column(
                children: _recognitions != null
                    ? _recognitions.map((res) {
                  return Text(
                    "${res["index"]} - ${res["label"]}: ${res["confidence"].toString()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      background: Paint()..color = Colors.white,
                    ),
                  );
                }).toList()
                    : [],
              ),
            ),
          ],),),

      floatingActionButton:new Container(
        height: 200,
        width: 150,
        color: Colors.white,
        child: new Column(
          children:<Widget>[FloatingActionButton(onPressed:getImageGallery, tooltip: 'Gallery', child: Icon(Icons.add_a_photo),),
          FloatingActionButton(onPressed: getImageCamera,tooltip: 'Camera',child:Icon(Icons.camera),),
          ],),
      ), );}}