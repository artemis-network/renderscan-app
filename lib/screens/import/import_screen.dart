import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/screens/scan/scan_api.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/logger.dart';

class ImportScreen extends StatefulWidget {
  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  String filename = "";
  late Uint8List imageFile;
  bool isUploaded = false;
  bool isLoading = false;

  List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            state: currentStep >= 0 ? StepState.complete : StepState.indexed,
            content: StepOne(context),
            title: AutoSizeText("Import",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.normal))),
        Step(
            isActive: currentStep >= 1,
            state: currentStep >= 1 ? StepState.complete : StepState.indexed,
            content: stepTwo(context),
            title: AutoSizeText("Clip",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.normal))),
        Step(
            isActive: currentStep >= 2,
            state: currentStep >= 2 ? StepState.complete : StepState.indexed,
            content: stepThree(context),
            title: AutoSizeText("Save",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.normal))),
      ];

  int currentStep = 0;

  Uint8List fromBase64(base64Str) => base64Decode(base64Str);

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().getImage(source: ImageSource.gallery);
      final img = await image!.readAsBytes();
      setState(() {
        isUploaded = true;
        imageFile = img;
      });
    } on PlatformException catch (e) {
      log.e(e);
    }
  }

  clipImage() {
    try {
      setState(() {
        isLoading = true;
      });
      ScanApi().cutUploadedImage(imageFile).then((value) {
        var url =
            value.file?.replaceAll("data:image/png;base64,", "").toString();
        log.i("her" + url.toString());
        setState(() {
          imageFile = fromBase64(url);
          filename = value.filename.toString();
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.greenAccent,
          content: AutoSizeText("Image Clipped",
              style: kPrimartFont(Colors.blueGrey, 22, FontWeight.bold)),
        ));
      }).catchError((error) {
        log.e(error);
      });
    } on PlatformException catch (e) {
      log.e(e);
    }
  }

  saveImage() {
    ScanApi().save(filename).then((value) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.greenAccent,
        content: AutoSizeText("File Saved",
            style: kPrimartFont(Colors.blueGrey, 22, FontWeight.bold)),
      ));
    });
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
                AutoSizeText(
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
              child: isUploaded
                  ? InkWell(
                      child: Image.memory(
                        imageFile,
                        height: 300,
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  : Container(
                      child: AutoSizeText(
                        "Upload image",
                        style: kPrimartFont(Colors.white, 22, FontWeight.bold),
                      ),
                    ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [],
              ),
            ),
            !isUploaded
                ? InkWell(
                    onTap: pickImage,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: AutoSizeText("Upload",
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
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
                : InkWell(
                    onTap: () {
                      setState(() {
                        isUploaded = false;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: AutoSizeText("Reset",
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
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
              AutoSizeText(
                "Clip",
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
            child: !isLoading && isUploaded
                ? InkWell(
                    child: Image.memory(
                      imageFile,
                      height: 300,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : spinkit(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [],
            ),
          ),
          InkWell(
              onTap: clipImage,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: AutoSizeText("Clip",
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
              AutoSizeText(
                "Save",
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
            child: isUploaded
                ? InkWell(
                    child: Image.memory(
                      imageFile,
                      height: 300,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : Container(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [],
            ),
          ),
          InkWell(
              onTap: saveImage,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: AutoSizeText("Save",
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

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Image.asset(
                "assets/icons/back.png",
                height: 24,
                width: 24,
              ),
              margin: EdgeInsets.only(left: 18),
            ),
          ),
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        ),
        key: scaffoldKey,
        drawerEnableOpenDragGesture: false,
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        drawer: Drawer(
          child: SideBar(),
        ),
        body: Theme(
          data: ThemeData(
              colorScheme: context.watch<ThemeProvider>().isDarkTheme()
                  ? ColorScheme.dark()
                  : ColorScheme.light()),
          child: Stepper(
            type: StepperType.vertical,
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
            onStepTapped: (int index) => setState(() => currentStep = index),
          ),
        ));
  }
}
