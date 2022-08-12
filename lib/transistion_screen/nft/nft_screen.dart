import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft_detail.model.dart';
import 'package:renderscan/static_screen/nfts_collection/nfts_collection_api.dart';
import 'package:renderscan/transistion_screen/nft/components/nft_body.dart';
import 'package:renderscan/transistion_screen/nft/components/nft_details.dart';
import 'package:renderscan/transistion_screen/nft/components/nft_header.dart';
import 'package:renderscan/transistion_screen/nft/components/nft_titles.dart';
import 'package:renderscan/transistion_screen/nft/components/nft_traits.dart';

class NFTScreen extends StatelessWidget {
  final String contractAddress;
  final String tokenId;

  NFTScreen({
    required this.contractAddress,
    required this.tokenId,
  });

  detailsBuilder(
      String profilePic, String contract, String tokenId, String creator) {
    return [
      {
        "name": "Blockchain",
        "value": "ethereum",
        "pic": false,
        "canCopy": false
      },
      {
        "name": "Address",
        "value": contractAddress.length > 30
            ? contractAddress.substring(0, 30) + "..."
            : contractAddress.toString(),
        "pic": false,
        "canCopy": true
      },
      {
        "name": "Token ID",
        "value":
            tokenId.length > 30 ? tokenId.substring(0, 30) + "..." : tokenId,
        "pic": false,
        "canCopy": true
      },
      {
        "name": "Creator",
        "value":
            creator.length > 24 ? creator.substring(0, 24) + "..." : creator,
        "profile": profilePic,
        "pic": true,
        "canCopy": true
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, // set it to false
        body: Container(
          height: size.height,
          width: size.width,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          child: FutureBuilder(
              future:
                  NFTCollectionAPI().getNFTByContract(contractAddress, tokenId),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  final NFTDetailModel nft = snapshot.data as NFTDetailModel;
                  return SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        NFTHeader(),
                        NFTBody(
                          name: nft.name,
                          imageUrl: nft.imageUrl,
                          owner: nft.owner.address,
                          description: nft.description,
                          lastPrice: nft.lastPrice.toString(),
                          collectionName: nft.collectionName,
                          collectionSlug: nft.collectionSlug,
                          collectionImageUrl: nft.collectionImageUrl,
                          profile_img_url: nft.owner.profile_img_url,
                        ),
                        NFTTitles(title: "Details", icon: Icons.menu_outlined),
                        NFTDetailList(
                            details: detailsBuilder(nft.creator.profile_img_url,
                                contractAddress, tokenId, nft.creator.address)),
                        NFTTitles(title: "Traits", icon: Icons.menu_outlined),
                        NFTTraitList(
                          traits: nft.traits,
                          totalSupply: nft.totalSupply,
                        )
                      ]));
                }

                return Container(
                  alignment: Alignment.center,
                  child: spinkit(),
                );
              })),
        ),
      ),
    );
  }
}
