



import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyPainter extends CustomPainter{


  final ui.Image file;

  MyPainter(this.file);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    double pixInterval = 20;

 
     // ui.Image img = loadImg(file);
    
      double imageH = 1500;
      double imageW = 500;


    canvas.drawImage(file, Offset.zero, Paint());
      //canvas.drawLine(Offset(100, 50), Offset(50 , 200), Paint()..strokeWidth = 200);


      for (int i = 0; i < imageH / pixInterval; i++) {
        canvas.drawLine(Offset(0, i * pixInterval), Offset( imageW, i * pixInterval), Paint());
      }
      // draw vertical lines
      for (int i = 0; i < imageW / pixInterval; i++) {
        canvas.drawLine(Offset(i * pixInterval, 0),Offset(i * pixInterval, imageH), Paint());
      }
      


  }





  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }



}