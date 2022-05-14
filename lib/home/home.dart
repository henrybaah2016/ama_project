import 'dart:io';
import 'dart:math' as math;

import 'package:bilbo/billboard/register.dart';
import 'package:bilbo/billboard/verify.dart';
import 'package:bilbo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:bilbo/login/login.dart';
import 'package:bilbo/splash/splash.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8fa),
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return Container(
              height: 45,
              width: 45,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset('assets/images/amalog.png'),
              ),
            );
          },
        ),
        title: const Text(
          'AMA',
          style: TextStyle(
            color: Color(0xff3d3c3d),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (result) async {
              if (result == 0) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Color(0xff056839),
              size: 30.0,
            ),
            offset: Offset(0, kToolbarHeight),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 25),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: Color(0xff3e3956),
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                value: 0,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xff056839),
                              Color(0xff056839),
                            ],
                          )),
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterBillboard()),
                          );
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Flexible(
                                          child: Text(
                                            'Register Billboard',
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ))),
                              ),
                              Expanded(
                                child: Container(
                                    height: 70,
                                    width: 70,
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Image.asset(
                                        'assets/images/billboard_reg.png')),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xff056839),
                              Color(0xff056839),
                            ],
                          )),
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyBillboard()),
                          );
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Flexible(
                                          child: Text(
                                            'Verify Billboard',
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ))),
                              ),
                              Expanded(
                                child: Container(
                                    height: 70,
                                    width: 70,
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Image.asset(
                                        'assets/images/verify_billboard.png')),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      // onPressed: () {},
      // backgroundColor: Color(0xfffbbc07),
      // child: const Icon(Icons.image_outlined),
      // ),
    );
  }
}
