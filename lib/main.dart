import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_crop/image_crop.dart';
import 'package:flutter/cupertino.dart';
import 'package:tflite_example/text.dart';
import 'package:tflite_example/lib.dart';
import 'package:path_provider/path_provider.dart';


List language = ['en','te','hi','ta','kn','bn','mr','ne','ml','ur'];
List lan =["English","తెలుగు","हिंदी","தமிழ்","ಕನ್ನಡ","বাঙালি","मराठी","नेपाली","മലയാളം","اردو"];
 int _lanIndex=0;
 List _recognitions;


List<DropdownMenuItem<int>> li=[];
copyZip() async{
  ByteData data = await rootBundle.load('assets/json.zip');
  List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  print(appDocPath);
  print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
  new Directory(appDocPath+'/.jsonFile').create(recursive: true);
  await File(appDocPath+'/.jsonFile/json.zip').writeAsBytes(bytes);
  print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');



}


void main() {
  copyZip();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();


}

class Language extends StatefulWidget{
  Lang createState()=>new Lang();
}
class Lang extends State<Language>{



 String lang=lan[_lanIndex];
  Widget build(BuildContext context) {

   return  Scaffold(

     body:
     Container(
       child:Wrap(
         children:<Widget>[
           new Container(
              color:Colors.purple,
              width:double.maxFinite,
              height:30,
              child:new Text('Select a language',style: TextStyle(color:Colors.white,fontSize: 25,fontStyle: FontStyle.italic),textAlign: TextAlign.center,),
            ),
         new Container(
         height: 500,
         width: double.maxFinite,

    //   color: Colors.blue,
         child: Center(
           child: ListView.builder(

               itemCount: lan.length,

               itemBuilder:(BuildContext context,int index){
                /* return new GestureDetector(
                     onTap:(){
                       lanIndex=index;
                       print(index);

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Screen1()),);
                     },*/
               return new Container(

             //   color: Colors.red,
                child: new RadioListTile(
                   activeColor: Colors.green ,
                   groupValue: lang,
                   value:lan[index],
                   title: new Text(lan[index],style: TextStyle(color: Colors.black),),
                   onChanged: (value) {
                    setState((){
                          _lanIndex=index;
                          print(_lanIndex);
                           lang=value;

                    });



                  },),);
                 },
         ),),
         ),],


   ),),
   );
  }

}

class MyAppState extends State<MyApp> {

  List<Widget> tabs=[

  ];

  void initState() {
    super.initState();


    //_tabController=TabController(length: 3, vsync: this);


  }








  @override
  Widget build(BuildContext context) {
    //load();
    return DefaultTabController(
      length: 3,
      child:MaterialApp(
       home: Scaffold(
        appBar: AppBar(
           title: new Text("LeafBox"),

          bottom: TabBar(
            indicatorColor: Colors.pink,
            tabs: [
              Tab(  icon: Icon(Icons.language,color: Colors.white), text: "Language"),
              Tab(  icon: Icon(Icons.image,color: Colors.white), text: "Image Based",),
              Tab(  icon: Icon(Icons.text_fields,color: Colors.white), text: "Text Based"),


            ],
          ),
        ),
        body: TabBarView(
           // controller: _tabController,

            children:<Widget>[
              new Language(),
            new Screen1(),
            new Screen2(),

          ],
        ),
        /*
        Stack(
          children: <Widget>[



        DropdownButton(

        items: li,hint: new Text("select plant"),
            onChanged:(value)=>Text("plant $value is selected")),


            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
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

          ],

        ),*/


          drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[

              UserAccountsDrawerHeader(

                accountName: Text("Mahesh"),
                accountEmail: Text("d.mahesh995@gmail.com"),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.black38, child: Text("cc")),

              ),
              ListTile(
                title: Text('Home'),
                trailing: Icon(Icons.home),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: Text('Help'),
                trailing: Icon(Icons.help),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: Text('Contact us'),
                trailing: Icon(Icons.call),


                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: Text('share'),
                trailing: Icon(Icons.share),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),



       /*   bottomNavigationBar:BottomNavigationBar(
            fixedColor: Colors.amber[200],
              currentIndex: _cindex,

            type: BottomNavigationBarType.fixed,
            onTap: (index){

              setState(() {
                _cindex=index;

              });
              _tabController.animateTo(_cindex);

           //   _incrementTab(index);
            },
            items: [
              BottomNavigationBarItem(

                  icon: Icon(Icons.image,color: Colors.blue),
                  title: new Text('Image Based',style: TextStyle(color: Colors.blue[500]),)
              ),
              BottomNavigationBarItem(

                  icon: Icon(Icons.text_fields,color: Colors.blue),
                  title: new Text('Text Based',style:TextStyle(color:Colors.blue[500]))
              ),
              BottomNavigationBarItem(

                  icon: Icon(Icons.language,color: Colors.blue),
                  title: new Text('Language',style: TextStyle(color: Colors.blue[500]),)
              ),


            ],

          )*/


    ),),);
  }
}
class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => new _Screen1State();
}
final cropKey = GlobalKey<CropState>();


class _Screen1State extends State<Screen1> {

