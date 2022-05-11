import 'dart:io';

import 'package:bilbo/billboard/result.dart';
import 'package:bilbo/home/home.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class VerifyBillboard extends StatefulWidget {
  VerifyBillboard({Key? key}) : super(key: key);

  @override
  _VerifyBillboardState createState() => _VerifyBillboardState();
}

class _VerifyBillboardState extends State<VerifyBillboard> {
  // String? qrCodeResult;
  // int camera = 1;
  // bool backCamera = true;

  // Future<void> _scan() async {
  // ScanResult codeSanner = await BarcodeScanner.scan(
  // options: ScanOptions(
  // useCamera: camera,
  // ),
  // );
  // setState(() {
  // qrCodeResult = codeSanner.rawContent;
  // });
  // }
  final qrKey = GlobalKey();
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }

    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return Container(
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xff056839),
                size: 24.0,
              ),
            );
          },
        ),
        title: const Text(
          'Verify Billboard',
          style: TextStyle(
            color: Color(0xff3d3c3d),
            fontSize: 20,
            fontWeight: FontWeight.w500,
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
              Icons.more_vert_rounded,
              color: Color(0xff056839),
              size: 30.0,
            ),
            offset: Offset(0, kToolbarHeight),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 25),
                  child: Text(
                    'logout',
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
          // IconButton(
          // icon: backCamera ? Icon(Icons.camera_rear) : Icon(Icons.camera),
          // onPressed: () {
          // setState(() {
          // backCamera = !backCamera;
          // camera = backCamera ? 1 : -1;
          // });
          // },
          // )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(
            bottom: 10,
            child: buildResult(),
          )
        ],
      ),
    );
  }

  Widget buildResult() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xfffbbc07),
      ),
      child: Text(
        barcode != null ? "Result : ${barcode!.code}" : "Scan a code",
        maxLines: 5,
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
        borderWidth: 10,
        borderLength: 20,
        borderRadius: 10,
        borderColor: Color(0xff056839),
      ),
    );
  }

  void onQRViewCreated(QRViewController mController) {
    setState(() {
      controller = mController;
    });

    controller!.scannedDataStream.listen((mBarCode) {
      setState(() {
        barcode = mBarCode;
      });

      print("BAR CODE CONTENT ${barcode!.code}");

      if (barcode != null) {
        Navigator.of(context)
            .popAndPushNamed(Result.routeName, arguments: barcode!.code);
      }
    });
  }
}
