import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/scan/components/Scan_protector_screen.dart';
import 'package:renderscan/screen/scan/scan_api.dart';
import 'package:renderscan/screen/mint/mint_screen.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/screen/scan/scan_modal.dart';

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
  void initState() {
    ScanApi().hasAccountActivated("").then((resp) {
      bool isActivated = resp.isActivated;
      if (!isActivated) {
        return ScanProtectorScreen();
      }
    }).catchError((err) {
      log.e(err);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future<void> setupCameras() async {
      cameras = await availableCameras();
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    }

    Uint8List fromBase64(base64Str) => base64Decode(base64Str);

    void scanFunction() async {
      print("> Res Test");
      print(ResolutionPreset.medium);
      print("> Capturing image");
      var pictureFile = await controller.takePicture();
      print("> Processing image");
      ScanResponse resp = await ScanApi().cutImageFromServer(pictureFile);
      if (resp.isError == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: "Close",
              onPressed: () {},
            ),
            content: Text("Server is busy, please try again"),
            duration: const Duration(milliseconds: 3000),
            backgroundColor: Colors.red,
            width: size.width * 0.9, // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
        return context.read<ScanProvider>().resetProvider();
      }
      log.i(">> Setting scan state");
      log.i(">> Filename " + resp.filename.toString());
      context
          .read<ScanProvider>()
          .setScanStatus(fromBase64(resp.file), resp.filename.toString());
      context.read<ScanProvider>().setLoading(false);
    }

    void ScanImage() {
      log.i("> Setting Loader");
      context.read<ScanProvider>().setLoading(true);
      scanFunction();
    }

    goToMintScreen() {
      log.i(">> In Mint Function");
      String filename =
          Provider.of<ScanProvider>(context, listen: false).filename;

      ScanApi()
          .save(filename)
          .then((value) => print(value))
          .catchError((err) => print(err));

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MintScreen(
                imageSource: context.watch<ScanProvider>().imageSource,
                filename: context.watch<ScanProvider>().filename)),
      );
    }

    void retry() => context.read<ScanProvider>().resetProvider();

    Widget cameraWidget(context) {
      var camera = controller.value;
      // fetch screen size
      final size = MediaQuery.of(context).size;
      // calculate scale depending on screen and camera ratios
      // this is actually size.aspectRatio / (1 / camera.aspectRatio)
      // because camera preview size is received as landscape
      // but we're calculating for portrait orientation
      var deviceRatio = (size.aspectRatio * 1.35);

      var scale = deviceRatio * camera.aspectRatio;
      // to prevent scaling down, invert the value
      if (scale < 1) scale = 1 / scale;
      return Transform.scale(
        scale: scale,
        child: Center(
          child: CameraPreview(controller),
        ),
      );
    }

    Widget scanner() {
      return SafeArea(
          child: Scaffold(
              body: FutureBuilder(
                  future: setupCameras(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState.name == "done")
                      return Container(
                          color: kprimaryBackGroundColor,
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.075,
                              ),
                              SizedBox(
                                width: size.width,
                                height: size.height * .65,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        child: SizedBox(
                                            width: size.width,
                                            child: cameraWidget(context))),
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
                                              : context
                                                      .watch<ScanProvider>()
                                                      .isLoading
                                                  ? spinkit
                                                  : null),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  child: context
                                              .watch<ScanProvider>()
                                              .isFetched ==
                                          false
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: size.width * 0.65,
                                                child: TextButton(
                                                  onPressed: ScanImage,
                                                  child: Text(
                                                    "Scan",
                                                    style: kPrimartFont(
                                                        kPrimaryLightColor,
                                                        18,
                                                        FontWeight.bold),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          spreadRadius: 1,
                                                          blurRadius: 2,
                                                          color:
                                                              kprimaryNeuLight,
                                                          offset:
                                                              Offset(-1, -1)),
                                                      BoxShadow(
                                                          spreadRadius: 1,
                                                          blurRadius: 8,
                                                          color:
                                                              kprimaryNeuDark,
                                                          offset: Offset(5, 5)),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: size.width * 0.45,
                                                decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          spreadRadius: 1,
                                                          blurRadius: 2,
                                                          color:
                                                              kprimaryNeuLight,
                                                          offset:
                                                              Offset(-1, -1)),
                                                      BoxShadow(
                                                          spreadRadius: 1,
                                                          blurRadius: 8,
                                                          color:
                                                              kprimaryNeuDark,
                                                          offset: Offset(5, 5)),
                                                    ]),
                                                child: TextButton(
                                                    onPressed: () => retry(),
                                                    child: Text(
                                                      "Retry",
                                                      style: kPrimartFont(
                                                          kPrimaryLightColor,
                                                          14,
                                                          FontWeight.bold),
                                                    )),
                                              ),
                                              Container(
                                                width: size.width * 0.45,
                                                decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          spreadRadius: 1,
                                                          blurRadius: 2,
                                                          color:
                                                              kprimaryNeuLight,
                                                          offset:
                                                              Offset(-1, -1)),
                                                      BoxShadow(
                                                          spreadRadius: 1,
                                                          blurRadius: 8,
                                                          color:
                                                              kprimaryNeuDark,
                                                          offset: Offset(5, 5)),
                                                    ]),
                                                child: TextButton(
                                                  onPressed: goToMintScreen,
                                                  child: Text("Next",
                                                      style: kPrimartFont(
                                                          kPrimaryLightColor,
                                                          14,
                                                          FontWeight.bold)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                            ],
                          ));
                    return Container(
                      child: spinkit,
                      alignment: Alignment.center,
                    );
                  })));
    }

    scanProtectionWrapper() {
      ScanProtectionResponse scanProtectionResponse = ScanProtectionResponse(
          message: "", isActivated: false, hasError: false);
      return FutureBuilder(
        initialData: scanProtectionResponse,
        future: ScanApi().hasAccountActivated(""),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState.name == "done") {
            final data = snapshot.data as ScanProtectionResponse;
            if (!data.isActivated) return ScanProtectorScreen();
            return scanner();
          }
          return Container(
            child: spinkit,
            alignment: Alignment.center,
          );
        },
      );
    }

    return scanProtectionWrapper();
  }

  @override
  void dispose() {
    controller.dispose();
    cameras = [];
    super.dispose();
  }
}
