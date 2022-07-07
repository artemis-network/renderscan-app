import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class TrendingWidget extends StatelessWidget {
  final int rank;
  final String url;
  final String name;
  final double price;

  TrendingWidget(
      {required this.rank,
      required this.url,
      required this.name,
      required this.price}) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(400)),
      clipBehavior: Clip.antiAlias,
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      elevation: 2,
      shadowColor:
          context.watch<ThemeProvider>().getHighLightColor().withOpacity(.75),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 46,
                backgroundColor:
                    context.watch<ThemeProvider>().getSecondaryFontColor(),
                child: CircleAvatar(
                  radius: 42,
                  backgroundImage: NetworkImage(url),
                ),
              ),
              Positioned(
                  bottom: 0,
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
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              name,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Text(
              price.toString() + "M",
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getHighLightColor(),
                  14,
                  FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
