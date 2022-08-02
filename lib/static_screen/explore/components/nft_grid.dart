import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft.model.dart';
import 'package:renderscan/transistion_screen/nft/nft_screen.dart';

class NFTItem extends StatelessWidget {
  final NFTModel nftModel;

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
                              nftModel.lastPrice.toString(),
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
  final List<NFTModel> nftItems;
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
              nftModel: nftItems[index],
            );
          },
        ));
  }
}
