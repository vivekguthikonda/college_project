import 'dart:io';
import 'package:archive/archive.dart';
import 'dart:convert' as JSON;

class Lib {



  static jsonToList(File f) {
    List x = JSON.jsonDecode(f.readAsStringSync());
    RegExp regExp = new RegExp(r"', '");
    for (int i = 0; i < x.length; i++) {
      List r = x[i]['sci_name'].split(regExp);
      r[0] = r[0].substring(1);
      r[r.length - 1] = r[r.length - 1].replaceAll("'", "");
      x[i]['sci_name'] = r;
      r = x[i]['nutshell'].split(regExp);
      r[0] = r[0].substring(1);
      r[r.length - 1] = r[r.length - 1].replaceAll("'", "");
      x[i]['nutshell'] = r;
      x[i]['file_name'] = x[i]['file_name'].split(r",");
    }
    return x;
  }

  static getDiseases(String plant, List data) {
    List diseases = new List();
    for (int i in getIndex(plant, 'sci_name')) {
      diseases.add(data[i]['dis_name']);
    }

    return diseases;
  }


  static getPlants(List x) {
    List plant = new List();
    for (int i = 0; i < x.length; i++) {
      x[i]['sci_name'].forEach((e) => plant.add(e));
    }
    return plant.toSet().toList();
  }

  static getProp(String disease, List data, String prop) {
    int index = getIndex(disease, 'dis_name')[0];
    return data[index][prop];
  }

  static getFromZip(String lang) {

    String path= '/data/user/0/sq.flutter.tfliteexample/app_flutter/.jsonFile/';

    List<int> bytes = new File(path + 'json.zip').readAsBytesSync();
    Archive archive = new ZipDecoder().decodeBytes(bytes);
    lang = lang + '.json';
    for (ArchiveFile file in archive) {
      String filename = file.name;
      if (filename == lang &&
          (FileSystemEntity.typeSync(path + 'json/' + filename) ==
              FileSystemEntityType.notFound)) {
        List<int> data = file.content;
        new File(path + 'json/' + filename)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      }
    }
    return path + 'json/' + lang;
  }

  static getData(String lang) {
    return jsonToList(new File(getFromZip(lang)));
  }

  static getIndex(String item, String col) {
    List data = getData('en');
    List index = new List();
    for (int i = 0; i < data.length; i++) {
      if (data[i][col].contains(item)) index.add(i);
    }
    return index;
  }

  static formIndex(int i, List data, String prop) {
    return data[i][prop];
  }

  static getDiseaseImages(List diseases, List data) {

    List images = new List();
    List newImages = new List();
    for (int i = 0; i < diseases.length; i++) {
      images.add(getProp(diseases[i], data, 'file_name'));
    }


    for (int i = 0; i < images.length; i++) {
      List list = new List();

      list = images[i];


      for (int j = 0; j < list.length; j++) {
        if (list[j].substring(0, 6) == "assets")
          break;
        list[j] = list[j].substring(1, list[j].length - 1);
        list[j] = 'assets/' + list[j];
      }


      newImages.add(list);
    }

    return newImages;
  }
  static getPlantImages(List plants) {
    List images =new List();
    for(int i=0;i<plants.length;i++){
      images.add('assets/plants/'+plants[i]+'.png');

    }
    return images;
  }

}
