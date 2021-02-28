import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grid_it_flutter/components/GridGenerator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import '../components/AssetsIcon.dart' as asset;
import '../main.dart';


enum AppState {
  free,
  picked,
  cropped,
}

class ImageCrop extends State<CropPage> {

  AppState state;
  File imageFile;
  double _scale = 1.0;
  double _previousScale = 1.0;
  double _currentSliderValue = 25;


  @override
  void initState() {
  super.initState();
  state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
      title: Text('salve'),
      ),
      body: Center(
        child:
        Column(
            children: <Widget>[
          Container(
            height: 540,
            color: Colors.red,
          child: GestureDetector(
            onScaleStart: (ScaleStartDetails details) {
            _previousScale = _scale;
            setState(() {});
            },
            onScaleUpdate: (ScaleUpdateDetails details) {
            _scale = _previousScale * details.scale;
            setState(() {});
            },
            onScaleEnd: (ScaleEndDetails details) {
            print(details);

            _previousScale = 1.0;
            setState(() {});
            },
                child: RotatedBox(
                quarterTurns: 0,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                child:
                   Stack(
                  children: <Widget>[
                  Center(
                      child: imageFile != null ? _imageExist() : Container(),
                  ),
                    ],
                  ),
                )
                  ,)
                  ,)
          ),
          ),
              Container(
                height: 63,
                color: Colors.black26,
              child: Padding(
                padding: EdgeInsets.fromLTRB(1.0 , 0.0 , 1.0 , 0.0),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(icon: asset.photo,
                          onPressed: (){pickImageFunction();}),
                      IconButton(icon: asset.crop, onPressed:(){cropImageFunction();}),
                    Slider(
                      value: _currentSliderValue,
                      min: 0,
                      max: 200,
                      divisions: 10,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                      IconButton(icon: asset.brush, onPressed: null),
                      IconButton(icon: asset.save, onPressed: null),
                    ],

                  )
              ),
              )
            ]

      ),
      ),

       /*
       floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
          if (state == AppState.free)
          _pickImage();
          else if (state == AppState.picked)
          _cropImageFinal();
          else if (state == AppState.cropped) _clearImage();
          },
          child: _buildButtonIcon(),
        ) ,
        */
  );
  }

  pickImageFunction(){
      _pickImage();
  }

  cropImageFunction(){
    if(state == AppState.picked) {
      _cropImageFinal();
    }
  }

  Widget _imageExist() {
    return Stack(
      children: <Widget>[
        Center(
        child: Image.file(imageFile),
        ),
        CustomPaint(


          size: Size.infinite,
          painter: MyPainter(Image.file(imageFile).height , Image.file(imageFile).width),
        ),
      ],
    );
  }

  Future<Null> _pickImage() async {
  imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  if (imageFile != null) {
  setState(() {
  state = AppState.picked;
  });
  }
  }

  Future<Null> _cropImageFinal() async {
  File croppedFile = await ImageCropper.cropImage(
  sourcePath: imageFile.path,
  aspectRatioPresets: Platform.isAndroid
  ? [
  CropAspectRatioPreset.square,
  CropAspectRatioPreset.ratio3x2,
  CropAspectRatioPreset.original,
  CropAspectRatioPreset.ratio4x3,
  CropAspectRatioPreset.ratio16x9
  ]
      : [
  CropAspectRatioPreset.original,
  CropAspectRatioPreset.square,
  CropAspectRatioPreset.ratio3x2,
  CropAspectRatioPreset.ratio4x3,
  CropAspectRatioPreset.ratio5x3,
  CropAspectRatioPreset.ratio5x4,
  CropAspectRatioPreset.ratio7x5,
  CropAspectRatioPreset.ratio16x9
  ],
  androidUiSettings: AndroidUiSettings(
  toolbarTitle: 'Cropper',
  toolbarColor: Colors.deepOrange,
  toolbarWidgetColor: Colors.white,
  initAspectRatio: CropAspectRatioPreset.original,
  lockAspectRatio: false),
  iosUiSettings: IOSUiSettings(
  title: 'Cropper',
  ));
  if (croppedFile != null) {
  imageFile = croppedFile;
  setState(() {
  state = AppState.picked;
  });
  }
  }

  void _clearImage() {
  imageFile = null;
  setState(() {
  state = AppState.free;
  });
  }


  }