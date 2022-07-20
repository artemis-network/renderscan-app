import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/nft/nft_screen.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_api.dart';

class NFTItem extends StatelessWidget {
  final String url;
  final String name;
  final double price;

  NFTItem({required this.url, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        elevation: 100,
        shadowColor: context
            .watch<ThemeProvider>()
            .getHighLightColor()
            .withOpacity(0.66),
        child: Column(
          children: [
            InkWell(
              child: Ink.image(
                height: 170,
                image: NetworkImage(url),
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              16,
                              FontWeight.normal),
                        ),
                        Text(
                          price.toString() + " ETH",
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              14,
                              FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () => {},
                        icon: Icon(
                          Icons.favorite_outline,
                          size: 30,
                          color: context
                              .watch<ThemeProvider>()
                              .getFavouriteColor(),
                        ))
                  ],
                ))
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NFTScreen(
                      nftdto: NFTDTO.jsonToObject({}),
                    )));
      },
    );
  }
}

class NFTGrid extends StatelessWidget {
  final nftItems;
  NFTGrid({required this.nftItems});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1 / 1.4,
          ),
          itemCount: nftItems.length,
          itemBuilder: (BuildContext context, int index) {
            return NFTItem(
              name: nftItems[index]["name"].toString().substring(0, 10) + "...",
              price: nftItems[index]["price"],
              url: nftItems[index]["url"],
            );
          },
        ));
  }
}
