import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/scan/components/activate_button.dart';
import 'package:renderscan/screen/scan/components/input_field.dart';
import 'package:renderscan/screen/scan/scan_api.dart';
import 'package:renderscan/common/utils/logger.dart';

import 'package:renderscan/screen/welcome/welcome_screen.dart';

class HomProtectorScreen extends StatefulWidget {
  @override
  State<HomProtectorScreen> createState() => _HomProtectorScreenState();
}

class _HomProtectorScreenState extends State<HomProtectorScreen> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    void onCodeChange(String _code) {
      setState(() {
        code = _code;
      });
    }

    goToScanPage() {
      ScanApi().hasAccountActivated(code).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const WelcomeScreen();
            },
          ),
        );
      }).catchError((err) {
        log.e(err);
      });
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        height: size.height,
        width: size.width,
        color: kPrimaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Activation code",
              style: kPrimartFont(kPrimaryLightColor, 20, FontWeight.bold),
            ),
            InputField(
                labelText: "Code",
                icon: Icons.lock,
                onChange: (value) => onCodeChange(value)),
            SizedBox(
              height: size.height * 0.05,
            ),
            ActivateButton(text: "Activate", press: goToScanPage)
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.picture_in_picture,
            size: 30,
            color: kPrimaryLightColor,
          ),
          Icon(Icons.person, size: 30, color: kPrimaryLightColor),
          Icon(Icons.home, size: 46, color: kPrimaryLightColor),
          Icon(
            Icons.account_balance_wallet,
            size: 30,
            color: kPrimaryLightColor,
          ),
          Icon(
            Icons.upgrade,
            size: 30,
            color: kPrimaryLightColor,
          ),
        ],
        color: kprimaryBottomBarColor,
        buttonBackgroundColor: kPrimaryColor,
        backgroundColor: kprimaryBackGroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {},
        letIndexChange: (index) => true,
      ),
    );
  }
}
