import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar_button.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/referal/referal_screen.dart';
import 'package:renderscan/screen/transcations/transaction_screen.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
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
                  Text(
                    "Jhon Doe",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        18,
                        FontWeight.normal),
                  ),
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
          ),
          Divider(
              height: 50,
              color: context
                  .watch<ThemeProvider>()
                  .getHighLightColor()
                  .withOpacity(0.33),
              thickness: 2,
              indent: 4),
          Column(
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
          ),
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
          ),
          Divider(
              height: 30,
              color: context
                  .watch<ThemeProvider>()
                  .getHighLightColor()
                  .withOpacity(0.33),
              thickness: 2,
              indent: 4),
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
          SideBarButton(
            text: "Logout",
            icon: Icons.logout_outlined,
            onClick: () {},
          ),
        ],
      ),
    );
  }
}
