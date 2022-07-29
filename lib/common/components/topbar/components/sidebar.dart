import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/auth_filter.dart';
import 'package:renderscan/common/components/topbar/components/sidebar_button.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';

import 'package:renderscan/static_screen/navigation/navigation_provider.dart';
import 'package:renderscan/transistion_screen/login/login_screen.dart';
import 'package:renderscan/transistion_screen/referal/referal_screen.dart';
import 'package:renderscan/transistion_screen/scan/scan_provider.dart';
import 'package:renderscan/transistion_screen/transcations/components/buy_ruby_modal.dart';
import 'package:renderscan/transistion_screen/transcations/transaction_screen.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    operatePage(Function fn) async {
      final bool isUserLoggedIn = await Storage().isLoggedIn();
      if (isUserLoggedIn) {
        fn();
      } else
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.bottomToTop,
            child: LoginScreen(),
            ctx: context,
            fullscreenDialog: true,
            duration: Duration(milliseconds: 300),
            childCurrent: SideBar()));
    }

    return Container(
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome!",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          18,
                          FontWeight.bold),
                    ),
                    FutureBuilder(
                        future: Storage().getItem("username"),
                        builder: ((context, snapshot) {
                          final String username =
                              (snapshot.data ?? "") as String;
                          if (snapshot.hasData) {
                            return Text(
                              username,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  18,
                                  FontWeight.bold),
                            );
                          }
                          return Text("");
                        }))
                  ],
                ),
              ),
              Divider(
                  height: 8,
                  color: context
                      .watch<ThemeProvider>()
                      .getPriamryFontColor()
                      .withOpacity(0.33),
                  thickness: 1,
                  indent: 1),
              SideBarButton(
                text: "Account",
                icon: Icons.person_rounded,
                onClick: () => operatePage(
                    () => context.read<NavigationProvider>().currentIndex(3)),
              ),
              SideBarButton(
                text: "Transcations",
                icon: Icons.monetization_on_rounded,
                onClick: () {
                  operate() {
                    return Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return TransactionScreen();
                      },
                    ));
                  }

                  operatePage(operate);
                },
              ),
              SideBarButton(
                text: "Refer & Earn",
                icon: Icons.money_outlined,
                onClick: () {
                  operate() {
                    return Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ReferalScreen();
                      },
                    ));
                  }

                  operatePage(operate);
                },
              ),
              Divider(
                  height: 8,
                  color: context
                      .watch<ThemeProvider>()
                      .getPriamryFontColor()
                      .withOpacity(0.33),
                  thickness: 1,
                  indent: 1),
              SideBarButton(
                text: "Buy Ruby",
                icon: Icons.money_outlined,
                onClick: () {
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: BuyRubyModal(),
                      ctx: context,
                      duration: Duration(milliseconds: 300),
                      fullscreenDialog: true,
                      childCurrent: this));
                },
              ),
              Divider(
                  height: 8,
                  color: context
                      .watch<ThemeProvider>()
                      .getPriamryFontColor()
                      .withOpacity(0.33),
                  thickness: 1,
                  indent: 1),
              SideBarButton(
                text: "Terms of Use",
                icon: Icons.document_scanner_outlined,
                onClick: () {},
              ),
              SideBarButton(
                text: "Privacy Policy",
                icon: Icons.document_scanner_outlined,
                onClick: () {},
              ),
              SideBarButton(
                text: "Feedback & Support",
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
                      Navigator.of(context).pop();
                    },
                  ),
                  guestView: Container())
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Music",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            12,
                            FontWeight.bold),
                      ),
                      Switch(
                          value: context.watch<ThemeProvider>().isDarkTheme(),
                          onChanged: (r) {})
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Dark Theme",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            12,
                            FontWeight.bold),
                      ),
                      Switch(
                          value: context.watch<ThemeProvider>().isDarkTheme(),
                          onChanged: (r) {
                            context.read<ThemeProvider>().setTheme(r);
                          })
                    ],
                  )
                ]),
          )
        ],
      ),
    );
  }
}
