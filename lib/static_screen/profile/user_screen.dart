import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/static_screen/profile/profile_api.dart';
import 'package:renderscan/static_screen/profile/profile_screen.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    bool allowClose = true;
    return Container(
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
                      Text("Profile",
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              24,
                              FontWeight.bold)),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                        decoration: BoxDecoration(
                            color: context
                                .watch<ThemeProvider>()
                                .getBackgroundColor(),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 100,
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor()
                                      .withOpacity(0.22),
                                  offset: Offset(0, 0)),
                            ]),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/1.jpg'),
                              radius: 48,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(
                                      future: Storage().getItem('username'),
                                      builder: (context, snapshot) {
                                        return RowItem(
                                            label: "Username",
                                            value: snapshot.data.toString());
                                      }),
                                  FutureBuilder(
                                      initialData: Profile(
                                        displayName: "",
                                        language: "",
                                        region: "",
                                      ),
                                      future: ProfileApi().getProfile(),
                                      builder: ((context, snapshot) {
                                        var profile = snapshot.data as Profile;
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RowItem(
                                              label: "Display Name",
                                              value: profile.displayName,
                                            ),
                                            RowItem(
                                              label: "Language",
                                              value: profile.language,
                                            ),
                                            RowItem(
                                              label: "Country",
                                              value: profile.region,
                                            ),
                                          ],
                                        );
                                      })),
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: BalanceWidget(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RowButtons(
                                text: "Edit Profile",
                                press: () {
                                  Navigator.of(context).push(PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      child: ProfileScreen(),
                                      ctx: context,
                                      duration: Duration(milliseconds: 300),
                                      fullscreenDialog: true,
                                      childCurrent: UserScreen()));
                                },
                                icon: Icons.edit_outlined),
                            RowButtons(
                                text: "Share Profile",
                                press: () {},
                                icon: Icons.share_outlined),
                          ],
                        ),
                      ),
                    ],
                  )),
            )));
  }
}

class RowItem extends StatelessWidget {
  final String label;
  final String value;

  RowItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getSecondaryFontColor(),
              15,
              FontWeight.normal),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          value,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              15,
              FontWeight.bold),
        ),
      ],
    );
  }
}

class RowButtons extends StatelessWidget {
  final String text;
  final Function press;
  final IconData icon;
  const RowButtons({
    Key? key,
    required this.text,
    required this.press,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press(),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 100,
                  color: context
                      .watch<ThemeProvider>()
                      .getHighLightColor()
                      .withOpacity(0.22),
                  offset: Offset(0, 0)),
            ]),
        child: Row(children: [
          Icon(
            icon,
            size: 22,
            color: context.watch<ThemeProvider>().getPriamryFontColor(),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: kPrimartFont(
                context.watch<ThemeProvider>().getSecondaryFontColor(),
                14,
                FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
