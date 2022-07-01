import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/generate/generate_screen.dart';
import 'package:renderscan/screen/import/import_screen.dart';
import 'package:renderscan/screen/scan/scan_screen.dart';

class CreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    goToScanScreen() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ScanScreen()));
    }

    goToImportScreen() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ImportScreen()));
    }

    goToGenerateScreen() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GenerateScreen()));
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: SideBar(),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: Column(
          children: [
            Topbar(
              popSideBar: () => scaffoldKey.currentState?.openDrawer(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/lion.png',
                    height: 225,
                    width: 225,
                  )),
            ),
            Text(
              "Create your own NFTs",
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  22,
                  FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Select an image from camera roll or gallery or generate random nfts from text input",
                textAlign: TextAlign.center,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    14,
                    FontWeight.w500),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SubButton(
                      buttonLabel: "Scan", onClick: () => goToScanScreen()),
                  SizedBox(
                    width: 25,
                  ),
                  SubButton(
                      buttonLabel: "Import", onClick: () => goToImportScreen()),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            SizedBox(
              height: 20,
            ),
            MainButton(
                buttonLabel: "Generate", onClick: () => goToGenerateScreen())
          ],
        ),
      ),
    );
  }
}

class SubButton extends StatelessWidget {
  String buttonLabel;
  Function onClick;

  SubButton({required this.buttonLabel, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            buttonLabel,
            style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                20,
                FontWeight.bold),
          ),
          decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 100,
                    color: context
                        .watch<ThemeProvider>()
                        .getHighLightColor()
                        .withOpacity(0.22),
                    offset: Offset(0, 0)),
              ])),
    );
  }
}

class MainButton extends StatelessWidget {
  String buttonLabel;
  Function onClick;

  MainButton({required this.buttonLabel, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Text(
            buttonLabel,
            style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                26,
                FontWeight.bold),
          ),
          decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 100,
                    color: context
                        .watch<ThemeProvider>()
                        .getHighLightColor()
                        .withOpacity(0.22),
                    offset: Offset(0, 0)),
              ])),
    );
  }
}
