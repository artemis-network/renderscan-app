import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/constants.dart';
import 'package:image_picker/image_picker.dart';

class ImportScreen extends StatefulWidget {
  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
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
            content: Container(),
            title: Text("Save",
                style: kPrimartFont(Colors.black, 18, FontWeight.normal))),
        Step(
            isActive: currentStep >= 2,
            state: currentStep >= 2 ? StepState.complete : StepState.indexed,
            content: Container(),
            title: Text("Mint",
                style: kPrimartFont(Colors.black, 18, FontWeight.normal))),
      ];

  int currentStep = 0;
  File? img;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imgTemp = File(image.path);
      log.e(">> HERE " + imgTemp.toString());
      log.i(">> HERE " + imgTemp.toString());
      setState(() => img = imgTemp);
      return image;
    } on PlatformException catch (e) {
      log.e(e);
    }
  }

  StepOne(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              height: 300,
              width: 400,
              child: getRes(),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.watch<ThemeProvider>().getHighLightColor()),
            ),
            InkWell(
              onTap: pickImage,
              child: Text("Upload"),
            )
          ],
        ));
  }

  getRes() {
    if (img != null)
      return InkWell(
        child: Image.file(
          img!,
          height: 300,
          fit: BoxFit.fitWidth,
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
            drawer: Drawer(
              child: SideBar(),
            ),
            body: Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              elevation: 200,
              currentStep: currentStep,
              onStepContinue: () =>
                  setState(() => {if (currentStep < 3) currentStep += 1}),
              onStepCancel: () =>
                  setState(() => {if (currentStep > 0) currentStep -= 1}),
              onStepTapped: (int index) => setState(() => currentStep = index),
            )));
  }
}
