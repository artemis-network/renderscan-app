import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/common/components/loader.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/static_screen/mint/mint_screen.dart';
import 'package:renderscan/transistion_screen/scan/scan_api.dart';
import 'package:renderscan/transistion_screen/scan/scan_modal.dart';
import 'package:renderscan/transistion_screen/scan/scan_provider.dart';

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

    Uint8List fromBase64(base64Str) => base64Decode(base64Str);

    void scanFunction() async {
      print("> Res Test");
      print(ResolutionPreset.medium);
      print("> Capturing image");
      var pictureFile = await controller.takePicture();
      print("> Processing image");
      ScanResponse resp = await ScanApi().cutImageFromServer(pictureFile);
      log.i("HERE");
      log.i(resp.file);
      log.i(resp.isError);
      log.i(resp.isError);
      log.i("END HERE");
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
      var url = resp.file?.replaceAll("data:image/png;base64,", "").toString();
      log.i(url);
      context
          .read<ScanProvider>()
          .setScanStatus(fromBase64(url), resp.filename.toString());
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
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        clipBehavior: Clip.antiAlias,
        child: Transform.scale(
          scale: scale,
          child: Center(
            child: CameraPreview(controller),
          ),
        ),
      );
    }

    var scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            drawerEnableOpenDragGesture: false,
            drawer: Drawer(
              child: SideBar(),
            ),
            body: Container(
                color: context.watch<ThemeProvider>().getBackgroundColor(),
                child: Column(
                  children: [
                    Topbar(
                      popSideBar: () => scaffoldKey.currentState?.openDrawer(),
                    ),
                    FutureBuilder(
                        future: setupCameras(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState.name == "done")
                            return Container(
                                color: context
                                    .watch<ThemeProvider>()
                                    .getBackgroundColor(),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.045,
                                    ),
                                    Container(
                                      width: size.width * 0.9,
                                      height: size.height * 0.625,
                                      child: Stack(
                                        children: [
                                          cameraWidget(context),
                                          Positioned(
                                            top: size.height * .15,
                                            width: size.width * 1,
                                            child: Container(
                                                child: context
                                                            .watch<
                                                                ScanProvider>()
                                                            .isFetched ==
                                                        true
                                                    ? Image.memory(
                                                        context
                                                            .watch<
                                                                ScanProvider>()
                                                            .imageSource,
                                                      )
                                                    : context
                                                            .watch<
                                                                ScanProvider>()
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
                                                padding:
                                                    const EdgeInsets.fromLTRB(
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
                                                              context
                                                                  .watch<
                                                                      ThemeProvider>()
                                                                  .getPriamryFontColor(),
                                                              24,
                                                              FontWeight.bold),
                                                        ),
                                                      ),
                                                      constraints:
                                                          BoxConstraints(
                                                              minHeight: 80),
                                                      decoration: BoxDecoration(
                                                          color: context
                                                              .watch<
                                                                  ThemeProvider>()
                                                              .getBackgroundColor(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                spreadRadius: 0,
                                                                blurRadius: 100,
                                                                color: context
                                                                    .watch<
                                                                        ThemeProvider>()
                                                                    .getHighLightColor()
                                                                    .withOpacity(
                                                                        0.66),
                                                                offset: Offset(
                                                                    0, 0)),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      width: size.width * 0.45,
                                                      decoration: BoxDecoration(
                                                          color: context
                                                              .watch<
                                                                  ThemeProvider>()
                                                              .getBackgroundColor(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                spreadRadius: 1,
                                                                blurRadius: 100,
                                                                color: context
                                                                    .watch<
                                                                        ThemeProvider>()
                                                                    .getHighLightColor()
                                                                    .withOpacity(
                                                                        0.66),
                                                                offset: Offset(
                                                                    0, 0)),
                                                          ]),
                                                      child: TextButton(
                                                          onPressed: () =>
                                                              retry(),
                                                          child: Text(
                                                            "Retry",
                                                            style: kPrimartFont(
                                                                context
                                                                    .watch<
                                                                        ThemeProvider>()
                                                                    .getPriamryFontColor(),
                                                                14,
                                                                FontWeight
                                                                    .bold),
                                                          )),
                                                    ),
                                                    Container(
                                                      width: size.width * 0.45,
                                                      decoration: BoxDecoration(
                                                          color: context
                                                              .watch<
                                                                  ThemeProvider>()
                                                              .getBackgroundColor(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                spreadRadius: 0,
                                                                blurRadius: 100,
                                                                color: context
                                                                    .watch<
                                                                        ThemeProvider>()
                                                                    .getHighLightColor()
                                                                    .withOpacity(
                                                                        0.66),
                                                                offset: Offset(
                                                                    5, 5)),
                                                          ]),
                                                      child: TextButton(
                                                        onPressed:
                                                            goToMintScreen,
                                                        child: Text("Next",
                                                            style: kPrimartFont(
                                                                context
                                                                    .watch<
                                                                        ThemeProvider>()
                                                                    .getPriamryFontColor(),
                                                                14,
                                                                FontWeight
                                                                    .bold)),
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
                        })
                  ],
                ))));
  }

  @override
  void dispose() {
    controller.dispose();
    cameras = [];
    super.dispose();
  }
}