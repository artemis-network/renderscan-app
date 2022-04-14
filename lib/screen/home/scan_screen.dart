// ignore_for_file: unnecessary_const

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:renderscan/http/image.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/provider/image.dart';
import 'package:renderscan/components/rounded_button.dart';
import 'package:renderscan/screen/home/mint_screen.dart';

class ScanScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const ScanScreen({this.cameras, Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController controller;
  XFile? pictureFile;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.medium,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
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
    var camera = controller.value;
    // fetch screen size
    final size = MediaQuery.of(context).size;
    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * camera.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    void cutFunction() async {
      pictureFile = await controller.takePicture();
      var uri = await cutImageFromServer(pictureFile!);
      context.read<ImageP>().setImage(uri);
      setState(() {});
    }

    goToMintScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MintScreen(img: context.watch<ImageP>().decodedImg);
          },
        ),
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                        child: context.watch<ImageP>().decodedImg != null
                            ? Image.memory(
                                context.watch<ImageP>().decodedImg,
                              )
                            : null),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: context.watch<ImageP>().decodedImg == null
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
  }
}
