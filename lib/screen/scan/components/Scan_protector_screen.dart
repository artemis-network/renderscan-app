import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/scan/components/activate_button.dart';
import 'package:renderscan/screen/scan/components/input_field.dart';
import 'package:renderscan/screen/scan/scan_api.dart';
import 'package:renderscan/common/utils/logger.dart';

import 'package:renderscan/screen/welcome/welcome_screen.dart';

class ScanProtectorScreen extends StatefulWidget {
  @override
  State<ScanProtectorScreen> createState() => _ScanProtectorScreenState();
}

class _ScanProtectorScreenState extends State<ScanProtectorScreen> {
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
    return Container(
      padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      height: size.height,
      width: size.width,
      color: kPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Enter activation code to access all the features",
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
    );
  }
}
