import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_screen.dart';

class LiveDropItem extends StatelessWidget {
  String banner;
  String url;
  String name;
  String collectionName;
  String category;

  LiveDropItem(
      {required this.banner,
      required this.url,
      required this.category,
      required this.collectionName,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        elevation: 100,
        shadowColor: context
            .watch<ThemeProvider>()
            .getHighLightColor()
            .withOpacity(0.66),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              overflow: Overflow.visible,
              children: [
                InkWell(
                  child: Ink.image(
                    height: 50,
                    image: NetworkImage(banner),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                    bottom: -20,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(url),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: context.watch<ThemeProvider>().getPriamryFontColor(),
                ),
              ),
              padding: EdgeInsets.only(left: 5),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              child: Text(
                collectionName,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: context.watch<ThemeProvider>().getSecondaryFontColor(),
                ),
              ),
              padding: EdgeInsets.only(left: 5),
            ),
            SizedBox(height: 3),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: context.watch<ThemeProvider>().getHighLightColor()),
                borderRadius: BorderRadius.circular(10),
                color: context.watch<ThemeProvider>().getBackgroundColor(),
              ),
              child: Text(
                category,
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                    fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NFTCollectionScreen(id: "1")));
      },
    );
  }
}

class ExploreGrid extends StatelessWidget {
  var exploreItems = [];
  ExploreGrid({required this.exploreItems});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1 / 1,
            ),
            itemCount: exploreItems.length,
            itemBuilder: (BuildContext context, int index) {
              return LiveDropItem(
                banner: exploreItems[index]["banner"],
                name: exploreItems[index]["name"],
                collectionName: exploreItems[index]["collectionName"],
                url: exploreItems[index]["url"],
                category: exploreItems[index]["category"],
              );
            }));
  }
}
