import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft.model.dart';
import 'package:renderscan/transistion_screen/nft/nft_screen.dart';

class ShowcaseWidget extends StatelessWidget {
  final NFTModel nftdto;

  ShowcaseWidget({
    required this.nftdto,
  });

  @override
  Widget build(BuildContext context) {
    ImageGetter() {
      return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            nftdto.imageUrl.toString(),
            height: 96,
            fit: BoxFit.fitWidth,
            errorBuilder: (context, error, stackTrace) => SvgPicture.network(
              nftdto.imageUrl.toString(),
              height: 96,
              fit: BoxFit.fitWidth,
            ),
          ));
    }

    return Container(
        decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
            child: Column(children: [
              ImageGetter(),
              SizedBox(
                height: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      nftdto.name.toString().length > 14
                          ? nftdto.name.toString().substring(0, 14)
                          : nftdto.name.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor(),
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        nftdto.lastPrice.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        CryptoFontIcons.ETH,
                        color: context
                            .watch<ThemeProvider>()
                            .getPriamryFontColor(),
                        size: 14,
                      )
                    ],
                  ),
                ],
              )
            ]),
            onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NFTScreen(
                                contractAddress: nftdto.contract,
                                tokenId: nftdto.tokenId,
                              )))
                }));
  }
}
