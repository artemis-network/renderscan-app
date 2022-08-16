import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/screens/home/models/notable_collection.model.dart';
import 'package:renderscan/screens/nfts_collection/nfts_collection_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NotableCollectionWidget extends StatelessWidget {
  final NotableCollectionModel notableCollection;

  NotableCollectionWidget({required this.notableCollection});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NFTCollectionScreen(slug: notableCollection.slug)));
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      child: Image.network(
                        notableCollection.bannerUrl,
                        height: 75,
                        width: 195.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                        bottom: -20,
                        child: CircleAvatar(
                          radius: 34,
                          backgroundColor: context
                              .watch<ThemeProvider>()
                              .getBackgroundColor(),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(notableCollection.imageUrl),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  child: Text(
                    notableCollection.slug,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color:
                            context.watch<ThemeProvider>().getHighLightColor(),
                        fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.only(left: 5),
                ),
                Container(
                  child: Text(
                    notableCollection.name.toString().length > 14
                        ? notableCollection.name.toString().substring(0, 14) +
                            "..."
                        : notableCollection.name.toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color:
                            context.watch<ThemeProvider>().getHighLightColor(),
                        fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.only(left: 5),
                ),
              ],
            ),
          ),
        ));
  }
}
