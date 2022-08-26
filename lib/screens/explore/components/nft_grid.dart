import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/home/models/nfts.model.dart';
import 'package:renderscan/screens/nft/nft_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTItem extends StatelessWidget {
  final NFTHomeModel nftModel;

  NFTItem({required this.nftModel});

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
                image: NetworkImage(nftModel.imageUrl),
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
                          nftModel.name.length > 10
                              ? nftModel.name.substring(0, 10)
                              : nftModel.name,
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              16,
                              FontWeight.normal),
                        ),
                        Row(
                          children: [
                            Text(
                              nftModel.lastprice,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  14,
                                  FontWeight.bold),
                            ),
                            Icon(
                              CryptoFontIcons.ETH,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              size: 18,
                            )
                          ],
                        )
                      ],
                    ),
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
                      contractAddress: nftModel.contract,
                      tokenId: nftModel.tokenId,
                    )));
      },
    );
  }
}

class NFTGrid extends StatelessWidget {
  final List<NFTHomeModel> nftItems;
  NFTGrid({required this.nftItems});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        itemCount: nftItems.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return NFTItem(
            nftModel: nftItems[index],
          );
        },
      ),
    );
  }
}
