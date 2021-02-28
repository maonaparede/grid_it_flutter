
import 'package:flutter/material.dart';

class CustonTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            child:
            Row(children: [
              Padding(padding: const EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 2.0), child:
              Text("Text Test " , textAlign: TextAlign.center)
              )
              ,
              Padding(padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0), child:
              Text("Paddinng Level " , textAlign: TextAlign.center)
              )
            ])



        )

    );
  }

}