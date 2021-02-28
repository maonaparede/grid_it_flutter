



import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyPainter extends CustomPainter{


  final double imageH;
  final double imageW;

  MyPainter(this.imageH, this.imageW);

  @override
  void paint(Canvas canvas, Size size) {
    double pixInterval = 20;


      canvas.drawImage(image, offset, Paint());
      canvas.drawLine(Offset(100, 50), Offset(50 , 200), Paint());
/*

      for (int i = 0; i < imageH / pixInterval; i++) {
        canvas.drawLine(Offset(0, i * pixInterval), Offset( imageW, i * pixInterval), Paint());
      }
      // draw vertical lines
      for (int i = 0; i < imageW / pixInterval; i++) {
        canvas.drawLine(Offset(i * pixInterval, 0),Offset(i * pixInterval, imageH), Paint());
      }

 */


  }



  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Future<ui.Image> loadImage(File file)async{
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }

}