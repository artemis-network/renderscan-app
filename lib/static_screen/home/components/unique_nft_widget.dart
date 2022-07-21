import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/transistion_screen/nft/nft_screen.dart';

class UniqueNFTWidget extends StatelessWidget {
  final int id;
  final String url;
  final double price;
  final String name;

  UniqueNFTWidget(
      {required this.id,
      required this.url,
      required this.name,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAlias,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          elevation: 2,
          shadowColor: context
              .watch<ThemeProvider>()
              .getHighLightColor()
              .withOpacity(0.75),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Ink.image(
                  height: 105,
                  width: 100,
                  image: NetworkImage(url),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  name,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color:
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                      fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.only(left: 5),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      price.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor(),
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      CryptoFontIcons.ETH,
                      size: 12,
                      color:
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                    )
                  ],
                ),
                padding: EdgeInsets.only(left: 5),
              ),
            ],
          ),
        )),
        onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NFTScreen(
                            contractAddress: "",
                            tokenId: "",
                          )))
            });
  }
}
