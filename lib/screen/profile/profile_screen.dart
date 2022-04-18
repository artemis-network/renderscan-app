import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    void fun() => print("hello");
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              const SizedBox(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/1.jpg'),
                  radius: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  children: [
                    Text("akashmadduru",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("akashmadduru@gmail.com",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
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
    void fun() => print("hello");
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
