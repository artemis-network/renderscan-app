import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/scan/scan_api.dart';
import 'package:renderscan/screen/mint/mint_screen.dart';
import 'package:renderscan/common/components/loader.dart';

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
      print("> Res Test");
      print(ResolutionPreset.medium);
      print("> Capturing image");
      var pictureFile = await controller.takePicture();
      print("> Processing image");
      var resp = await cutImageFromServer(pictureFile);
      if (resp['error'] == true || resp == null) {
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
      print("> Setting scan state");
      context.read<ScanProvider>().setScanStatus(resp["nft"]);
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

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kprimaryBackGroundColor,
        ),
        body: FutureBuilder(
            future: setupCameras(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState.name == "done")
                return Container(
                    color: kprimaryBackGroundColor,
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width,
                          height: size.height * .645,
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
                                        : context
                                                .watch<ScanProvider>()
                                                .isLoading
                                            ? spinkit
                                            : null),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.bottomCenter,
                            child: context.watch<ScanProvider>().isFetched ==
                                    false
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    color: kprimaryNeuLight,
                                                    offset: Offset(-1, -1)),
                                                BoxShadow(
                                                    spreadRadius: 1,
                                                    blurRadius: 8,
                                                    color: kprimaryNeuDark,
                                                    offset: Offset(5, 5)),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: size.width * 0.45,
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    color: kprimaryNeuLight,
                                                    offset: Offset(-1, -1)),
                                                BoxShadow(
                                                    spreadRadius: 1,
                                                    blurRadius: 8,
                                                    color: kprimaryNeuDark,
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
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    color: kprimaryNeuLight,
                                                    offset: Offset(-1, -1)),
                                                BoxShadow(
                                                    spreadRadius: 1,
                                                    blurRadius: 8,
                                                    color: kprimaryNeuDark,
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
            }));
  }

  @override
  void dispose() {
    controller.dispose();
    cameras = [];
    super.dispose();
  }
}
