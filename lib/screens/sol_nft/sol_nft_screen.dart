import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/screens/nft/components/nft_details.dart';
import 'package:renderscan/screens/nft/components/nft_titles.dart';
import 'package:renderscan/screens/nfts_collection/models/nft_sol.modal.dart';
import 'package:renderscan/screens/nfts_collection/nfts_collection_api.dart';
import 'package:renderscan/screens/sol_nft/components/nft_sol_body.dart';
import 'package:renderscan/screens/sol_nft/components/nft_sol_traits.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTSolScreen extends StatelessWidget {
  final String contract;

  NFTSolScreen({
    required this.contract,
  });

  detailsBuilder(String contract, String creator, String share) {
    return [
      {"name": "Blockchain", "value": "solana", "pic": false, "canCopy": false},
      {
        "name": "Creator",
        "value":
            creator.length > 12 ? creator.substring(0, 12) + "..." : creator,
        "profile": creator,
        "pic": true,
        "canCopy": true
      },
      {
        "name": "Share",
        "value": share.length > 12 ? share.substring(0, 12) + "..." : share,
        "pic": false,
        "canCopy": false
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          elevation: 0,
          actions: [],
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              child: Image.asset(
                "assets/icons/cancel.png",
                height: 24,
                width: 24,
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
          )),

      resizeToAvoidBottomInset: false, // set it to false
      body: Container(
        height: size.height,
        width: size.width,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: FutureBuilder(
            future: NFTCollectionAPI().getSolNFTByContract(contract, ""),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final NFTSolDetailModel nft =
                    snapshot.data as NFTSolDetailModel;
                return SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      SizedBox(
                        height: 20,
                      ),
                      NFTSolBody(
                          name: nft.name,
                          imageUrl: nft.imageUrl,
                          collectionName: nft.collectionName,
                          owner: nft.owner),
                      NFTTitles(title: "Details", icon: Icons.menu_outlined),
                      NFTDetailList(
                          details: detailsBuilder(nft.owner,
                              nft.creators[0].address, nft.creators[0].share)),
                      NFTTitles(title: "Traits", icon: Icons.menu_outlined),
                      NFTSolTraitList(
                        traits: nft.traits,
                      )
                    ]));
              }

              return Container(alignment: Alignment.center, child: spinkit());
            })),
      ),
    );
  }
}
