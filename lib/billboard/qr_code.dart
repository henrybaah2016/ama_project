import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

// import 'package:esys_flutter_share/esys_flutter_share.dart';
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

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  static const routeName = "/qrcode";

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final _key = GlobalKey();
  final _qrKey = GlobalKey();
  String _message = "";

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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: _message.isEmpty ? Text("") : Text(_message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String _billBoardInfo =
        ModalRoute.of(context)!.settings.arguments as String;
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
            'Download Qr Code',
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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImage(
              key: _qrKey,
              data: _billBoardInfo,
              size: 300,
            ),
            const SizedBox(height: 20),
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
                  _takeScreenshot();
                },
                child: Text(
                  'Save QR Code',
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
