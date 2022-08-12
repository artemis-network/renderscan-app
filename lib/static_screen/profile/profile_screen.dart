import 'dart:math';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:renderscan/common/utils/logger.dart';

import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/static_screen/navigation/navigation_provider.dart';
import 'package:renderscan/static_screen/profile/component/profile_input.dart';
import 'package:renderscan/static_screen/profile/profile_api.dart';
import 'package:renderscan/static_screen/profile/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renderscan/transistion_screen/scan/scan_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    Profile profile =
        Provider.of<ProfileProvider>(context, listen: false).profile;
    String displayName = profile.displayName;
    String email = profile.email;

    final size = MediaQuery.of(context).size;

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

    submit(context) async {
      Profile changedProfile =
          Provider.of<ProfileProvider>(context, listen: false).profile;

      ProfileApi()
          .updateProfile(changedProfile)
          .then((value) => handleRepsonse(value));
    }

    handleEmailUpdate(ProfileResponse profile) async {
      print("> Logging out");
      log.i(profile.error);
      log.i(profile.message);

      var color = profile.error ? Colors.redAccent : Colors.greenAccent;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: color,
          content: Text(
            profile.message,
            style: kPrimartFont(Colors.blueGrey, 22, FontWeight.bold),
          )));
      if (!profile.error) {
        var future =
            Future.delayed(const Duration(milliseconds: 3000), () async {
          Storage().logout();
          context.read<NavigationProvider>().setCurrentIndex(0);
          context.read<ScanProvider>().resetProvider();
        });
        future.then((value) {});
      }
    }

    updateEmail(context) async {
      Profile changedProfile =
          Provider.of<ProfileProvider>(context, listen: false).profile;

      ProfileApi()
          .updateEmail(changedProfile.email)
          .then((value) => handleEmailUpdate(value));
    }

    bool allowClose = true;

    final List<String> images = [
      "assets/avtars/1.png",
      "assets/avtars/2.png",
      "assets/avtars/3.png",
      "assets/avtars/4.png",
      "assets/avtars/5.png",
      "assets/avtars/6.png",
      "assets/avtars/7.png",
      "assets/avtars/8.png",
      "assets/avtars/9.png",
      "assets/avtars/10.png",
    ];

    final random = new Random().nextInt(11);

    return SafeArea(
        child: DoubleBack(
            condition: allowClose,
            onConditionFail: () {
              setState(() {
                allowClose = !allowClose;
              });
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                    color: context.watch<ThemeProvider>().getBackgroundColor(),
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    height: size.height,
                    width: size.width,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getBackgroundColor(),
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
                                    .getPriamryFontColor(),
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: FutureBuilder(
                              future: Storage().getItem("username"),
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  final username = snapshot.data as String;
                                  var url =
                                      "https://renderscan-user-avatars.s3.ap-south-1.amazonaws.com/" +
                                          username +
                                          '.png';
                                  log.i(url);
                                  return CircleAvatar(
                                    backgroundImage: NetworkImage(url),
                                    radius: 48,
                                  );
                                }
                                return CircleAvatar(
                                  backgroundImage: AssetImage(images[random]),
                                  radius: 48,
                                );
                              })),
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
                            onPressed: () async {
                              final image = await _picker.getImage(
                                  source: ImageSource.gallery);
                              await ProfileApi().updateAvatar(image);
                            },
                            child: Text("Choose a photo")),
                        Expanded(
                            child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  ProfileInput(
                                    defaultValue: displayName,
                                    labelText: "Display name",
                                    icon: Icons.display_settings,
                                    onChange: (e) => context
                                        .read<ProfileProvider>()
                                        .setDisplayName(e),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: TextButton(
                                  onPressed: () => submit(context),
                                  child: Text("Save"),
                                  style: ButtonStyle(
                                      textStyle: MaterialStateProperty.all(
                                          kPrimartFont(
                                              context
                                                  .watch<ThemeProvider>()
                                                  .getPriamryFontColor(),
                                              24,
                                              FontWeight.bold)),
                                      elevation: MaterialStateProperty.all(10),
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
                                              .getBackgroundColor())),
                                ),
                              ),
                              ProfileInput(
                                defaultValue: email,
                                labelText: "Update Email",
                                icon: Icons.display_settings,
                                onChange: (e) =>
                                    context.read<ProfileProvider>().setEmail(e),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: TextButton(
                                  onPressed: () => updateEmail(context),
                                  child: Text("Update Email"),
                                  style: ButtonStyle(
                                      textStyle: MaterialStateProperty.all(
                                          kPrimartFont(
                                              context
                                                  .watch<ThemeProvider>()
                                                  .getPriamryFontColor(),
                                              24,
                                              FontWeight.bold)),
                                      elevation: MaterialStateProperty.all(10),
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
                                              .getBackgroundColor())),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    )),
              ),
            )));
  }
}
