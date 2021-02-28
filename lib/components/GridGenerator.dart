



import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyPainter extends CustomPainter{


  final ui.Image image;

  MyPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    
    canvas.drawImage(image, Offset.zero, Paint());
    canvas.drawLine(Offset.zero, Offset( image.width as double , 0), Paint());



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