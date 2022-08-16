import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/create/component/subbutton.dart';
import 'package:renderscan/screens/generate/generate_screen.dart';
import 'package:renderscan/screens/import/import_screen.dart';
import 'package:renderscan/screens/scan/scan_screen.dart';

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
      body: SingleChildScrollView(
        child: Container(
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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Text(
                  "Select an image from camera roll or gallery or generate random nfts from text input",
                  textAlign: TextAlign.center,
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      14,
                      FontWeight.w500),
                ),
              ),
              Expanded(
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  SubButton(
                      buttonLabel: "Scan", onClick: () => goToScanScreen()),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  SubButton(
                      buttonLabel: "Import", onClick: () => goToImportScreen()),
                  SizedBox(
                    height: 20,
                  ),
                  SubButton(
                      buttonLabel: "Generate",
                      onClick: () => goToGenerateScreen()),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
