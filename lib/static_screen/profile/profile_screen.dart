import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  String displayName = "";
  String language = "";
  String region = "";

  @override
  void initState() {
    ProfileApi().getProfile().then((value) {
      setState(() {
        displayName = value.displayName;
        language = value.language;
        region = value.region;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    formModal(String value) {
      getValue() {
        if (value == "Display Name") return displayName;
        if (value == "Language") return language;
        if (value == "Region") return region;
      }

      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                elevation: 100,
                backgroundColor:
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                child: Container(
                    constraints: BoxConstraints(minHeight: 150),
                    height: 150,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: getValue(),
                          cursorColor: kPrimaryLightColor,
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            decorationThickness: 3,
                            decorationColor: context
                                .watch<ThemeProvider>()
                                .getBackgroundColor(),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: context
                                .watch<ThemeProvider>()
                                .getBackgroundColor(),
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.text_fields,
                              size: 30,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getBackgroundColor(),
                            ),
                            label: Text(
                              value,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getBackgroundColor(),
                                  20,
                                  FontWeight.normal),
                              maxLines: 1,
                            ),
                          ),
                          onChanged: (e) {
                            if (value == "Display Name") {
                              setState(() {
                                displayName = e;
                              });
                            }
                            if (value == "Language") {
                              setState(() {
                                language = e;
                              });
                            }
                            if (value == "Region") {
                              setState(() {
                                region = e;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: context
                                          .watch<ThemeProvider>()
                                          .getBackgroundColor(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Update",
                                    style: kPrimartFont(
                                        context
                                            .watch<ThemeProvider>()
                                            .getPriamryFontColor(),
                                        22,
                                        FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )));
          });
    }

    submit() {
      Profile profile = new Profile(
          displayName: displayName, region: region, language: language);
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
                                    return Column(
                                      children: [
                                        InkWell(
                                          child: ProfileInput(
                                            controller: TextEditingController(
                                                text: displayName),
                                            labelText: "Display name",
                                            icon: Icons.display_settings,
                                          ),
                                          onTap: () =>
                                              formModal("Display Name"),
                                        ),
                                        InkWell(
                                          child: ProfileInput(
                                            controller: TextEditingController(
                                                text: language),
                                            labelText: "Language",
                                            icon: Icons.link,
                                          ),
                                          onTap: () => formModal("Language"),
                                        ),
                                        InkWell(
                                          child: ProfileInput(
                                            controller: TextEditingController(
                                                text: region),
                                            labelText: "Region",
                                            icon: Icons.link,
                                          ),
                                          onTap: () => formModal("Region"),
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
                                                  horizontal: 20,
                                                  vertical: 10)),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
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
              ),
            )));
  }
}
