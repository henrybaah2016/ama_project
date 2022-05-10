import 'package:bilbo/splash/splash.dart';
import 'package:flutter/material.dart';

import 'home/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' ',
      theme: ThemeData(
        // fontFamily: 'SanFrancisco',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),


    );
  }
}
