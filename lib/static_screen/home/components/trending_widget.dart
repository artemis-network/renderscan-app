import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/static_screen/home/models/trending_model.dart';
import 'package:renderscan/static_screen/nfts_collection/nfts_collection_screen.dart';

class TrendingWidget extends StatelessWidget {
  final TrendingModel trending;
  final int index;

  TrendingWidget({required this.trending, required this.index}) {}

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    trending.oneDayVolume.toString().length < 4
                        ? trending.oneDayVolume.toString()
                        : trending.oneDayVolume.toString().substring(0, 5),
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getHighLightColor(),
                        11,
                        FontWeight.w800),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    CryptoFontIcons.ETH,
                    size: 12,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
