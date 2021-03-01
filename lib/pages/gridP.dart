


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grid_it_flutter/components/CustomPaperGrid.dart';

import '../main.dart';

class GridTitle extends State<GridTileDemo> {
  Widget build(BuildContext context) {
    return Container(
        height: 5,
        width: 5,
        color: Colors.transparent,
            child:  GridPaperCustom(
              interval: 100,
              strokeWidth: 2,
              color: Colors.red,
              divisions: 1,
              subdivisions: 1,
            )
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
          width: 2
      ),
    );
  }
}