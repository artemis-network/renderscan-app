import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/screens/gallery/components/gallery_view.dart';
import 'package:renderscan/theme/theme_provider.dart';

class GalleryItem extends StatelessWidget {
  final String url;
  final String tag;

  GalleryItem({required this.url, required this.tag});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return GalleryView(
              tag: tag,
              url: url,
            );
          }));
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.antiAlias,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          elevation: 100,
          shadowColor: context
              .watch<ThemeProvider>()
              .getHighLightColor()
              .withOpacity(0.66),
          child: Hero(
              tag: tag,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Ink.image(
                  height: 170,
                  image: NetworkImage(url),
                  fit: BoxFit.fitWidth,
                ),
              )),
        ));
  }
}
