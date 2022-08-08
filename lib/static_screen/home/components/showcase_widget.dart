import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/static_screen/home/home_screen_api.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft.model.dart';
import 'package:renderscan/transistion_screen/nft/nft_screen.dart';
import 'package:renderscan/transistion_screen/sol_nft/sol_nft_screen.dart';

enum CHAIN { solana, eth }

class ShowcaseWidget extends StatelessWidget {
  final NFTModel nft;
  final CHAIN chain;

  ShowcaseWidget({required this.nft, required this.chain});

  @override
  Widget build(BuildContext context) {
    getSymbol() {
      if (chain == CHAIN.eth)
        return Icon(
          CryptoFontIcons.ETH,
          color: context.watch<ThemeProvider>().getPriamryFontColor(),
          size: 14,
        );
      return Image.asset(
        "assets/images/sol.png",
        height: 14,
        width: 14,
      );
    }

    ImageGetter() {
      return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 2,
            color: context.watch<ThemeProvider>().getBackgroundColor(),
          ),
          BoxShadow(
            offset: Offset(-1, -1),
            color: context.watch<ThemeProvider>().getForegroundColor(),
            blurRadius: 2,
          ),
        ]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              nft.imageUrl.toString(),
              height: 96,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
                "assets/images/default_img.svg",
                height: 96,
                fit: BoxFit.fitWidth,
              ),
            )),
      );
    }

    return Container(
        decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          borderRadius: BorderRadius.circular(1),
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
                      nft.name.toString().length > 14
                          ? nft.name.toString().substring(0, 14)
                          : nft.name.toString(),
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
                        "0",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      getSymbol()
                    ],
                  ),
                ],
              )
            ]),
            onTap: () => {
                  if (chain == CHAIN.solana)
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NFTSolScreen(
                                    contract: nft.contract,
                                  )))
                    }
                  else
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NFTScreen(
                                  contractAddress: nft.contract,
                                  tokenId: nft.tokenId,
                                )))
                }));
  }
}
