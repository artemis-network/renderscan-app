import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/nft/nft_screen.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_api.dart';

class NFTCollectionGridTab extends StatelessWidget {
  final List<NFTDTO> nftItems;

  NFTCollectionGridTab({required this.nftItems});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.35,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: nftItems.length,
        itemBuilder: (BuildContext context, int index) {
          return NFTCollectionItem(
            nftdto: nftItems[index],
          );
        },
      ),
    ));
  }
}

class NFTCollectionItem extends StatelessWidget {
  final NFTDTO nftdto;

  NFTCollectionItem({
    required this.nftdto,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NFTScreen(nftdto: nftdto)));
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
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: Image.network(
                nftdto.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nftdto.name.length > 14
                              ? nftdto.name.substring(0, 14) + "..."
                              : nftdto.name,
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getSecondaryFontColor(),
                              14,
                              FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
