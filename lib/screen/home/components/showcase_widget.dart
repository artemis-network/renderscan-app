import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screen/nft/nft_screen.dart';

class ShowcaseWidget extends StatelessWidget {
  final int id;
  final String url;
  final double price;
  final String name;

  ShowcaseWidget(
      {required this.id,
      required this.url,
      required this.name,
      required this.price});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        constraints: BoxConstraints(minWidth: size.width * 0.65),
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 2,
                  color: context
                      .watch<ThemeProvider>()
                      .getHighLightColor()
                      .withOpacity(0.9),
                  offset: Offset(0, 0)),
            ]),
        child: GestureDetector(
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  url,
                  height: 96,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      name,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor(),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      child: Row(
                    children: [
                      Text(
                        price.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        CryptoFontIcons.ETH,
                        size: 12,
                        color: context
                            .watch<ThemeProvider>()
                            .getPriamryFontColor(),
                      )
                    ],
                  )),
                ],
              )
            ]),
            onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NFTScreen(id: id)))
                }));
  }
}
