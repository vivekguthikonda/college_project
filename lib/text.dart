import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tflite_example/lib.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


class ListTutorial extends StatelessWidget {


  final String sip;
  ListTutorial ({ this.sip});
  @override
  Widget build(BuildContext context) {

    return new Container(
      height: 75,
     // width: (MediaQuery.of(context).size.width - 30.0) /2,
    //  color: Colors.white,
     child:Row(
     children:[
          new Expanded(
            child:Container(
              height: 200.0,
              width: 120.0,
        child: Column(
            children:[

                SizedBox(height: 5,),

            Chip(

              label: Text(sip,style: TextStyle(color: Colors.white,fontSize: 15),),
              backgroundColor: Colors.purple[400],
              padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 20.0),
             ),],),
            ),),],),
          /*
          Text(sip,
              textAlign: TextAlign.left,
              overflow: TextOverflow.clip,
              maxLines: 2,

              style: TextStyle(
                fontFamily: '',
                color: Colors.white,
                fontSize: 25,

              )
          ),],

           */


    ); }
}

class ListTutorial1 extends StatelessWidget {

  final String sipp;
  ListTutorial1 ({ this.sipp});
  @override
  Widget build(BuildContext context) {

    return new Container(
      height: 220,
      // width: (MediaQuery.of(context).size.width - 30.0) /2,
    //  color: Colors.white,
      child: Row(
        children: [
      new Expanded(
      child:Container(
      height: 200.0,
        width: 120.0,
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: AssetImage(sipp),
                fit: BoxFit.cover
            ),
        ),
      ),),],),

    ); }
}

class SecondRoute extends StatelessWidget
{






  final String plant;
  final List data;
  final List en;
  SecondRoute({this.plant,this.data,this.en});






