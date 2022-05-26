import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';

import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';

import 'package:renderscan/screen/login/login_screen.dart';
import 'package:renderscan/screen/profile/component/profiile_buttons.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/screen/home/home_provider.dart';
import 'package:renderscan/screen/scan/scan_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    void logOut() {
      print("> Logging out");
      Storage().logout();
      context.read<ScanProvider>().resetProvider();
      context.read<HomeProvider>().setCurrentIndex(2);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
        (route) => false,
      );
    }

    goToUpgradePage() {
      context.read<HomeProvider>().setCurrentIndex(4);
    }

    bool allowClose = true;

    void fun() => (null);
    return DoubleBack(
        condition: allowClose,
        onConditionFail: () {
          setState(() {
            allowClose = !allowClose;
          });
        },
        child: Padding(
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
                                  style: kPrimartFont(kPrimaryLightColor, 14,
                                      FontWeight.normal));
                            }),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: ProfileButton(
                      text: "Upgrade",
                      icon: Icons.upgrade,
                      onClick: goToUpgradePage,
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
                        SizedBox(height: 10),
                        ProfileButton(
                          text: "Help & Support",
                          icon: Icons.help_center_outlined,
                          onClick: fun,
                        ),
                        SizedBox(height: 10),
                        ProfileButton(
                          text: "Settings",
                          icon: Icons.settings_outlined,
                          onClick: fun,
                        ),
                        SizedBox(height: 10),
                        ProfileButton(
                          text: "Refer a Friend",
                          icon: Icons.person_add_outlined,
                          onClick: fun,
                        ),
                        SizedBox(height: 10),
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
        ));
  }
}
