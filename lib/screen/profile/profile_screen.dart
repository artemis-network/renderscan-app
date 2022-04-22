import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    void fun() => (null);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
          color: kprimaryBackGroundColor,
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/1.jpg'),
                  radius: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  children: [
                    FutureBuilder(
                        future: Storage().getItem('username'),
                        builder: (context, snapshot) {
                          return Text(snapshot.data.toString(),
                              style: GoogleFonts.poppins(
                                  color: kPrimaryLightColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold));
                        }),
                    FutureBuilder(
                        future: Storage().getItem('email'),
                        builder: (context, snapshot) {
                          return Text(snapshot.data.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: kPrimaryLightColor,
                              ));
                        }),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        primary: kPrimaryColor,
                        backgroundColor: kPrimaryLightColor,
                        minimumSize: Size(size.width * 0.4, 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        )),
                    child: Text(
                      "Upgrade to PRO",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    onPressed: fun),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(70, 10, 70, 0),
                child: Column(
                  children: [
                    ButtonWidget(
                        text: "Privacy", icon: Icons.privacy_tip_outlined),
                    ButtonWidget(
                      text: "Help & Support",
                      icon: Icons.help_center_outlined,
                    ),
                    ButtonWidget(
                      text: "Settings",
                      icon: Icons.settings_outlined,
                    ),
                    ButtonWidget(
                      text: "Refer a Friend",
                      icon: Icons.person_add_outlined,
                    ),
                    ButtonWidget(
                      text: "Logout",
                      icon: Icons.logout_outlined,
                    ),
                  ],
                ),
              ))
            ],
          )),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  ButtonWidget({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void fun() => (null);
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
              primary: kPrimaryLightColor,
              backgroundColor: kPrimaryColor,
              minimumSize: Size(size.width, 50),
              elevation: 8,
              shadowColor: kPrimaryShadow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              )),
        ));
  }
}
