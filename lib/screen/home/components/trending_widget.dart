import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_screen.dart';

class TrendingWidget extends StatelessWidget {
  final int rank;
  final String url;
  final String name;
  final String price;
  final String slug;

  TrendingWidget(
      {required this.rank,
      required this.url,
      required this.name,
      required this.price,
      required this.slug}) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NFTCollectionScreen(slug: slug)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor:
                      context.watch<ThemeProvider>().getSecondaryFontColor(),
                  child: CircleAvatar(
                    radius: 46,
                    backgroundImage: NetworkImage(url),
                  ),
                ),
                Positioned(
                    bottom: 6,
                    left: 0,
                    child: CircleAvatar(
                      child: Text(rank.toString(),
                          style: GoogleFonts.poppins(
                              color: context
                                  .watch<ThemeProvider>()
                                  .getBackgroundColor(),
                              fontWeight: FontWeight.bold)),
                      radius: 16,
                      backgroundColor:
                          context.watch<ThemeProvider>().getHighLightColor(),
                    )),
              ],
            ),
            Container(
              child: Text(
                name.length < 10 ? name : name.substring(0, 10),
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                price.length < 4
                    ? price.toString() + "M"
                    : price.toString().substring(0, 5) + "M",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getHighLightColor(),
                    11,
                    FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
