import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft_sol.modal.dart';
import 'package:renderscan/static_screen/nfts_collection/nfts_collection_api.dart';
import 'package:renderscan/transistion_screen/nft/components/nft_details.dart';
import 'package:renderscan/transistion_screen/nft/components/nft_header.dart';
import 'package:renderscan/transistion_screen/nft/components/nft_titles.dart';
import 'package:renderscan/transistion_screen/sol_nft/components/nft_sol_body.dart';
import 'package:renderscan/transistion_screen/sol_nft/components/nft_sol_traits.dart';

class NFTSolScreen extends StatelessWidget {
  final String contract;

  NFTSolScreen({
    required this.contract,
  });

  detailsBuilder(String contract, String creator, String share) {
    return [
      {
        "name": "Blockchain",
        "value": "solana",
        "pic": false,
      },
      {
        "name": "Creator",
        "value":
            creator.length > 12 ? creator.substring(0, 12) + "..." : creator,
        "profile": creator,
        "pic": true
      },
      {
        "name": "Share",
        "value": share.length > 12 ? share.substring(0, 12) + "..." : share,
        "pic": false
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    log.i(contract);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, // set it to false
        body: Container(
          height: size.height,
          width: size.width,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          child: SingleChildScrollView(
            child: FutureBuilder(
                future: NFTCollectionAPI().getSolNFTByContract(contract, ""),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final NFTSolDetailModel nft =
                        snapshot.data as NFTSolDetailModel;
                    log.i(nft);
                    return SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          NFTHeader(),
                          NFTSolBody(
                              name: nft.name,
                              imageUrl: nft.imageUrl,
                              collectionName: nft.collectionName,
                              owner: nft.owner),
                          NFTTitles(
                              title: "Details", icon: Icons.menu_outlined),
                          NFTDetailList(
                              details: detailsBuilder(
                                  nft.owner,
                                  nft.creators[0].address,
                                  nft.creators[0].share)),
                          NFTTitles(title: "Traits", icon: Icons.menu_outlined),
                          NFTSolTraitList(
                            traits: nft.traits,
                          )
                        ]));
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  );
                })),
          ),
        ),
      ),
    );
  }
}
