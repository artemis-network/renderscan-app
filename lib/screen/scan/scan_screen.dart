import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/screen/scan/scan_api.dart';
import 'package:renderscan/screen/mint/mint_screen.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late List<CameraDescription> cameras;
  late CameraController controller;

  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.teal : Colors.tealAccent,
        ),
      );
    },
  );

  Future<void> setupCameras() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    await controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String? base64String;
  XFile? pictureFile;

  Uint8List getImage() {
    return const Base64Codec().decode(base64String.toString());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void cutFunction() async {
      pictureFile = await controller.takePicture();
      var uri = await cutImageFromServer(pictureFile!);
      setState(() {
        base64String = uri;
      });
    }

    goToMintScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MintScreen(img: getImage());
          },
        ),
      );
    }

    retry() {
      setState(() {
        base64String = null;
        cameras = cameras;
        controller = controller;
      });
    }

    return FutureBuilder(
        future: setupCameras(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState.name == "done") {
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
                        width: size.width,
                        child: CameraPreview(controller),
                      )),
                      Positioned(
                        top: size.height * .2,
                        width: size.width * 1,
                        child: Container(
                            child: base64String != null
                                ? Image.memory(
                                    getImage(),
                                  )
                                : null),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: base64String == null
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(100, 5, 100, 0),
                          child: Column(
                            children: [
                              OutlinedButton(
                                onPressed: cutFunction,
                                child: const Icon(
                                  Icons.camera,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                                style: OutlinedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                    padding: const EdgeInsets.all(15),
                                    elevation: 5,
                                    backgroundColor: Colors.white,
                                    shadowColor: Colors.grey.withOpacity(0.2)),
                              ),
                              Text("Scan",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: Colors.blue))
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () => retry(),
                                child: const Text("Retry")),
                            ElevatedButton(
                                onPressed: goToMintScreen,
                                child: const Text("Next")),
                          ],
                        ),
                )
              ],
            ));
          } else {
            return const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
