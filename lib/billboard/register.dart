import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:bilbo/home/home.dart';
import 'package:bilbo/login/login.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterBillboard extends StatefulWidget {
  RegisterBillboard({Key? key}) : super(key: key);

  @override
  _RegisterBillboardState createState() => _RegisterBillboardState();
}

class _RegisterBillboardState extends State<RegisterBillboard> {
  final qrKey = GlobalKey();
  final _nameOfOrganizationController = TextEditingController();
  final _locationController = TextEditingController();
  final _registrationDateController = TextEditingController();
  String _billBoardInfo = "";

  _validateFields() {
    if (_nameOfOrganizationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter the name of the organization'),
        ),
      );
      return;
    } else if (_locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter the location of the organization'),
        ),
      );
      return;
    } else if (_registrationDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Please enter the registration date of the organization'),
        ),
      );
      return;
    } else {
      _submitBillboardInfo(context);
    }
  }

  _submitBillboardInfo(BuildContext context) {
    _billBoardInfo = '''{
      "Name of organization": ${_nameOfOrganizationController.text};
      "Location of billboard": ${_locationController.text};
      "Registration Date": ${_registrationDateController.text};
    }''';

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Notification',
              style: TextStyle(
                  color: Color(0xff3e3e3e),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You have successfully registered your billboard',
                  ),
                  Center(
                    child: QrImage(
                      key: qrKey,
                      data: _billBoardInfo,
                      size: 300,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                textColor: Color(0xfffdcb03),
                onPressed: () {
                  _nameOfOrganizationController.text = "";
                  _locationController.text = "";
                  _registrationDateController.text = "";
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Color(0xfffdcb03),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void takeScreenShot() async {
    PermissionStatus res;
    res = await Permission.storage.request();
    if (res.isGranted) {
      final boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // We can increse the size of QR using pixel ratio
      final image = await boundary.toImage(pixelRatio: 5.0);
      final byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        // getting directory of our phone
        final directory = (await getApplicationDocumentsDirectory()).path;
        final imgFile = File(
          '$directory/${DateTime.now()}.png',
        );
        imgFile.writeAsBytes(pngBytes);
        GallerySaver.saveImage(imgFile.path).then((success) async {
          //In here you can show snackbar or do something in the backend at successfull download
        });
      }
    }
  }

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
                  controller: _nameOfOrganizationController,
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
                  controller: _locationController,
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
                  controller: _registrationDateController,
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
                  _validateFields();
                },
                child: Text(
                  'Submit Billboard',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
