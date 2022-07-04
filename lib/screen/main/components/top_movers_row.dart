import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/main/main_mock.dart';

class TopMoversItem extends StatelessWidget {
  int rank;
  String url;
  String name;
  double price;

  TopMoversItem(
      {required this.rank,
      required this.url,
      required this.name,
      required this.price}) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
      clipBehavior: Clip.antiAlias,
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      elevation: 100,
      shadowColor:
          context.watch<ThemeProvider>().getHighLightColor().withOpacity(0.11),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 46,
                backgroundColor:
                    context.watch<ThemeProvider>().getHighLightColor(),
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
                                .getPriamryFontColor(),
                            fontWeight: FontWeight.bold)),
                    radius: 16,
                    backgroundColor:
                        context.watch<ThemeProvider>().getHighLightColor(),
                  )),
            ],
          ),
          Container(
            child: Text(
              name,
              style: GoogleFonts.poppins(
                  fontSize: 10,
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

class TopMoversRowList extends StatelessWidget {
  var topMovers = topMoversMock;
  TopMoversRowList({required this.topMovers});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left: 20),
      height: 175,
      width: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topMovers.length,
        itemBuilder: (BuildContext context, int index) {
          return TopMoversItem(
            rank: int.parse(topMovers[index]["rank"].toString()),
            name: topMovers[index]["name"].toString(),
            price: double.parse(topMovers[index]["price"].toString()),
            url: topMovers[index]["url"].toString(),
          );
        },
      ),
    );
  }
}
