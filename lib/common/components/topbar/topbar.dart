import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';
import 'package:renderscan/theme/theme_provider.dart';

class Topbar extends StatelessWidget {
  final Function popSideBar;

  Topbar({required this.popSideBar});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
          onTap: () {
            popSideBar();
          },
          child: Image.asset(
            "assets/icons/menu.png",
            height: 36,
            width: 36,
          ),
        ),
        BalanceWidget()
      ]),
    );
  }
}