  @override
  Widget build(BuildContext context) {


    // TODO: implement build

    List  diseases=Lib.getDiseases(plant,data);
    List enDiseases=Lib.getDiseases(plant,en);
    List images=Lib.getDiseaseImages(enDiseases,data);


    var bd=ListView.builder(



        itemCount: diseases.length ,
        itemBuilder: (BuildContext context,int index)
        {

          return new GestureDetector(
              onTap:(){
                _newTaskModalBottomSheet(context,enDiseases[index],diseases[index]);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdRoute()),);
              },
           child: new Container(


           color: Colors.white,
           margin: new EdgeInsets.only(top: 10.0, bottom: 10.0,left: 10.0,right: 10),
           child: new Column(
            children:[

                new ListTutorial(sip: diseases[index],),
               new SizedBox(height: 10,),

                GridView.builder(
                    primary:false,
                  gridDelegate:new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,

                       ),
                    shrinkWrap: true,
                    itemCount: images[index].length,
                  //  scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context,int i)
                    {
                      return new Container(
                        height: 200,
                        child: new ListTutorial1(sipp: images[index][i],),
                      );
                    }
                )
            ],
           ), ),


          );


        },
      );

    return new  Scaffold(
      backgroundColor: Colors.white,

    appBar: AppBar(

      /*child:new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.green, size: 48.0),
          onPressed: () { Navigator.pop(context); }
      ),*/
    ),
      body: bd,
    );
  }
    void _newTaskModalBottomSheet (context,String disease,String lanDisease){

     showBottomSheet(

         context: context,
         builder: (BuildContext bc){
           return Container(
             color: Colors.white,
             child: new Wrap(
               children: <Widget>[

                 Container(
                   color:Colors.green,
                   alignment: Alignment.center,
                   height:40,
                   width:double.infinity,


                     child:  Text("Check Symptoms",style: TextStyle(color: Colors.white,fontSize: 20),),


                     ),
                 new SizedBox(
                   height:10,

                 ),


                 Container(
                   color: Colors.blue,

                   alignment: Alignment.center,

                   width:double.infinity,
                   child:new SizedBox(
                     height:30,
                     child:Text(lanDisease,style: TextStyle(color: Colors.white,fontSize: 20)),
                   ),),

                 new SingleChildScrollView(
                child: Container(
                 //  alignment: Alignment.centerLeft,
                  // width:double.infinity,
                 //  color: Colors.white,

                     decoration: new BoxDecoration(



                       borderRadius:new  BorderRadius.circular(25.0),
                       border: new Border.all(
                         width: 10.0,
                        color: Colors.white,
                       ),
                      gradient: new LinearGradient(
                         colors: [Colors.orange[50], Colors.cyan[50]],
                       )
                     ),

                     child:Text(Lib.getProp(disease,data,'symptoms'),style:TextStyle(color: Colors.black,fontSize: 17,fontStyle: FontStyle.italic)),
                 ),),






                new CheckboxListTile(

                   title: const Text('Check if symptoms are matched',style:TextStyle(color: Colors.purple,fontSize: 20,)),
                   value: false,
                   onChanged: (bool value) {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdRoute()),);
                      newTaskModalBottomSheet1(context,disease,lanDisease);
                   },

                 ),

               /*  new ListTile(
                   leading: new Icon(Icons.videocam),
                   title: new Text('others',style: TextStyle(color: Colors.blue,fontSize: 20),),
                   onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdRoute()),);
                   },
                 ),*/
               ],

             ),  );
         }
     );
   }

   void finalsheet(context,String lanDisease,String prop,String name,String disease){

     showBottomSheet(
         context: context,
         builder: (BuildContext bc){
           return Container(
             child: new Wrap(
               children: <Widget>[
                     Container(
                       color:Colors.green,
                       alignment: Alignment.center,
                       height:40,
                       width:double.infinity,


                       child:  Text(name,style: TextStyle(color: Colors.white,fontSize: 20),),


                     ),
              new Wrap(
               children:[
                 Container(
                   color:Colors.blue,

                   alignment: Alignment.center,

                   width:double.infinity,
                   child:new SizedBox(
                     height:30,
                     child:Text(lanDisease,style: TextStyle(color: Colors.white,fontSize: 20)),
                   ),),

                 Container(

                       //  alignment: Alignment.centerLeft,
                       // width:double.infinity,
                       //  color: Colors.white,


                       decoration: new BoxDecoration(


                         borderRadius:new  BorderRadius.circular(25.0),

                         border: new Border.all(
                           width: 10.0,

                           color: Colors.white,
                         ),
                           gradient: new LinearGradient(
                             colors: [Colors.green[50], Colors.cyan[50]],
                           )
                       ),

                       child:Text(Lib.getProp(disease,data,prop),style:TextStyle(color: Colors.black,fontSize: 17,fontStyle: FontStyle.italic)),
                     ),],),

           ],),);
           },
     );
   }




  void newTaskModalBottomSheet1(context,String disease,String lanDisease){


    print(Lib.getProp(disease,data,'nutshell'));

    List nutshell=Lib.getProp(disease,data,'nutshell');
    final markDownData = nutshell.map((x) => "- $x\n").reduce((x, y) => "$x$y");

    showBottomSheet(

        context: context,
        builder: (BuildContext bc){
          return Container(





            color: Colors.white,

            child: new Wrap(
              children: <Widget>[

                Container(
                  alignment: Alignment.center,
                  height:40,
                  width:double.infinity,
                  color: Colors.green,

                  child:  Text("Summary",style: TextStyle(color: Colors.white,fontSize: 20),),


                ),
                Container(
                  alignment: Alignment.center,
                  color:Colors.blue,
                  width:double.infinity,
                  child:new SizedBox(
                  height:25,
                  child:Text(lanDisease,style: TextStyle(color: Colors.white,fontSize: 18)),
                ),),

                  Container(
                    alignment: Alignment.centerLeft,
                    width:double.infinity,

                    color: Colors.white,
                    height:180,
                      child:Markdown(data: markDownData)),



                new SizedBox(width: 20,),
                new RaisedButton(
                    color: Colors.blue,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: new Text("Chemical Control",style: TextStyle(decorationColor: Colors.black,color: Colors.white,fontSize: 20),),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),),
                  onPressed: (){finalsheet(context,lanDisease,'c_control',"Chemical Control",disease);}
                ),
                new SizedBox(width: 20,),
                new RaisedButton(
                    color: Colors.blue,
                    child: new Text("Natural Control",style: TextStyle(decorationColor: Colors.black,color: Colors.white,fontSize: 20),),
                    padding: EdgeInsets.only(left: 10,right: 10),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),),
                    onPressed: (){finalsheet(context,lanDisease,'b_control',"Natural Control",disease);}
                ),
                new SizedBox(width: 80,),
                new RaisedButton(

                    color: Colors.green,

                    child: new Text("Preventive Measures",style: TextStyle(decorationColor: Colors.blue,color: Colors.white,fontSize: 20),),


                    padding: EdgeInsets.only(left: 30,right: 30),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),),
                    onPressed: (){finalsheet(context,lanDisease,'measures',"Preventive Measures",disease);}
                ),
               ],

              ),
          );}
    );
  }
}

class ThirdRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:new AppBar( title: Text("Text solution"),),
      body:new Container(
          width: 100,
          height: 100,


      ),);
  }
}