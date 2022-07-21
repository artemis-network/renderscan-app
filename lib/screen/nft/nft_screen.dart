import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screen/nft/components/nft_body.dart';
import 'package:renderscan/screen/nft/components/nft_details.dart';
import 'package:renderscan/screen/nft/components/nft_header.dart';
import 'package:renderscan/screen/nft/components/nft_titles.dart';
import 'package:renderscan/screen/nft/components/nft_traits.dart';
import 'package:renderscan/screen/nfts_collection/models/nft_detail.model.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_api.dart';

class NFTScreen extends StatelessWidget {
  final String contractAddress;
  final String tokenId;

  NFTScreen({
    required this.contractAddress,
    required this.tokenId,
  });

  detailsBuilder(
      String profilePic, String contract, String tokenId, String owner) {
    return [
      {
        "name": "Blockchain",
        "value": "ethereum",
        "pic": false,
      },
      {
        "name": "Address",
        "value": contract.toString().substring(0, 22) + "...",
        "pic": false,
      },
      {"name": "Token ID", "value": tokenId.toString(), "pic": false},
      {
        "name": "Creator",
        "value": owner.substring(0, 22) + "...",
        "profile": profilePic,
        "pic": true
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
                  ;
                  return SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        NFTHeader(
                            collectionName: nft.collectionName,
                            collectionSlug: nft.collectionSlug,
                            collectionImageUrl: nft.collectionImageUrl),
                        NFTBody(
                            imageUrl: nft.imageUrl,
                            name: nft.name,
                            lastPrice: nft.lastPrice.toString(),
                            owner: nft.owner.username,
                            profile_img_url: nft.owner.profile_img_url,
                            description: nft.description),
                        NFTTitles(title: "Details", icon: Icons.menu_outlined),
                        NFTDetailList(
                            details: detailsBuilder(
                                nft.creator_profile_pic,
                                nft.contractAddress,
                                nft.tokenId,
                                nft.owner.username)),
                        NFTTitles(title: "Traits", icon: Icons.menu_outlined),
                        NFTTraitList(traits: nft.traits),
                      ]));
                }

                return Container(
                  child: CircularProgressIndicator(),
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                );
              })),
        ),
      ),
    );
  }
}
