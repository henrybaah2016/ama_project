import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bilbo/home/home.dart';
import 'package:bilbo/login/login.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RegisterBillboard extends StatefulWidget {
  RegisterBillboard({Key? key}) : super(key: key);

  @override
  _RegisterBillboardState createState() => _RegisterBillboardState();
}

class _RegisterBillboardState extends State<RegisterBillboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8fa),
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return const Icon(
              Icons.arrow_back,
              color: Color(0xff056839),
              size: 30.0,
            );
          },
        ),
        title: const Text(
          'Register Billboard',
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
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            QrImage(data: ""),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 5, bottom: 10),
              child: Column(
                children: [
                  Text(
                    'Billboard Information',
                    style: TextStyle(
                      color: Color(0xff056839),
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0, left: 5, bottom: 40),
              child: Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Text(
                  'Register your billboard as a company or organisation by filling the form below',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xff3d3c3d),
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  keyboardType: TextInputType.text,
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
                      labelText: 'Name of Company/Organisation',
                      labelStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      contentPadding: EdgeInsets.only(bottom: 0, left: 10),
                      hintText: 'Name of Company/Organisation',
                      hintStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  keyboardType: TextInputType.text,
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
                      labelText: 'Location of Billboard',
                      labelStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      contentPadding: EdgeInsets.only(bottom: 0, left: 10),
                      hintText: 'Location of Billboard',
                      hintStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: TextField(
                  keyboardType: TextInputType.datetime,
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
                      labelText: 'Registration Date',
                      labelStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      contentPadding: EdgeInsets.only(bottom: 0, left: 10),
                      hintText: 'Registration Date',
                      hintStyle: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5),
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
                  showDialog<void>(
                      context: context,
                      builder: (context) => registeredBillBoardSucc);
                },
                child: Text('Submit Billboard',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final AlertDialog registeredBillBoardSucc = AlertDialog(
    title: Text(
      'Notification',
      style: TextStyle(
          color: Color(0xff3e3e3e), fontSize: 18, fontWeight: FontWeight.bold),
    ),
    content: Container(
        height: 200,
        child: Column(
          children: [
            Text(
              'You have successfully registered your billboard',
            ),
            Center(
                child: Container(
              margin: const EdgeInsets.only(top: 10, left: 5, bottom: 5),
              height: 130,
              width: 130,
              child: Image.asset('assets/images/qr_code_img.png'),
            )),
          ],
        )),
    actions: [
      FlatButton(
        textColor: Color(0xfffdcb03),
        onPressed: () {},
        child: Text(
          "OK",
          style: TextStyle(
            color: Color(0xfffdcb03),
          ),
        ),
      ),
      // FlatButton(
      //   textColor: Color(0xfffdcb03),
      //   onPressed: (){
      //
      //   },
      //   child: Text('OK'),
      // ),
    ],
  );
}
