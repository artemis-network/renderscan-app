import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_screen.dart';

class NotableCollectionWidget extends StatelessWidget {
  final String id;
  final String url;
  final String banner;
  final String name;
  final String collectionName;

  NotableCollectionWidget(
      {required this.id,
      required this.url,
      required this.banner,
      required this.name,
      required this.collectionName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NFTCollectionScreen(id: id)));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAlias,
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            elevation: 2,
            shadowColor: context
                .watch<ThemeProvider>()
                .getHighLightColor()
                .withOpacity(0.9),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      child: Image.network(
                        banner,
                        height: 65.0,
                        width: 230.0,
                      ),
                    ),
                    Positioned(
                        bottom: -20,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: context
                              .watch<ThemeProvider>()
                              .getBackgroundColor(),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(url),
                          ),
                        )),
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
                        color:
                            context.watch<ThemeProvider>().getHighLightColor(),
                        fontWeight: FontWeight.bold),
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
                        color: context
                            .watch<ThemeProvider>()
                            .getPriamryFontColor(),
                        fontWeight: FontWeight.w800),
                  ),
                  padding: EdgeInsets.only(left: 5),
                ),
              ],
            ),
          ),
        ));
  }
}
