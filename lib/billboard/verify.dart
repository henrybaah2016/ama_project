import 'package:bilbo/home/home.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        color: Color(0x7fbbc07),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 200.0,
                              width: 250.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[],
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xfffbbc07),
        child: const Icon(Icons.qr_code_2_outlined),
      ),
    );
  }
}
