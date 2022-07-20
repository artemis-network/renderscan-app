import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/auth_filter.dart';
import 'package:renderscan/common/components/topbar/components/sidebar_button.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/login/login_screen.dart';
import 'package:renderscan/screen/navigation/navigation_provider.dart';
import 'package:renderscan/screen/referal/referal_screen.dart';
import 'package:renderscan/screen/scan/scan_provider.dart';
import 'package:renderscan/screen/transcations/transaction_screen.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screen() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage("assets/images/lion.png"),
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: Storage().getItem("username"),
                  builder: ((context, snapshot) {
                    return Text(
                      snapshot.data.toString(),
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          18,
                          FontWeight.normal),
                    );
                  })),
              Text(
                "x92wss...",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    14,
                    FontWeight.w200),
              ),
            ],
          )
        ],
      );
    }

    guestView() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage("assets/images/lion.png"),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Account",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.normal),
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: LoginScreen(),
                        ctx: context,
                        fullscreenDialog: true,
                        duration: Duration(milliseconds: 300),
                        childCurrent: this));
                  },
                  child: Text(
                    "Login / Signup",
                    style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      14,
                      FontWeight.w600,
                    ),
                  )),
            ],
          )
        ],
      );
    }

    actionsForUser() {
      return Column(
        children: [
          SideBarButton(
            text: "Transcations",
            icon: Icons.wallet_membership_outlined,
            onClick: () {
              return Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return TransactionScreen();
                },
              ));
            },
          ),
          SideBarButton(
            text: "Refer & Earn",
            icon: Icons.money_outlined,
            onClick: () {
              return Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return ReferalScreen();
                },
              ));
            },
          ),
        ],
      );
    }

    return Container(
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          AuthFilter(screen: screen(), guestView: guestView()),
          Divider(
              height: 50,
              color: context
                  .watch<ThemeProvider>()
                  .getHighLightColor()
                  .withOpacity(0.33),
              thickness: 2,
              indent: 4),
          AuthFilter(screen: actionsForUser(), guestView: Container()),
          AuthFilter(
              screen: Divider(
                  height: 30,
                  color: context
                      .watch<ThemeProvider>()
                      .getHighLightColor()
                      .withOpacity(0.33),
                  thickness: 2,
                  indent: 4),
              guestView: Container()),
          SideBarButton(
            text: "Terms of Use",
            icon: Icons.document_scanner_outlined,
            onClick: () {},
          ),
          SideBarButton(
            text: "Help & FAQ",
            icon: Icons.help_center_outlined,
            onClick: () {},
          ),
          SideBarButton(
            text: "Rate Us",
            icon: Icons.star_outlined,
            onClick: () {},
          ),
          AuthFilter(
              screen: SideBarButton(
                text: "Logout",
                icon: Icons.logout_outlined,
                onClick: () {
                  print("> Logging out");
                  Storage().logout();
                  context.read<NavigationProvider>().setCurrentIndex(0);
                  context.read<ScanProvider>().resetProvider();
                },
              ),
              guestView: Container()),
          Divider(
              height: 30,
              color: context
                  .watch<ThemeProvider>()
                  .getHighLightColor()
                  .withOpacity(0.33),
              thickness: 2,
              indent: 4),
          Container(
            alignment: Alignment.center,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Dark Theme",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.bold),
              ),
              Switch(
                  value: context.watch<ThemeProvider>().isDarkTheme(),
                  onChanged: (r) {
                    context.read<ThemeProvider>().setTheme(r);
                  })
            ]),
          )
        ],
      ),
    );
  }
}
