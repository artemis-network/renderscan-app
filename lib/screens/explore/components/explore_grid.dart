import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/screens/home/models/notable_collection.model.dart';
import 'package:renderscan/screens/nfts_collection/nfts_collection_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';

class Collections extends StatelessWidget {
  final NotableCollectionModel collection;

  Collections({required this.collection});

  @override
  Widget build(BuildContext context) {
    final oneDayChange = double.parse(collection.oneDayChange);
    final color = oneDayChange > 0 ? Colors.greenAccent : Colors.redAccent;
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        elevation: 12,
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
                    image: NetworkImage(collection.bannerUrl),
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
                        backgroundImage: NetworkImage(collection.imageUrl),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              child: Text(
                collection.slug,
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
                collection.name,
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
                oneDayChange.toStringAsFixed(2) + "%",
                style: GoogleFonts.poppins(
                    fontSize: 14, color: color, fontWeight: FontWeight.bold),
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
                builder: (context) => NFTCollectionScreen(
                      slug: collection.slug,
                    )));
      },
    );
  }
}

class ExploreGrid extends StatelessWidget {
  final List<NotableCollectionModel> exploreItems;
  ExploreGrid({required this.exploreItems});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: MasonryGridView.count(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            crossAxisCount: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            itemCount: exploreItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Collections(
                collection: exploreItems[index],
              );
            }));
  }
}
