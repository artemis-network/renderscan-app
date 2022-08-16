import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:renderscan/screens/nfts_collection/components/nft_collection_screen_nft_item.dart';
import 'package:renderscan/screens/nfts_collection/models/nft.model.dart';

class NFTCollectionNFTItemsGridTab extends StatelessWidget {
  final List<NFTModel> nftItems;

  NFTCollectionNFTItemsGridTab({
    required this.nftItems,
  });
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      itemCount: nftItems.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return NFTCollectionScreenNFTItem(
          nft: nftItems[index],
        );
      },
    );
  }
}
