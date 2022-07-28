import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:renderscan/common/utils/logger.dart';

import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/static_screen/profile/component/profile_input.dart';
import 'package:renderscan/static_screen/profile/profile_api.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var displayName = new TextEditingController(text: "");
  var username = new TextEditingController(text: "");
  var language = new TextEditingController(text: "");
  var region = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // void logOut() {
    //   Storage().logout();
    //   context.read<NavigationProvider>().setCurrentIndex(0);
    //   context.read<ScanProvider>().resetProvider();
    // }

    handleRepsonse(ProfileResponse response) {
      if (!response.error)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(
              "Changes updated!",
              style: kPrimartFont(Colors.blueGrey, 22, FontWeight.bold),
            )));
      else
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Something went wrong!",
              style: kPrimartFont(Colors.blueGrey, 22, FontWeight.bold),
            )));
    }

    submit() {
      Profile profile = new Profile(
          displayName: displayName.text,
          region: region.text,
          language: language.text);
      ProfileApi()
          .updateProfile(profile)
          .then((value) => handleRepsonse(value));
    }

    bool allowClose = true;

    return SafeArea(
        child: DoubleBack(
            condition: allowClose,
            onConditionFail: () {
              setState(() {
                allowClose = !allowClose;
              });
            },
            child: Scaffold(
              body: Container(
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Icon(
                              Icons.arrow_back_outlined,
                              size: 36,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getBackgroundColor(),
                            ),
                          ),
                        ),
                      ),
                      Text("Edit Your Profile",
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              24,
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
                      TextButton(
                          onPressed: () {}, child: Text("Choose a photo")),
                      Expanded(
                          child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Column(
                          children: [
                            FutureBuilder(
                                initialData: Profile(
                                  displayName: "",
                                  language: "",
                                  region: "",
                                ),
                                future: ProfileApi().getProfile(),
                                builder: ((context, snapshot) {
                                  var profile = snapshot.data as Profile;
                                  displayName.text = profile.displayName;
                                  username.text = profile.displayName;
                                  language.text = profile.language;
                                  region.text = profile.region;

                                  return Column(
                                    children: [
                                      ProfileInput(
                                        controller: displayName,
                                        labelText: "Display name",
                                        icon: Icons.display_settings,
                                      ),
                                      ProfileInput(
                                        controller: language,
                                        labelText: "Language",
                                        icon: Icons.link,
                                      ),
                                      ProfileInput(
                                        controller: region,
                                        labelText: "Region",
                                        icon: Icons.link,
                                      )
                                    ],
                                  );
                                })),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () => submit(),
                                    child: Text("Save"),
                                    style: ButtonStyle(
                                        textStyle: MaterialStateProperty.all(
                                            kPrimartFont(
                                                context
                                                    .watch<ThemeProvider>()
                                                    .getPriamryFontColor(),
                                                24,
                                                FontWeight.normal)),
                                        elevation:
                                            MaterialStateProperty.all(10),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        backgroundColor:
                                            MaterialStateProperty.all(context
                                                .watch<ThemeProvider>()
                                                .getPriamryFontColor())),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  )),
            )));
  }
}
