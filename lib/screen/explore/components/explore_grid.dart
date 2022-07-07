import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_screen.dart';

class LiveDropItem extends StatelessWidget {
  final String banner;
  final String url;
  final String name;
  final String collectionName;
  final String category;

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
        elevation: 2,
        shadowColor: context
            .watch<ThemeProvider>()
            .getHighLightColor()
            .withOpacity(0.88),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                InkWell(
                  child: Ink.image(
                    height: 80,
                    image: NetworkImage(banner),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                    bottom: -40,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      child: CircleAvatar(
                        radius: 44,
                        backgroundImage: NetworkImage(url),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: context.watch<ThemeProvider>().getPriamryFontColor(),
                ),
              ),
              padding: EdgeInsets.only(left: 5),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              child: Text(
                collectionName,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: context.watch<ThemeProvider>().getSecondaryFontColor(),
                ),
              ),
              padding: EdgeInsets.only(left: 5),
            ),
            SizedBox(
              height: 8,
            ),
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
                    fontSize: 14,
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
  final exploreItems;
  ExploreGrid({required this.exploreItems});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1 / .82,
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
