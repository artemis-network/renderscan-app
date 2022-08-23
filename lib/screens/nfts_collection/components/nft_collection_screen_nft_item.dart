import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/nft/nft_screen.dart';
import 'package:renderscan/screens/nfts_collection/models/nft.model.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTCollectionScreenNFTItem extends StatelessWidget {
  final NFTModel nft;

  NFTCollectionScreenNFTItem({
    required this.nft,
  });

  @override
  Widget build(BuildContext context) {
    getImage() {
      try {
        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          child: Image.network(
            nft.imageUrl,
            fit: BoxFit.cover,
          ),
        );
      } catch (e) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          child: SvgPicture.asset(
            "assets/images/default_img.svg",
            fit: BoxFit.cover,
          ),
        );
      }
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NFTScreen(
                      contractAddress: nft.contract,
                      tokenId: nft.tokenId,
                    )));
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
            getImage(),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  nft.name.length > 14
                      ? nft.name.substring(0, 14) + "..."
                      : nft.name,
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getSecondaryFontColor(),
                      14,
                      FontWeight.bold),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nft.nftPrice.amount,
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getSecondaryFontColor(),
                        14,
                        FontWeight.bold),
                  ),
                  Icon(
                    CryptoFontIcons.ETH,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                    size: 18,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
