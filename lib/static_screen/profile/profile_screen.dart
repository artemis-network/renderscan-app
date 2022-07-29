import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';

import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/static_screen/profile/component/profile_input.dart';
import 'package:renderscan/static_screen/profile/profile_api.dart';
import 'package:renderscan/static_screen/profile/profile_provider.dart';
import 'package:image_picker/image_picker.dart';

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
                            onPressed: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
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
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
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
                                          elevation:
                                              MaterialStateProperty.all(10),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 10)),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                          backgroundColor:
                                              MaterialStateProperty.all(context
                                                  .watch<ThemeProvider>()
                                                  .getBackgroundColor())),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
                      ],
                    )),
              ),
            )));
  }
}
