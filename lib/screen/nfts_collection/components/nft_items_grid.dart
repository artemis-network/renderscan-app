import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/nft/nft_screen.dart';

class NFTCollectionGridTab extends StatelessWidget {
  final nftItems;

  NFTCollectionGridTab({required this.nftItems});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.25,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: nftItems.length,
          itemBuilder: (BuildContext context, int index) {
            return NFTCollectionItem(
                name: nftItems[index]["name"],
                price: nftItems[index]["price"],
                url: nftItems[index]["url"]);
          },
        ));
  }
}

class NFTCollectionItem extends StatelessWidget {
  final String url;
  final String name;
  final double price;

  NFTCollectionItem({
    required this.url,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NFTScreen(id: 1)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 2,
                color: context
                    .watch<ThemeProvider>()
                    .getSecondaryFontColor()
                    .withOpacity(0.66),
              )
            ]),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.toString().substring(0, 10),
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              16,
                              FontWeight.normal),
                        ),
                        Row(children: [
                          Text(
                            price.toString(),
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                14,
                                FontWeight.bold),
                          ),
                          Icon(
                            CryptoFontIcons.ETH,
                            size: 14,
                          )
                        ]),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
