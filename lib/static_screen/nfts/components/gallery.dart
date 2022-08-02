import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';

class NFTItem extends StatelessWidget {
  final String url;

  NFTItem({required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        elevation: 100,
        shadowColor: context
            .watch<ThemeProvider>()
            .getHighLightColor()
            .withOpacity(0.66),
        child: Column(
          children: [
            InkWell(
              child: Ink.image(
                height: 170,
                image: NetworkImage(url),
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => NFTScreen(
        //               contractAddress: nftModel.contract,
        //               tokenId: nftModel.tokenId,
        //             )));
      },
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
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        itemCount: images.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return NFTItem(
            url: images[index],
          );
        },
      ),
    ));
  }
}
