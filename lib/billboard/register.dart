import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

// import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:bilbo/home/home.dart';
import 'package:bilbo/login/login.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

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

  ScreenshotController screenshotController = ScreenshotController();

  Future<void> _saveToGallery(File imageFile) async {
    try {
      final result =
          await ImageGallerySaver.saveImage(imageFile.readAsBytesSync());
      debugPrint("Image Stored Successfully !!");
    } on Exception catch (exp) {
      debugPrint("Image Exception ${exp.toString()}");
    }
  }

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
    _billBoardInfo =
        'Name of Organization : ${_nameOfOrganizationController.text}, Location: ${_locationController.text}, Registration Date:  ${_registrationDateController.text}';
    // _billBoardInfo = '''{
    // "Name of organization": ${_nameOfOrganizationController.text};
    // "Location of billboard": ${_locationController.text};
    // "Registration Date": ${_registrationDateController.text};
    // }''';

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
                  Screenshot(
                    controller: screenshotController,
                    child: Center(
                      child: QrImage(
                        key: qrKey,
                        data: _billBoardInfo,
                        size: 300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                textColor: Color(0xfffdcb03),
                onPressed: () {
                  // screenshotController.capture().then((imageFile) async {
                  // try {
                  // bool isGranted = await Permission.storage.isGranted;
                  // if (isGranted) {
                  // _saveToGallery(File.fromRawPath(imageFile!));
                  // } else {
                  // Ask Permission
                  // PermissionStatus status =
                  // await Permission.storage.request();
                  // switch (status) {
                  // case PermissionStatus.granted:
                  // _saveToGallery(File.fromRawPath(imageFile!));
                  // break;
                  // case PermissionStatus.denied:
                  // debugPrint(
                  // "Storage permission required to Save Image");
                  // break;
                  // case PermissionStatus.permanentlyDenied:
                  // case PermissionStatus.restricted:
                  // debugPrint(
                  // "Storage permission required to Save Image, allow permissions in Settings");
                  // break;
                  // case PermissionStatus.limited:
                  // break;
                  // }
                  // }
                  // } catch (exp) {
                  // debugPrint("Storage Permission Error ${exp.toString()}");
                  // }
                  // }).catchError((err) {
                  // debugPrint("Image catchError ${err.toString()}");
                  // });

                  _nameOfOrganizationController.text = "";
                  _locationController.text = "";
                  _registrationDateController.text = "";
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Color(0xfffdcb03),
                  ),
                ),
              ),
            ],
          );
        });
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
