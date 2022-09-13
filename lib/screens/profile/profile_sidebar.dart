import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';

import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/faq/faq_screen.dart';
import 'package:renderscan/screens/feedback/feedback_screen.dart';
import 'package:renderscan/screens/navigation/navigation_provider.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/screens/profile/profile_api.dart';
import 'package:renderscan/screens/profile/profile_provider.dart';
import 'package:renderscan/screens/profile/profile_screen.dart';
import 'package:renderscan/screens/scan/scan_provider.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/storage.dart';

import 'package:url_launcher/url_launcher.dart';

class ProfileSideBarScreen extends StatefulWidget {
  @override
  State<ProfileSideBarScreen> createState() => _ProfileSideBarScreenState();
}

class _ProfileSideBarScreenState extends State<ProfileSideBarScreen> {
  String displayName = "";
  String language = "";
  String region = "";
  String email = "";
  final String webUrl = "https://www.renderverse.io";

  String url =
      "https://renderscan-user-avatars.s3.ap-south-1.amazonaws.com/avatar.png";

  Future<void> launchPage() async {
    if (await canLaunchUrl(Uri.parse(webUrl))) {
      await launchUrl(Uri.parse(webUrl));
    }
    throw 'Could not launch $webUrl';
  }

  @override
  void initState() {
    ProfileApi().getProfile().then((value) async {
      var u = await Storage().getItem("avatarUrl");
      u = u.toString();
      setState(() {
        displayName = value.displayName;
        language = value.language;
        region = value.region;
        email = value.email;
        url = u!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [BalanceWidget()],
          ),
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Image.asset(
                "assets/icons/cancel.png",
                height: 24,
                width: 24,
              ),
              margin: EdgeInsets.only(left: 18),
            ),
          ),
        ),
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(child: SideBar()),
        body: Container(
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                  decoration: BoxDecoration(
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
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
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(url),
                            backgroundColor: context
                                .watch<ThemeProvider>()
                                .getFavouriteColor(),
                            radius: 48,
                          ),
                          Positioned(
                              right: 0,
                              bottom: -12,
                              child: GestureDetector(
                                child: Image.asset(
                                  "assets/icons/edit.png",
                                  height: 46,
                                  width: 46,
                                ),
                                onTap: () {
                                  Profile profile = Profile(
                                      displayName: displayName,
                                      region: region,
                                      language: language,
                                      email: email);
                                  context
                                      .read<ProfileProvider>()
                                      .setProfile(profile);
                                  Navigator.of(context).push(PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      child: ProfileScreen(),
                                      ctx: context,
                                      duration: Duration(milliseconds: 300),
                                      fullscreenDialog: true,
                                      childCurrent: ProfileSideBarScreen()));
                                },
                              ))
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              displayName,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  18,
                                  FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FutureBuilder(
                                future: Storage().getItem('username'),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return AutoSizeText(
                                      "@" + snapshot.data.toString(),
                                      style: kPrimartFont(
                                          context
                                              .watch<ThemeProvider>()
                                              .getSecondaryFontColor(),
                                          16,
                                          FontWeight.normal),
                                    );
                                  }
                                  return Container();
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            FutureBuilder(
                                future: Storage().getItem("address"),
                                builder: ((context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: context
                                                    .watch<ThemeProvider>()
                                                    .getBackgroundColor(),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(0, 0),
                                                      blurRadius: 2,
                                                      color: context
                                                          .watch<
                                                              ThemeProvider>()
                                                          .getHighLightColor())
                                                ]),
                                            child: Container(
                                              child: AutoSizeText(
                                                snapshot.data
                                                        .toString()
                                                        .substring(0, 5) +
                                                    "....." +
                                                    snapshot.data
                                                        .toString()
                                                        .substring(
                                                            snapshot.data
                                                                    .toString()
                                                                    .length -
                                                                6,
                                                            snapshot.data
                                                                    .toString()
                                                                    .length -
                                                                1),
                                                style: kPrimartFont(
                                                    context
                                                        .watch<ThemeProvider>()
                                                        .getPriamryFontColor(),
                                                    12,
                                                    FontWeight.bold),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: snapshot.data
                                                      .toString()));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: AutoSizeText(
                                                          "Address copied!")));
                                            },
                                            child: Image.asset(
                                              "assets/icons/copy.png",
                                              height: 16,
                                              width: 16,
                                            ))
                                      ],
                                    );
                                  }
                                  return Container();
                                })),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ColumnButtons(
                          text: "Terms & Conditions",
                          press: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  final size = MediaQuery.of(context).size;
                                  return SingleChildScrollView(
                                      child: Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: context
                                        .watch<ThemeProvider>()
                                        .getBackgroundColor(),
                                    elevation: 4,
                                    child: Container(
                                        width: size.width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Column(
                                          children: [
                                            AutoSizeText(
                                              "Terms of Service",
                                              textAlign: TextAlign.center,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  24,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "please read on to learn the rules and restrictions that govern your use of our products, services and applications, including, but not limited to, our web interface located at https://renderverse.io/ (“site”) and our corresponding mobile application(s) (collectively, the “services”). these terms of service (the “terms”) are a binding contract between you and renderverse . as used in these terms, “we”, “us”, or “our” also refers to renderverse. you must agree to and accept all of the terms, or you don’t have the right to use the services. your use of the services in any way means that you agree to all of these terms, and these terms will remain in effect while you use the services. these terms include the provisions in this document, as well as those ain our privacy policy, and any other terms and conditions that we may reference or incorporate into these terms from time to time.",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "do not purchase rndv token if you are not an expert in dealing with cryptographic tokens and blockchain-based software systems. prior to purchasing rndv, you should carefully consider the terms listed below and, to the extent necessary, consult an appropriate lawyer, accountant, or tax professional. if any of the following terms are unacceptable to you, you should not purchase rndv.",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "purchaser agrees to buy, and company agrees to sell, the rndv tokens in accordance with the following terms",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "1. Changes to the Terms of Service RenderVerse reserves the right to change or modify these Terms at any time and in our sole discretion. If we make changes to these Terms, we will provide notice of such changes, such as by sending an email notification, providing notice through the Service, or updating the “Last Updated” date at the beginning of these Terms. By continuing to access or use the Service, you confirm your acceptance of the revised Terms and all the terms incorporated therein by reference. We encourage you to review the Terms frequently to ensure that you understand the terms and conditions that apply when you access or use the Service. If you do not agree to the revised Terms, you may not access or use the Service.",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "2. Connecting a digital wallet Action on the RenderVerse website such as: initiating an transaction or offering to purchase a Crypto Asset, can be performed strictly by linking your digital wallets on supported bridge extensions. We advise you to read the details on their website before you elect to use them. Before initiating an Auction or offering to purchase an asset through Renderverse you will need to connect a supported electronic wallet extension and unlock your digital wallets with that extension.",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "ALL TRANSACTIONS INITIATED THROUGH OUR SERVICE ARE FACILITATED AND RUN BY THESE THIRD-PARTY ELECTRONIC WALLET EXTENSIONS, AND BY USING OUR SERVICES YOU AGREE THAT YOU ARE GOVERNED BY THE TERMS OF SERVICE AND PRIVACY POLICY FOR THE APPLICABLE EXTENSIONS.",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "3. All purchases of RNDV are final ALL PURCHASES OF RNDV ARE FINAL.THE PURCHASER ACKNOWLEDGES THAT NEITHER THE COMPANY NOR ANY OF ITS AFFILIATES, DIRECTORS OR SHAREHOLDERS ARE REQUIRED TO PROVIDE A REFUND FOR ANY REASON.",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "4.2 The Purchaser has such knowledge and experience in financial and business matters that the Investor can evaluate the merits and risks of such investment, is able to incur a complete loss of such investment without impairing the Purchaser’s financial condition, and is able to bear the economic risk of such investment for an indefinite period of time. ",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "5. Cryptocurrencies The Company makes no representations as to this Agreement amounting to an Investment. The purchase of Tokens is not an Investment opportunity and should not be treated as such.",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "6. Availability of Website/Services Subject to the terms and conditions of this Agreement and our other policies and procedures, we shall use commercially reasonable efforts to attempt to provide this Site and the Services on a twenty-four (24) hours a day, seven (7) days a week basis. You acknowledge and agree that from time to time this Site may be inaccessible or inoperable for any reason including, but not limited to, equipment malfunctions; periodic maintenance, repairs or replacements that we undertake from time to time.",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            AutoSizeText(
                                              "7. Risk of Mining Attacks As with other decentralised cryptographic tokens, RNDV are susceptible to attacks by miners in the course of validating RNDV transactions , including, but not limited, to double-spend attacks, majority mining power attacks, and selfish-mining attacks.",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "8. Risk of Hacking and Security Weaknesses Hackers or other malicious groups or organisations may attempt to interfere with the platform or RNDV in a variety of ways, including, but not limited to, malware attacks, denial of service attacks, consensus-based attacks, Sybil attacks, smurfing, and spoofing.",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            AutoSizeText(
                                              "THE PURCHASER EXPRESSLY AGREES THAT THE PURCHASER IS PURCHASING RNDV AT THE PURCHASER’S SOLE RISK AND THAT RNDV IS PROVIDED ON AN “AS IS” BASIS WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, WARRANTIES OF TITLE OR IMPLIED WARRANTIES, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. WITHOUT LIMITING THE FOREGOING, NONE OF THE RENDERVERSE TEAM WARRANTS THAT THE PROCESS FOR PURCHASING HERO WILL BE UNINTERRUPTED OR ERROR-FREE.",
                                              textAlign: TextAlign.left,
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getPriamryFontColor(),
                                                  12,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 2,
                                                              color: context
                                                                  .watch<
                                                                      ThemeProvider>()
                                                                  .getHighLightColor())
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: context
                                                            .watch<
                                                                ThemeProvider>()
                                                            .getBackgroundColor()),
                                                    child: AutoSizeText(
                                                      "Close",
                                                      style: kPrimartFont(
                                                        context
                                                            .watch<
                                                                ThemeProvider>()
                                                            .getPriamryFontColor(),
                                                        22,
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                  ));
                                });
                          },
                          icon: "assets/icons/refer.png"),
                      ColumnButtons(
                          text: "Help & FAQ",
                          press: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return FAQScreen();
                            }));
                          },
                          icon: "assets/icons/faq.png"),
                      ColumnButtons(
                          text: "Feedback",
                          press: () {
                            return Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return FeedbackScreen();
                            }));
                          },
                          icon: "assets/icons/feedback.png"),
                      ColumnButtons(
                          text: "Logout",
                          press: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: context
                                        .watch<ThemeProvider>()
                                        .getBackgroundColor(),
                                    elevation: 4,
                                    child: Container(
                                        height: 250,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: AutoSizeText(
                                                "Logout ",
                                                textAlign: TextAlign.center,
                                                style: kPrimartFont(
                                                    context
                                                        .watch<ThemeProvider>()
                                                        .getPriamryFontColor(),
                                                    24,
                                                    FontWeight.bold),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons
                                                      .circleExclamation,
                                                  size: 20,
                                                  color: context
                                                      .watch<ThemeProvider>()
                                                      .getHighLightColor(),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Container(
                                                  child: AutoSizeText(
                                                    "Are you sure?",
                                                    textAlign: TextAlign.center,
                                                    style: kPrimartFont(
                                                        context
                                                            .watch<
                                                                ThemeProvider>()
                                                            .getPriamryFontColor(),
                                                        18,
                                                        FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: context
                                                            .watch<
                                                                ThemeProvider>()
                                                            .getHighLightColor()),
                                                    child: AutoSizeText(
                                                      "No",
                                                      style: kPrimartFont(
                                                        context
                                                            .watch<
                                                                ThemeProvider>()
                                                            .getPriamryFontColor(),
                                                        22,
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                GestureDetector(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 2,
                                                              color: context
                                                                  .watch<
                                                                      ThemeProvider>()
                                                                  .getHighLightColor())
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: context
                                                            .watch<
                                                                ThemeProvider>()
                                                            .getBackgroundColor()),
                                                    child: AutoSizeText(
                                                      "Yes, Logout",
                                                      style: kPrimartFont(
                                                        context
                                                            .watch<
                                                                ThemeProvider>()
                                                            .getPriamryFontColor(),
                                                        22,
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    GoogleSignIn _googleSignin =
                                                        GoogleSignIn(
                                                      scopes: [
                                                        'email',
                                                        'https://www.googleapis.com/auth/contacts.readonly',
                                                      ],
                                                    );
                                                    _googleSignin.signOut();
                                                    print("> Logging out");
                                                    Storage().logout();
                                                    context
                                                        .read<
                                                            NavigationProvider>()
                                                        .setCurrentIndex(0);
                                                    context
                                                        .read<ScanProvider>()
                                                        .resetProvider();
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return NavigationScreen();
                                                    }));
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                  );
                                });
                          },
                          icon: "assets/icons/logout.png"),
                    ],
                  ),
                ),
              ],
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
        SizedBox(
          width: 4,
        ),
        AutoSizeText(
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
  final String icon;
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
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getHighLightColor(),
            borderRadius: BorderRadius.circular(8),
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
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(
            icon,
            height: 42,
            width: 42,
          ),
          SizedBox(width: 5),
          AutoSizeText(
            text,
            textAlign: TextAlign.center,
            style: kPrimartFont(
                context.watch<ThemeProvider>().getSecondaryFontColor(),
                18,
                FontWeight.bold),
          )
        ]),
      ),
    );
  }
}

class ColumnButtons extends StatelessWidget {
  final String text;
  final Function press;
  final String icon;
  const ColumnButtons({
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: context.watch<ThemeProvider>().getBackgroundColor(),
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
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Image.asset(
                icon,
                height: 42,
                width: 42,
              ),
              SizedBox(
                width: 20,
              ),
              AutoSizeText(
                text,
                textAlign: TextAlign.center,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.w600),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 28,
            color: context.watch<ThemeProvider>().getPriamryFontColor(),
          )
        ]),
      ),
    );
  }
}
