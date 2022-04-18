// ignore_for_file: unnecessary_const

import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:renderscan/screen/scan/scan_api.dart';
import 'package:renderscan/common/components/rounded_button.dart';
import 'package:renderscan/screen/mint/mint_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late List<CameraDescription> cameras;
  late CameraController controller;
  late Uint8List decodeImg;

  XFile? pictureFile;

  void setImage(baseStr) {
    setState(() {
      decodeImg = const Base64Codec().decode(baseStr);
    });
  }

  Future<void> setupCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    await controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    // fetch screen size
    final size = MediaQuery.of(context).size;

    void cutFunction() async {
      pictureFile = await controller.takePicture();
      var uri = await cutImageFromServer(pictureFile!);
      setImage(uri);
    }

    goToMintScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MintScreen(img: decodeImg);
          },
        ),
      );
    }

    return FutureBuilder(
        future: setupCameras(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
              body: Column(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * .75,
                child: Stack(
                  children: [
                    Positioned(
                        child: SizedBox(
                      child: CameraPreview(controller),
                    )),
                    Positioned(
                      top: size.height * .2,
                      width: size.width * 1,
                      child: Container(
                          child: decodeImg != null
                              ? Image.memory(
                                  decodeImg,
                                )
                              : null),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: decodeImg == null
                    ? RoundedButton(
                        text: "Scan",
                        press: cutFunction,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ElevatedButton(
                              onPressed: null, child: Text("Retry")),
                          ElevatedButton(
                              onPressed: goToMintScreen,
                              child: const Text("Next")),
                        ],
                      ),
              )
            ],
          ));
        });
  }
}
