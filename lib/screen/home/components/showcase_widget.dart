import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screen/home/home_screen_api.dart';
import 'package:renderscan/screen/nft/nft_screen.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_api.dart';

class ShowcaseWidget extends StatelessWidget {
  final ShowCaseDTO showCaseDTO;

  ShowcaseWidget({
    required this.showCaseDTO,
  });

  @override
  Widget build(BuildContext context) {
    ImageGetter() {
      try {
        return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(showCaseDTO.imageUrl.toString(),
                height: 96, fit: BoxFit.fitWidth));
      } catch (e) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SvgPicture.network(showCaseDTO.imageUrl.toString(),
                height: 96, fit: BoxFit.fitWidth));
      }
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
                      showCaseDTO.name.toString().length > 14
                          ? showCaseDTO.name.toString().substring(0, 14)
                          : showCaseDTO.name.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 8,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor(),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ]),
            onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NFTScreen(
                                nftdto: NFTDTO.jsonToObject({}),
                              )))
                }));
  }
}
