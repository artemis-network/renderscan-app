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
        color: kprimaryBackGroundColor,
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/1.jpg"),
              radius: 50,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        color: kprimaryNeuLight,
                        offset: Offset(-1, -1)),
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 8,
                        color: kprimaryNeuDark,
                        offset: Offset(5, 5)),
                  ]),
              width: size.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_circle_left,
                            color: Colors.white, size: 48),
                        Text("Unlimited Clips",
                            style: kPrimartFont(
                                kPrimaryLightColor, 14, FontWeight.bold)),
                      ]),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(children: [
                        const Icon(
                          Icons.image_aspect_ratio_outlined,
                          color: Colors.white,
                          size: 48,
                        ),
                        Text("HD Clips",
                            style: kPrimartFont(
                                kPrimaryLightColor, 14, FontWeight.bold)),
                      ]),
                      Column(children: [
                        const Icon(
                          Icons.stop_circle_outlined,
                          color: Colors.white,
                          size: 48,
                        ),
                        Text("No Watermarks",
                            style: kPrimartFont(
                                kPrimaryLightColor, 14, FontWeight.bold)),
                      ]),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Column(
            children: [
              const ButtonWidget(
                text: "3 Scans - 1000 REND",
              ),
              const ButtonWidget(
                text: "4 Scans - 1500 REND",
              ),
              const ButtonWidget(
                text: "5 Scans - 2000 REND",
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

  const ButtonWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void fun() => log.d("hello");
    final size = MediaQuery.of(context).size;
    final pad = (size.width * 0.25);

    return Padding(
        padding: EdgeInsets.fromLTRB(pad, 10, pad, 10),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style:
                        kPrimartFont(kPrimaryLightColor, 14, FontWeight.bold),
                  ))
            ],
          ),
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 2,
                    color: kprimaryNeuLight,
                    offset: Offset(-1, -1)),
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 8,
                    color: kprimaryNeuDark,
                    offset: Offset(5, 5)),
              ]),
        ));
  }
}
