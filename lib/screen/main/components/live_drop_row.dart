import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_screen.dart';

class LiveDropItem extends StatelessWidget {
  String id;
  String url;
  String banner;
  String name;
  String collectionName;

  LiveDropItem(
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
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        elevation: 100,
        shadowColor: context
            .watch<ThemeProvider>()
            .getHighLightColor()
            .withOpacity(0.33),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              overflow: Overflow.visible,
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
                      backgroundColor:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(url),
                      ),
                    ))
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
                    color: context.watch<ThemeProvider>().getHighLightColor(),
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
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                    fontWeight: FontWeight.w800),
              ),
              padding: EdgeInsets.only(left: 5),
            ),
          ],
        ),
      ),
    );
  }
}

class LiveDropRowList extends StatelessWidget {
  var liveDrops = [];
  LiveDropRowList({required this.liveDrops});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(left: 20),
      height: 175,
      width: 225,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: liveDrops.length,
        itemBuilder: (BuildContext context, int index) {
          return LiveDropItem(
            id: index.toString(),
            banner: liveDrops[index]["banner"],
            collectionName: liveDrops[index]["collectionName"],
            name: liveDrops[index]["name"],
            url: liveDrops[index]["url"],
          );
        },
      ),
    );
  }
}
