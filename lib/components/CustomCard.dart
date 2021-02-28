import 'package:flutter/material.dart';

// Flutter
class CustomCard extends StatelessWidget {
  CustomCard({@required this.index, @required
  this.onPress});

  final index;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: (Column(
          children: <Widget>[

            Text('Card $index',
                textAlign: TextAlign.center
            ),


           TextButton(
              child:  Text('Press'),
              onPressed: this.onPress,
             style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all<Color>(Colors.black54),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white)

             )
            ),

          ],
        )
        )
    );
  }
}
