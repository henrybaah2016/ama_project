
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bilbo/home/home.dart';
import 'package:bilbo/signup/signup.dart';
import 'package:bilbo/splash/splash.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: Center(
          child: Column(
        children: <Widget>[
          Center(
              child: Container(
                margin: const EdgeInsets.only(top: 80, left: 5, bottom: 5),
                height: 70,
                width: 70,
                child: Image.asset('assets/images/amalog.png'),
              )),
          Container(
            margin: const EdgeInsets.only(top: 0, left: 5, bottom: 40),

            child: Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Text(
                'Accra Metropolitan Assembly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff056839),
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffB3B3B3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff000000)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffB3B3B3)),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  contentPadding: EdgeInsets.only(bottom: 0, left: 10),
                  hintStyle: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: TextField(
                obscureText: _obscurePassword,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffB3B3B3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff000000)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffB3B3B3)),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  contentPadding: EdgeInsets.only(bottom: 0, left: 10),
                  hintStyle: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.remove_red_eye
                          : Icons.visibility_off,
                      color: this._obscurePassword
                          ? Color(0xffff4A4A)
                          : Color(0xffC6C6C6),
                      size: 20.0,
                    ),
                    onPressed: () {
                      setState(
                          () => this._obscurePassword = !this._obscurePassword);
                    },
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                child: new Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Row(
                        children: <Widget>[

                          new GestureDetector(
                            onTap: () {

                            },
                            child: new Text("Forgot Password",  style: new TextStyle(color: Color(0xff056839),fontSize: 12, fontWeight: FontWeight.w600)),
                          )

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 60, left: 5, right: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff056839),
                minimumSize: Size(double.infinity, 52),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  side: BorderSide(color: Color(0xff056839)),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                'Sign in',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                      color: Color(0xffB3B3B3),
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                new GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      " Sign up",
                      style: TextStyle(
                          color: Color(0xff056839),
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),)
              ],
            ),
          ),
        ],
      ),),
    ),);
  }
}
