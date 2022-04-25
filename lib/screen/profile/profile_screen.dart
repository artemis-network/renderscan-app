import 'package:flutter/material.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    void logOut() {
      print("> Logging out");
      Storage().logout();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
        (route) => false,
      );
    }

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
                              style: kPrimartFont(
                                  kPrimaryLightColor, 18, FontWeight.bold));
                        }),
                    FutureBuilder(
                        future: Storage().getItem('email'),
                        builder: (context, snapshot) {
                          return Text(snapshot.data.toString(),
                              style: kPrimartFont(
                                  kPrimaryLightColor, 14, FontWeight.normal));
                        }),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: ButtonWidget(
                  text: "Upgrade",
                  icon: Icons.upgrade,
                  onClick: fun,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(70, 10, 70, 0),
                child: Column(
                  children: [
                    ButtonWidget(
                      text: "Privacy",
                      icon: Icons.privacy_tip_outlined,
                      onClick: fun,
                    ),
                    ButtonWidget(
                      text: "Help & Support",
                      icon: Icons.help_center_outlined,
                      onClick: fun,
                    ),
                    ButtonWidget(
                      text: "Settings",
                      icon: Icons.settings_outlined,
                      onClick: fun,
                    ),
                    ButtonWidget(
                      text: "Refer a Friend",
                      icon: Icons.person_add_outlined,
                      onClick: fun,
                    ),
                    ButtonWidget(
                      text: "Log out",
                      icon: Icons.logout_outlined,
                      onClick: logOut,
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
  final Function onClick;

  ButtonWidget(
      {Key? key, required this.text, required this.icon, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
      child: TextButton(
          onPressed: () => onClick(),
          child: Container(
              width: size.width,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        icon,
                        color: kPrimaryLightColor,
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        style: kPrimartFont(
                            kPrimaryLightColor, 14, FontWeight.bold),
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
                  ]))),
    );
  }
}
