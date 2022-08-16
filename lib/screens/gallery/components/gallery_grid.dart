import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:renderscan/screens/gallery/components/gallery_item.dart';
import 'package:renderscan/screens/gallery/components/gallery_view.dart';

class GalleryGrid extends StatelessWidget {
  final List<String> images;
  GalleryGrid({required this.images});
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
                  return (GalleryView(
                      url: images[index], tag: index.toString()));
                }));
              },
              child: GalleryItem(url: images[index], tag: index.toString()));
        },
      ),
    ));
  }
}
