
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';


import '../main.dart';



class Landing extends State<MyHomePage> {

 // static const plataform = const MethodChannel('sample.flutter.dev/grid');
  File imageFile = File('assets/images/wlop.jpg');
  ui.Image image;

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
      return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Flutter Test"),
          ),
          body:
          Center(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/crop');
                    },
                    child: Text('Strike back!'),
                  ),


                ],


              )

          ) // This trailing comma makes auto-formatting nicer for build methods.
      );

  }

  Future<ui.Image> loadImage(File file)async{
    final data = await file.readAsBytes();
    image = await decodeImageFromList(data);
    return await decodeImageFromList(data);
  }

}

