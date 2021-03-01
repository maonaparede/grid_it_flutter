import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grid_it_flutter/components/CustomPaperGrid.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import '../components/AssetsIcon.dart' as asset;
import 'dart:ui' as ui;
import '../main.dart';


enum AppState {
  free,
  picked,
  cropped,
}

class ImageCrop extends State<CropPage> {

  GlobalKey globalKey = GlobalKey();
  AppState state;
  File imageFile;
  ui.Image image;
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _move = Offset(0.0, 0.0);
  double _currentSliderValue = 110;
  int pickerColors = 0;
  Color _pickerColor = Colors.red;



  @override
  void initState() {
  super.initState();
  state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollControler =  ScrollController();

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

                child: Transform.translate(
                offset: _move,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                child:
                   Stack(
                  children: <Widget>[
                  Center(
                      child: imageFile != null ? _renderImage(Image.file(imageFile)) : Container(),
                  ),
                    ],
                  ),
                )
                  ,)
                  ,)
          ),
          ),
              Expanded(

              child: Padding(
                padding: EdgeInsets.fromLTRB(1.0 , 0.0 , 1.0 , 3.0),
                  child:
                      Scrollbar(
                        isAlwaysShown: true,
                        controller: _scrollControler,

                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollControler,
                    children: [
                      IconButton(icon: asset.photo,
                          onPressed: (){
                        _pickImage();
                      }),
                      IconButton(icon: asset.crop, onPressed:(){cropImageFunction();}),
                    Slider(
                      value: _currentSliderValue,
                      min: 40,
                      max: 200,
                      divisions: 10,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                      IconButton(icon: asset.brush, onPressed: (){changeColor();}),
                      IconButton(icon: asset.save, onPressed: () {
                        setState(() {
                          if (imageFile != null) {
                            _save();
                          }
                        }
                        );
                      }),
                    ],

                  ),
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

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }

  cropImageFunction(){
    if(state == AppState.picked) {
      _cropImageFinal();
    }
  }

  Widget _renderImage(Image image) {

    return
      RepaintBoundary(
        key: globalKey,
        child: GridPaperCustom(
          interval: _currentSliderValue,
          strokeWidth: 2,
          color: _pickerColor,
          divisions: 2,
          subdivisions: 1,

          child: image,
        )
      );
  }

  Future<ui.Image> loadImage(File file)async{
    final data = await file.readAsBytes();
    image = await decodeImageFromList(data);
    return image;
  }
  
  Future<Null> _pickImage() async {
  PickedFile imageFile1 = await ImagePicker().getImage(source: ImageSource.gallery);
  if (imageFile1 != null) {
  setState(() {
  state = AppState.picked;
  imageFile = File(imageFile1.path);
  }
  );
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


// ValueChanged<Color> callback
  void changeColor() {

    switch(pickerColors){
      case 1:
        _pickerColor = Colors.white70;
        break;
      case 2:
        _pickerColor = Colors.blue;
        break;
      case 3:
        _pickerColor = Colors.pinkAccent;
        break;
      case 4:
        _pickerColor = Colors.black26;
        break;
      default:
        _pickerColor = Colors.orangeAccent;
        pickerColors = 0;
    }
    pickerColors++;

    setState(() => _pickerColor);
  }

  Future<void> _save() async {
    RenderRepaintBoundary boundary =
    globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    await Permission.storage.request();

    //Request permissions if not already granted
    if (!(await Permission.storage.status.isGranted))
      await Permission.storage.request();

    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(pngBytes),
        quality: 100,
        name: "canvas_image");
    print(result);
  }

  }