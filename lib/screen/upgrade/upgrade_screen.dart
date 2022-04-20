import 'package:flutter/material.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/constants.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        color: KprimaryBackGroundColor,
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/1.jpg"),
              radius: 50,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            decoration: BoxDecoration(color: kPrimaryColor),
            width: size.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Unlimeted Clips",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.arrow_circle_left, color: Colors.white)
                    ]),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [
                      Text(
                        "HD Clips",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.image_aspect_ratio_outlined,
                        color: Colors.white,
                      )
                    ]),
                    Column(children: [
                      Text(
                        "No Watermarks",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.stop_circle_outlined,
                        color: Colors.white,
                      )
                    ]),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Column(
            children: [
              const ButtonWidget(
                text: "Annual-1000 rend",
                icon: Icons.upgrade,
              ),
              const ButtonWidget(
                text: "Monthly-120 rend",
                icon: Icons.upgrade,
              ),
              SizedBox(
                child: null,
                height: size.height * 0.05,
              ),
              Text("7 Days Free Trail",
                  style: GoogleFonts.poppins(color: kPrimaryLightColor)),
              Text("Cancel Anytime",
                  style: GoogleFonts.poppins(color: kPrimaryLightColor))
            ],
          )
        ]));
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
    final pad = (size.width * 0.25);

    return Padding(
        padding: EdgeInsets.fromLTRB(pad, 10, pad, 10),
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
              primary: kPrimaryLightColor,
              backgroundColor: kPrimaryColor,
              minimumSize: Size(size.width, 50),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              )),
        ));
  }
}
