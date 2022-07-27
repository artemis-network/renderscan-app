import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';

class NFTCollectScreenBanner extends StatelessWidget {
  final String bannerUrl;
  final String imageUrl;

  NFTCollectScreenBanner({required this.bannerUrl, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        child: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 160),
          child: Image.network(
            bannerUrl,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: [Colors.greenAccent, Colors.blueAccent],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Icon(
                Icons.arrow_back,
                size: 50,
                color: context.watch<ThemeProvider>().getHighLightColor(),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 0,
                        color:
                            context.watch<ThemeProvider>().getBackgroundColor())
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 16,
                    offset: Offset(2, 2),
                    spreadRadius: 8,
                    color: context
                        .watch<ThemeProvider>()
                        .getBackgroundColor()
                        .withOpacity(0.88))
              ]),
            ))
      ],
    ));
  }
}
