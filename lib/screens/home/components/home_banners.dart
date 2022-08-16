import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';

class HomeBanner extends StatefulWidget {
  @override
  State<HomeBanner> createState() => Home_BannerState();
}

class Home_BannerState extends State<HomeBanner> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // const oneSec = Duration(seconds: 3);
    // Timer.periodic(oneSec, (Timer t) {
    //   if (currentIndex >= 2) {
    //     setState(() {
    //       currentIndex = 0;
    //     });
    //     return;
    //   }
    //   setState(() {
    //     currentIndex += 1;
    //   });
    //   return;
    // });

    final Homebanners = [
      "assets/images/banner_one.png",
      "assets/images/banner_two.png",
      "assets/images/banner_three.png",
    ];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 130,
      width: 350,
      child: Stack(alignment: Alignment.center, children: [
        PageView.builder(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: PageController(viewportFraction: 1, initialPage: 0),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                child: Image.asset(
                  Homebanners[currentIndex],
                  height: 65,
                  fit: BoxFit.fill,
                ),
              );
            }),
        Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: currentIndex == 0
                      ? Colors.white
                      : context.watch<ThemeProvider>().getBackgroundColor(),
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: currentIndex == 1
                      ? Colors.white
                      : context.watch<ThemeProvider>().getBackgroundColor(),
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: currentIndex == 2
                      ? Colors.white
                      : context.watch<ThemeProvider>().getBackgroundColor(),
                  size: 10,
                )
              ],
            ))
      ]),
    );
  }
}
