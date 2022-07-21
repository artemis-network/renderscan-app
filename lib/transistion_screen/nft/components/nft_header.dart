import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class NFTHeader extends StatelessWidget {
  final String collectionName;
  final String collectionImageUrl;
  final String collectionSlug;

  NFTHeader(
      {required this.collectionName,
      required this.collectionSlug,
      required this.collectionImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_circle_left,
                size: 40,
                color: context.watch<ThemeProvider>().getSecondaryFontColor()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            collectionName.length > 14
                ? collectionName.substring(0, 14)
                : collectionName,
            style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                24,
                FontWeight.bold),
          ),
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(collectionImageUrl),
          ),
        ],
      ),
    );
  }
}
