import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/screen/scan/scan_api.dart';
import 'package:renderscan/screen/mint/mint_screen.dart';
import 'package:renderscan/screen/scan/scan_loader.dart';

import 'package:renderscan/screen/scan/scan_provider.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  // camera state
  late List<CameraDescription> cameras;
  late CameraController controller;
  XFile? pictureFile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future<void> setupCameras() async {
      cameras = await availableCameras();
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    }

    void scanFunction() async {
      print("> Capturing image");
      var pictureFile = await controller.takePicture();
      print("> Processing image");
      var uri = await cutImageFromServer(pictureFile);
      print("> Setting scan state");
      context.read<ScanProvider>().setScanStatus(uri);
      context.read<ScanProvider>().setLoading(false);
    }

    void ScanImage() {
      print("> Setting Loader");
      context.read<ScanProvider>().setLoading(true);
      scanFunction();
    }

    goToMintScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MintScreen(img: context.watch<ScanProvider>().imageSource)),
      );
    }

    void retry() {
      context.read<ScanProvider>().resetProvider();
    }

    return FutureBuilder(
        future: setupCameras(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState.name == "done")
            return Container(
                color: KprimaryBackGroundColor,
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height * .725,
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
                                child: context
                                            .watch<ScanProvider>()
                                            .isFetched ==
                                        true
                                    ? Image.memory(
                                        context
                                            .watch<ScanProvider>()
                                            .imageSource,
                                      )
                                    : context.watch<ScanProvider>().isLoading
                                        ? spinkit
                                        : null),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: context.watch<ScanProvider>().isFetched == false
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(60, 10, 60, 0),
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: ScanImage,
                                    child: Text(
                                      "Scan",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: TextButton.styleFrom(
                                        minimumSize: Size(90, 20),
                                        side: const BorderSide(
                                            color: Colors.transparent),
                                        padding: const EdgeInsets.all(15),
                                        elevation: 5,
                                        backgroundColor: kPrimaryColor,
                                        shadowColor:
                                            Colors.grey.withOpacity(0.2)),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          return spinkit;
        });
  }

  @override
  void dispose() {
    controller.dispose();
    cameras = [];
    super.dispose();
  }
}
