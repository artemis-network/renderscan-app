import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/home/models/trending_model.dart';
import 'package:renderscan/screens/nfts_collection/nfts_collection_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';

class TrendingWidget extends StatelessWidget {
  final TrendingModel trending;
  final int index;

  TrendingWidget({required this.trending, required this.index}) {}

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.cyan,
      Colors.deepOrange,
      Colors.teal,
      Colors.deepPurple,
      Colors.lightGreen,
      Colors.blueGrey,
      Colors.black,
      Colors.tealAccent,
      Colors.indigoAccent,
      Colors.purpleAccent,
      Colors.cyanAccent,
      Colors.deepOrangeAccent,
      Colors.deepPurpleAccent,
      Colors.pinkAccent,
      Colors.lightGreenAccent,
      Colors.blue,
      Colors.green,
      Colors.amber,
      Colors.pink,
      Colors.brown,
    ];

    ImageGetter() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Image.network(
          trending.logo.toString(),
          errorBuilder: ((context, error, stackTrace) {
            return CircleAvatar(
              radius: 46,
              child: SvgPicture.network(trending.logo.toString()),
            );
          }),
        ),
      );
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NFTCollectionScreen(slug: trending.slug.toString())));
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
                  radius: 48,
                  backgroundColor:
                      context.watch<ThemeProvider>().getSecondaryFontColor(),
                  child: ImageGetter(),
                ),
                Positioned(
                    bottom: 6,
                    left: 0,
                    child: CircleAvatar(
                      child: Text((index + 1).toString(),
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      radius: 16,
                      backgroundColor: colors[index],
                    )),
              ],
            ),
            Container(
              child: Text(
                trending.name.toString().length < 10
                    ? trending.name.toString()
                    : trending.name.toString().substring(0, 10),
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Icon(
                    CryptoFontIcons.ETH,
                    size: 12,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    trending.oneDayVolume.toString().length < 4
                        ? trending.oneDayVolume.toString()
                        : trending.oneDayVolume.toString().substring(0, 5),
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getHighLightColor(),
                        11,
                        FontWeight.w800),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
