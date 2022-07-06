import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screen/nft/nft_screen.dart';

class MintNowItem extends StatelessWidget {
  final int id;
  final String url;
  final double price;
  final String name;

  MintNowItem(
      {required this.id,
      required this.url,
      required this.name,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAlias,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          elevation: 100,
          shadowColor: context
              .watch<ThemeProvider>()
              .getHighLightColor()
              .withOpacity(0.33),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Ink.image(
                  height: 125,
                  width: 120,
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
                child: Text(
                  price.toString() + "8\$",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color:
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                      fontWeight: FontWeight.w800),
                ),
                padding: EdgeInsets.only(left: 5),
              ),
            ],
          ),
        ),
        onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NFTScreen(id: id)))
            });
  }
}
