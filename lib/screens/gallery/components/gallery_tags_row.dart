import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/screens/gallery/components/gallery_tag.dart';
import 'package:renderscan/theme/theme_provider.dart';

class GalleryTagRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: context
            .watch<ThemeProvider>()
            .getHighLightColor()
            .withOpacity(0.66),
        elevation: 1,
        child: Container(
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          width: size.width * 1,
          height: size.height * .075,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              GalleryTag(
                tag: "Minted",
                icon: "assets/icons/list.png",
                isActive: true,
              ),
              GalleryTag(
                tag: "Scanned",
                icon: "assets/icons/list.png",
                isActive: true,
              ),
              GalleryTag(
                tag: "Imported",
                icon: "assets/icons/import.png",
                isActive: false,
              ),
              GalleryTag(
                tag: "Generated",
                icon: "assets/icons/import.png",
                isActive: false,
              ),
            ],
          ),
        ));
  }
}
