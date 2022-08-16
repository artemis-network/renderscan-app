import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/screens/scan/scan_api.dart';
import 'package:renderscan/screens/scan/scan_modal.dart';

class ImportScreen extends StatefulWidget {
  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  String filename = "";

  List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            state: currentStep >= 0 ? StepState.complete : StepState.indexed,
            content: StepOne(context),
            title: Text("Import",
                style: kPrimartFont(Colors.black, 18, FontWeight.normal))),
        Step(
            isActive: currentStep >= 1,
            state: currentStep >= 1 ? StepState.complete : StepState.indexed,
            content: stepTwo(context),
            title: Text("Save",
                style: kPrimartFont(Colors.black, 18, FontWeight.normal))),
        Step(
            isActive: currentStep >= 2,
            state: currentStep >= 2 ? StepState.complete : StepState.indexed,
            content: stepThree(context),
            title: Text("Mint",
                style: kPrimartFont(Colors.black, 18, FontWeight.normal))),
      ];

  int currentStep = 0;
  Uint8List? img;

  Uint8List fromBase64(base64Str) => base64Decode(base64Str);

  Future pickImage() async {
    try {
      final image = await ImagePicker().getImage(source: ImageSource.gallery);
      ScanResponse resp = await ScanApi().cutImageFromServer(image);
      var url = resp.file?.replaceAll("data:image/png;base64,", "").toString();
      if (image == null) return;
      setState(() {
        img = fromBase64(url);
        filename = resp.filename.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.greenAccent,
        content: Text("Image Cropped",
            style: kPrimartFont(Colors.blueGrey, 22, FontWeight.bold)),
      ));
    } on PlatformException catch (e) {
      log.e(e);
    }
  }

  Future saveImage() async {
    try {
      await ScanApi().save(filename).then((value) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text("File Saved",
              style: kPrimartFont(Colors.blueGrey, 22, FontWeight.bold)),
        ));
      });
    } on PlatformException catch (e) {
      log.e(e);
    }
  }

  StepOne(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.photo_outlined,
                    size: 30,
                    color:
                        context.watch<ThemeProvider>().getPriamryFontColor()),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Select Image",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      24,
                      FontWeight.bold),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
              height: 350,
              width: 420,
              child: getRes(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [],
              ),
            ),
            InkWell(
                onTap: pickImage,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("Upload",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          22,
                          FontWeight.bold)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            color: context
                                .watch<ThemeProvider>()
                                .getFavouriteColor())
                      ]),
                ))
          ],
        ));
  }

  stepTwo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.save,
                  size: 30,
                  color: context.watch<ThemeProvider>().getPriamryFontColor()),
              SizedBox(
                width: 15,
              ),
              Text(
                "Save Image",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    24,
                    FontWeight.bold),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            height: 350,
            width: 420,
            child: getRes(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [],
            ),
          ),
          InkWell(
              onTap: saveImage,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text("Save",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        22,
                        FontWeight.bold)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          color: context
                              .watch<ThemeProvider>()
                              .getFavouriteColor())
                    ]),
              ))
        ],
      ),
    );
  }

  stepThree(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.currency_bitcoin,
                  size: 30,
                  color: context.watch<ThemeProvider>().getPriamryFontColor()),
              SizedBox(
                width: 15,
              ),
              Text(
                "Mint NFT",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    24,
                    FontWeight.bold),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            height: 350,
            width: 420,
            child: getRes(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [],
            ),
          ),
        ],
      ),
    );
  }

  getRes() {
    if (img != null)
      return RotatedBox(
        quarterTurns: 15,
        child: InkWell(
          child: Image.memory(
            img!,
            height: 300,
            fit: BoxFit.fitWidth,
          ),
        ),
      );
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            drawerEnableOpenDragGesture: false,
            backgroundColor:
                context.watch<ThemeProvider>().getBackgroundColor(),
            drawer: Drawer(
              child: SideBar(),
            ),
            body: Theme(
              data: ThemeData(
                  primarySwatch: Colors.blue,
                  colorScheme: ColorScheme.light(
                      primary: Colors.black, secondary: Colors.black)),
              child: Stepper(
                type: StepperType.horizontal,
                steps: getSteps(),
                elevation: 200,
                currentStep: currentStep,
                onStepContinue: () {
                  if (currentStep == 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavigationScreen()));
                  }
                  setState(() => {if (currentStep < 3) currentStep += 1});
                },
                onStepCancel: () =>
                    setState(() => {if (currentStep > 0) currentStep -= 1}),
                onStepTapped: (int index) =>
                    setState(() => currentStep = index),
              ),
            )));
  }
}