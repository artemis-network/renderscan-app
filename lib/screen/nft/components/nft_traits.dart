import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/nfts_collection/models/nft_trait.model.dart';

class NFTTraitList extends StatelessWidget {
  final List<NFTTraitModel> traits;
  NFTTraitList({
    required this.traits,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: traits.length,
        itemBuilder: (BuildContext context, int index) => Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      traits[index].trait_type.toString(),
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          12,
                          FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          traits[index].value.toString(),
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              14,
                              FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text(
                          "Hello",
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              14,
                              FontWeight.w700),
                        ),
                      ],
                    ),
                  ]),
            ));
  }
}
