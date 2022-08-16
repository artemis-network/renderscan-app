import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class NFTBody extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String lastPrice;
  final String owner;
  final String profile_img_url;
  final String collectionName;
  final String collectionImageUrl;
  final String collectionSlug;
  final String description;

  NFTBody(
      {required this.imageUrl,
      required this.name,
      required this.lastPrice,
      required this.owner,
      required this.profile_img_url,
      required this.description,
      required this.collectionName,
      required this.collectionSlug,
      required this.collectionImageUrl});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          clipBehavior: Clip.antiAlias,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          elevation: 300,
          shadowColor: Color.fromARGB(255, 41, 121, 255),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Image.network(
            imageUrl,
            height: 340,
            fit: BoxFit.fill,
            errorBuilder: (context, stacktrace, obj) {
              return SvgPicture.asset(
                "assets/images/default_img.svg",
                fit: BoxFit.fill,
              );
            },
          )),
      Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(collectionImageUrl),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    collectionName.length > 14
                        ? collectionName.substring(0, 14)
                        : collectionName,
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        18,
                        FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                name,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    22,
                    FontWeight.normal),
              ),
              Row(
                children: [
                  Text(
                    lastPrice.toString(),
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        18,
                        FontWeight.bold),
                  ),
                  Icon(
                    CryptoFontIcons.ETH,
                    size: 18,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(profile_img_url),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    owner.length > 18 ? owner.substring(0, 18) + "..." : owner,
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getSecondaryFontColor(),
                        14,
                        FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                description,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getSecondaryFontColor(),
                    12,
                    FontWeight.w400),
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          alignment: Alignment.centerLeft),
    ]);
  }
}
