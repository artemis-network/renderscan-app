import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/static_screen/nfts/components/image_view.dart';

class GalleryItem extends StatelessWidget {
  final String url;
  final String tag;

  GalleryItem({required this.url, required this.tag});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      elevation: 100,
      shadowColor:
          context.watch<ThemeProvider>().getHighLightColor().withOpacity(0.66),
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
    );
  }
}

class NFTGalleryGrid extends StatelessWidget {
  final List<String> images;
  NFTGalleryGrid({required this.images});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: images.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return (ImageView(url: images[index], tag: index.toString()));
                }));
              },
              child: GalleryItem(url: images[index], tag: index.toString()));
        },
      ),
    ));
  }
}
