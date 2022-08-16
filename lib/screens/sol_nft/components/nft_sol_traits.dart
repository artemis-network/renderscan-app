import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/nfts_collection/models/nft_sol.modal.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTSolTraitList extends StatelessWidget {
  final List<NFTSolTraits> traits;
  NFTSolTraitList({required this.traits});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: MasonryGridView.count(
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          itemCount: traits.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color:
                            context.watch<ThemeProvider>().getHighLightColor())
                  ]),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      traits[index].trait_type,
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          12,
                          FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      traits[index].value.toString(),
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          14,
                          FontWeight.w700),
                    ),
                  ]),
            );
          }),
    );
  }
}
