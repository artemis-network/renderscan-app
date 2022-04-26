import 'package:flutter/material.dart';

import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/login/login_screen.dart';
import 'package:renderscan/screen/profile/component/profiile_buttons.dart';

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
                child: ProfileButton(
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
                    ProfileButton(
                      text: "Privacy",
                      icon: Icons.privacy_tip_outlined,
                      onClick: fun,
                    ),
                    ProfileButton(
                      text: "Help & Support",
                      icon: Icons.help_center_outlined,
                      onClick: fun,
                    ),
                    ProfileButton(
                      text: "Settings",
                      icon: Icons.settings_outlined,
                      onClick: fun,
                    ),
                    ProfileButton(
                      text: "Refer a Friend",
                      icon: Icons.person_add_outlined,
                      onClick: fun,
                    ),
                    ProfileButton(
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
