import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';

import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/static_screen/navigation/navigation_provider.dart';
import 'package:renderscan/static_screen/profile/component/profile_input.dart';
import 'package:renderscan/transistion_screen/scan/scan_provider.dart';

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
      context.read<NavigationProvider>().setCurrentIndex(0);
      context.read<ScanProvider>().resetProvider();
    }

    bool allowClose = true;

    return DoubleBack(
        condition: allowClose,
        onConditionFail: () {
          setState(() {
            allowClose = !allowClose;
          });
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
                color: context.watch<ThemeProvider>().getBackgroundColor(),
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    Text("Edit Your Profile",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            18,
                            FontWeight.bold)),
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
                                        context
                                            .watch<ThemeProvider>()
                                            .getPriamryFontColor(),
                                        18,
                                        FontWeight.bold));
                              }),
                        ],
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Text("Choose a photo")),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Column(
                        children: [
                          ProfileInput(
                            labelText: "Username",
                            icon: Icons.person,
                            onChange: () {},
                          ),
                          ProfileInput(
                            labelText: "Display name",
                            icon: Icons.display_settings,
                            onChange: () {},
                          ),
                          ProfileInput(
                            labelText: "Link",
                            icon: Icons.link,
                            onChange: () {},
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text("save"),
                                  style: ButtonStyle(
                                      textStyle: MaterialStateProperty.all(
                                          kPrimartFont(
                                              context
                                                  .watch<ThemeProvider>()
                                                  .getPriamryFontColor(),
                                              18,
                                              FontWeight.normal)),
                                      backgroundColor:
                                          MaterialStateProperty.all(context
                                              .watch<ThemeProvider>()
                                              .getPriamryFontColor())),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextButton(
                                    onPressed: () => logOut(),
                                    style: ButtonStyle(
                                        textStyle: MaterialStateProperty.all(
                                            kPrimartFont(
                                                context
                                                    .watch<ThemeProvider>()
                                                    .getPriamryFontColor(),
                                                18,
                                                FontWeight.normal)),
                                        backgroundColor:
                                            MaterialStateProperty.all(context
                                                .watch<ThemeProvider>()
                                                .getPriamryFontColor())),
                                    child: Text("logout")),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                )),
          ),
        ));
  }
}
