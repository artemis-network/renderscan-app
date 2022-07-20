import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/home/models/trending_model.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_screen.dart';

class TrendingWidget extends StatelessWidget {
  final TrendingDTO trendingDTO;
  final int index;

  TrendingWidget({required this.trendingDTO, required this.index}) {}

  @override
  Widget build(BuildContext context) {
    ImageGetter() {
      try {
        return CircleAvatar(
          radius: 46,
          backgroundImage: NetworkImage(trendingDTO.logo.toString()),
        );
      } catch (e) {
        return Container(
          height: 60,
          width: 60,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SvgPicture.network(trendingDTO.logo.toString())),
        );
      }
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NFTCollectionScreen(slug: trendingDTO.slug.toString())));
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
                trendingDTO.name.toString().length < 10
                    ? trendingDTO.name.toString()
                    : trendingDTO.name.toString().substring(0, 10),
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                trendingDTO.oneDayVolume.toString().length < 4
                    ? trendingDTO.oneDayVolume.toString() + "M"
                    : trendingDTO.oneDayVolume.toString().substring(0, 5) + "M",
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
