import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/common/utils/logger.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: Column(children: [
        ButtonWidget(
          text: "Help & Support",
          icon: Icons.help_center_outlined,
        ),
        ButtonWidget(text: "FAQ's", icon: Icons.privacy_tip_outlined),
      ]),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  const ButtonWidget({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void fun() => log.d("hello");
    final size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
        child: TextButton(
          onPressed: fun,
          child: Stack(
            children: <Widget>[
              Align(alignment: Alignment.centerLeft, child: Icon(icon)),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              primary: Colors.blue,
              backgroundColor: Colors.white,
              minimumSize: Size(size.width, 50),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              )),
        ));
  }
}
