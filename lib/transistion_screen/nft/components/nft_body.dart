import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class NFTBody extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String lastPrice;
  final String owner;
  final String profile_img_url;
  final String description;

  NFTBody(
      {required this.imageUrl,
      required this.name,
      required this.lastPrice,
      required this.owner,
      required this.profile_img_url,
      required this.description});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        elevation: 300,
        shadowColor: Color.fromARGB(255, 41, 121, 255),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
            child: Column(children: [
          InkWell(
            child: Ink.image(
              image: NetworkImage(imageUrl),
              height: 340,
              fit: BoxFit.fitWidth,
            ),
          ),
        ])),
      ),
      Container(
          child: Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    22,
                    FontWeight.normal),
              ),
              Text(
                lastPrice.toString(),
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.bold),
              ),
              owner == "--"
                  ? Row(
                      children: [
                        Text(
                          "Owned by " + owner,
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getSecondaryFontColor(),
                              14,
                              FontWeight.bold),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(profile_img_url),
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 15,
              ),
              Text(
                description,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    12,
                    FontWeight.w500),
              ),
            ],
          )),
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          alignment: Alignment.centerLeft),
    ]);
  }
}
