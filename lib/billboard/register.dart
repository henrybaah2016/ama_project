import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

// import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:bilbo/billboard/qr_code.dart';
import 'package:bilbo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:bilbo/home/home.dart';
import 'package:bilbo/login/login.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RegisterBillboard extends StatefulWidget {
  RegisterBillboard({Key? key}) : super(key: key);

  @override
  _RegisterBillboardState createState() => _RegisterBillboardState();
}

class _RegisterBillboardState extends State<RegisterBillboard> {
  final _key = GlobalKey();
  final _nameOfOrganizationController = TextEditingController();
  final _locationController = TextEditingController();
  final _registrationDateController = TextEditingController();
  String _billBoardInfo = "";
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  File? _imageFileData;
  String _message = "";

  ScreenshotController screenshotController = ScreenshotController();

  Position? userCurrentPosition;

  var geoLocator = Geolocator();

  LocationPermission? _locationPermission;

  String? formattedAddress;

  Future<void> _showPickCameraDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Capture Billboard",
              style: TextStyle(color: Color(0xff3e3e3e)),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: const Text("Open Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Color(0xfffdcb03),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _openCamera(BuildContext context) async {
    final XFile? pickedFile = (await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 500,
      maxWidth: 500,
    ));

    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      }
    });

    final File? file = File(pickedFile!.path);
    _imageFileData = file;

    Navigator.pop(context);
  }

  checkIfLocationPermissionIsAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    } else {
      locateUserPosition();
    }
  }

  locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    userCurrentPosition = cPosition;

    formattedAddress = await UtilMethods.searchAddressForGeographicCoordinates(
        userCurrentPosition!, context);
    print("This is your formatted Address $formattedAddress");
  }

  @override
  initState() {
    super.initState();
    checkIfLocationPermissionIsAllowed();
  }

  Future<void> _saveToGallery(File imageFile) async {}

  void _takeScreenshot() async {
    final RenderRepaintBoundary? boundary =
        _key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    final ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();
    // final result = await ImageGallerySaver.saveImage(pngBytes);
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(pngBytes),
      quality: 90,
      name: 'screenshot-${DateTime.now()}.png',
    );

    setState(() {
      _message = "New Screenshot successfully saved to gallery";
    });
    print(result);
  }

  _validateFields() {
    if (_nameOfOrganizationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter the name of the organization'),
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
        'Name of Organization : ${_nameOfOrganizationController.text}, Location: $formattedAddress, Registration Date:  ${_registrationDateController.text}';
    Navigator.of(context)
        .pushNamed(QrCodeScreen.routeName, arguments: _billBoardInfo);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _key,
      child: Scaffold(
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
                alignment: Alignment.center,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black26),
                ),
                margin: const EdgeInsets.only(bottom: 15),
                child: _imageFile != null
                    ? Image.file(
                        File(_imageFile!.path),
                        fit: BoxFit.cover,
                      )
                    : GestureDetector(
                        onTap: () {
                          _showPickCameraDialog(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 50),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xff056839),
                            border: Border.all(
                              color: Color(0xff056839),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Capture Billboard",
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
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
                    // _takeScreenshot();
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
      ),
    );
  }
}
