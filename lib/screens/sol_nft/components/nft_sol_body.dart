import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTSolBody extends StatelessWidget {
  final String name;
  final String collectionName;
  final String imageUrl;
  final String owner;

  NFTSolBody(
      {required this.name,
      required this.collectionName,
      required this.imageUrl,
      required this.owner});

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
              return SvgPicture.network(
                imageUrl.toString(),
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
                    "owned by " + owner.substring(0, 24) + "...",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getSecondaryFontColor(),
                        14,
                        FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          alignment: Alignment.centerLeft),
    ]);
  }
}
