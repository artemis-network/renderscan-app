import 'package:flutter/material.dart';

class HomeBanner extends StatefulWidget {
  @override
  State<HomeBanner> createState() => Home_BannerState();
}

class Home_BannerState extends State<HomeBanner> {
  @override
  Widget build(BuildContext context) {
    final Homebanners = [
      "assets/images/banner_one.png",
      "assets/images/banner_two.png",
      "assets/images/banner_three.png",
    ];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 130,
      width: 350,
      child: PageView.builder(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: PageController(viewportFraction: 1, initialPage: 0),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              child: Image.asset(
                Homebanners[index],
                height: 65,
                fit: BoxFit.fill,
              ),
            );
          }),
    );
  }
}
