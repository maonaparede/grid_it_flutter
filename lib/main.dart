import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/ImageCrop.dart';
import 'package:grid_it_flutter/pages/Landing.dart';


/*
Proxima att:
  dá pra usar o CustomPaperGridImg  pra renderizar img com qualidade total
  colocar tela de aguardo quandoo salva grid,
  mudar cor dos icones/ mesma cor da grade,
  travar a tela em portrait screen,
  nome aleatório na hr de salvar,
  organizar os códigos
 */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      //Rotas para as paginas.
      initialRoute: '/crop',

      routes: {
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        '/crop': (context) => CropPage()
      },

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  Landing createState() => Landing();
}

class CropPage extends StatefulWidget{

  @override
  ImageCrop createState() => ImageCrop();
}

