import 'dart:async';

import 'package:bilbo/signup/signup.dart';
import "package:flutter/material.dart";
class Splash extends StatefulWidget {
  const Splash({ Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();

    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 3000), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 160,
              width: 140,
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/amalog.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

