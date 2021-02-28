import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grid_it_flutter/main.dart';

class ImageEdit extends State<ImageEditor> {


  @override
  Widget build(BuildContext context) {

    final File imageFile = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.file(imageFile)
              ]
          ),
        )
    );
  }

}