  String enDisease;
  List data;
  List lang;
  String disease;


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
        maxWidth: 224,
        maxHeight: 224,
      );

      recognizeImage(croppedFile);

      enDisease= _recognitions[0]["label"];
      data = Lib.getData(language[0]);
      print(data);
      lang = Lib.getData(language[_lanIndex]);
      SecondRoute s = new SecondRoute(en: data,data: lang);
      print(lang);
      disease= lang[Lib.getIndex(enDisease,'dis_name')[0]]['dis_name'];
      print(disease);
      print(enDisease);
      s.newTaskModalBottomSheet1(context, enDisease,disease);

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
          labels: "assets/Disease2.txt",
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
       backgroundColor: Colors.lightGreen[50],

        body:
        new Container(
          height:double.infinity,
          width: double.infinity,
        //  margin: new EdgeInsets.only(top: 20.0, bottom: 10.0,left: 20.0,right: 20),
          child: DecoratedBox(
            decoration: BoxDecoration(

             // borderRadius: BorderRadius.circular(30),
              image: DecorationImage(

                //  Image.file(_image),
                image: ExactAssetImage('assets/field.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),



        /*

             _recognitions != null
                ? _recognitions.map((res) {
               SecondRoute s = new SecondRoute();
              return s.newTaskModalBottomSheet1(context,res[0]["label"]);
            })
                :  null , */
        floatingActionButton:new Container(


        child: new Row(

          children:<Widget>[
            new SizedBox(
              width:60,
            ),

            Align(
              alignment:Alignment.bottomLeft,

              child: FloatingActionButton.extended(backgroundColor: Colors.blue,onPressed:getImageGallery,
                label: new Text('Gallery'),elevation: 20,highlightElevation: 100, icon: Icon(Icons.add_a_photo),shape:StadiumBorder() ,
                  heroTag: "btn1"),
            ),
            new SizedBox(
              width:80,
            ),

            Align(
              alignment:Alignment.bottomRight,
              child:FloatingActionButton.extended(backgroundColor:Colors.blue,onPressed: getImageCamera,
                label:new Text('Camera'),elevation:20,highlightElevation:100,icon:Icon(Icons.camera),shape: StadiumBorder(),
                  heroTag: "btn2"),
            ),
          ],),
      ), );}}
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }






class Screen2 extends StatefulWidget{
     _Screen2 createState()=>new _Screen2();
}




class _Screen2 extends State<Screen2> {
  List images;
  List en;
  List lan;
  List enPlants;
  List lanPlants;
  var myGridView;
  Lib l = new Lib();

  void initState(){
    super.initState();

    enPlants = Lib.getPlants(Lib.getData(language[0]));
    images = Lib.getPlantImages(enPlants);
    en =Lib.getData(language[0]);
    lan =Lib.getData(language[_lanIndex]);
    lanPlants = Lib.getPlants(Lib.getData(language[_lanIndex]));
    print(_lanIndex);
    index=_lanIndex;
    print('oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
    print(index);

  }
   static int index;




  @override
  Widget build(BuildContext context) {
     myGridView = new ListView.builder(
        itemCount: enPlants.length,
      //gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)


      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Container(
               height: 100,
               color: Colors.white,

              margin: new EdgeInsets.only(top: 5.0, bottom: 5.0,left: 10.0,right: 10),
              child: new ListTutorial(gambar:images[index],jony:30,judul:lanPlants[index]),

          ),
          onTap: ()
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondRoute(plant: enPlants[index],data:lan,en:en)),
          );
      /*  showDialog(
        barrierDismissible: false,
        context: context,
        child: new CupertinoAlertDialog(
        title: new Column(
        children: <Widget>[
        new Text("GridView"),
        new Icon(
        Icons.favorite,
        color: Colors.red,
        ),
        ],
        ),
        content: new Text( spacecrafts[index]),
        actions: <Widget>[
        new FlatButton(
        onPressed: () {
        Navigator.of(context).pop();
        },
        child: new Text("OK")
        )
        ],
        ));  */
        },
        );},
    );
    return new Scaffold( // 1
       backgroundColor: Colors.white,

        /*appBar: new AppBar(
          backgroundColor: Colors.green[400],
          title: new Text("Text search"), // screen title
          actions: <Widget>[IconButton(icon: Icon(Icons.search),onPressed: ()
        {
          showSearch(context: context, delegate: DataSearch());

        },)],

        ),*/

        body:myGridView,


      /*  onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );
            },*/


    );
  }


}



class ListTutorial extends StatelessWidget {



  final String gambar;
  final String judul;
  final int jony;
  ListTutorial ({this.gambar, this.jony,this.judul});
  @override
  Widget build(BuildContext context) {

        return new Container(
      height: 200,
      width: (MediaQuery.of(context).size.width - 30.0) /2,
      color: Colors.white,

    child: Row(
    children: [
      SizedBox(width: 10.0),
    new Flexible(
    child:Container(
    height: 80.0,
    width: 80,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    image: DecorationImage(
    image: AssetImage(gambar),
    fit: BoxFit.cover
    )
    ),
     ),),
    SizedBox(width: jony.toDouble()),

    Text(judul,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.clip,
        maxLines: 2,

    style: TextStyle(
      fontFamily: '',
      color: Colors.black,
      fontSize: 18,

    )
    ),],),




    /*Container(
      padding: new EdgeInsets.all(20.0),

      child: new Center(
        child: new Row(
          children: <Widget>[
            new Image(
              image: new AssetImage(
                  gambar),
              width: 70.0,
            ),
            new Text(
              judul,
              style: new TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );*/
         ); }
}

