import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_api.dart';

class NFTScreen extends StatelessWidget {
  final NFTDTO nftdto;
  NFTScreen({required this.nftdto});

  @override
  Widget build(BuildContext context) {
    var details = [
      {
        "name": "Blockchain",
        "value": "ethereum",
        "pic": false,
        "profile": nftdto.creator_profile_pic
      },
      {
        "name": "Address",
        "value": nftdto.contractAddress.toString(),
        "pic": false,
        "profile": nftdto.creator_profile_pic
      },
      {"name": "Token ID", "value": nftdto.tokenId.toString(), "pic": false},
      {
        "name": "Creator",
        "value": nftdto.creator.toString().substring(0, 32) + "...",
        "profile": nftdto.creator_profile_pic,
        "pic": true
      },
    ];
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false, // set it to false
          body: Container(
            height: size.height,
            width: size.width,
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_circle_left,
                                size: 40,
                                color: context
                                    .watch<ThemeProvider>()
                                    .getSecondaryFontColor()),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            nftdto.name,
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                24,
                                FontWeight.bold),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(nftdto.imageUrl),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      clipBehavior: Clip.antiAlias,
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      elevation: 300,
                      shadowColor: Color.fromARGB(255, 41, 121, 255),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                          child: Column(children: [
                        InkWell(
                          child: Ink.image(
                            image: NetworkImage(nftdto.imageUrl),
                            height: 340,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ])),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                              nftdto.name,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  22,
                                  FontWeight.normal),
                            ),
                            Text(
                              nftdto.price.toString(),
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  18,
                                  FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Owned by " + nftdto.owner.username,
                                  style: kPrimartFont(
                                      context
                                          .watch<ThemeProvider>()
                                          .getSecondaryFontColor(),
                                      14,
                                      FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage(
                                      nftdto.owner.profile_img_url),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              nftdto.description,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  12,
                                  FontWeight.w500),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 30),
                                    child: Text(
                                      "Buy now",
                                      style: kPrimartFont(
                                          context
                                              .watch<ThemeProvider>()
                                              .getPriamryFontColor(),
                                          16,
                                          FontWeight.bold),
                                    ),
                                    decoration: BoxDecoration(
                                        color: context
                                            .watch<ThemeProvider>()
                                            .getBackgroundColor(),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 100,
                                              color: context
                                                  .watch<ThemeProvider>()
                                                  .getHighLightColor(),
                                              offset: Offset(0, 0)),
                                        ])),
                                CircleAvatar(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.share_outlined,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .getPriamryFontColor(),
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(children: [
                              Icon(
                                Icons.menu_outlined,
                                size: 35,
                                color: context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Details",
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    24,
                                    FontWeight.w500),
                              ),
                            ]),
                          ])),
                    ),
                    NFTDetailList(details: details),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Traits",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            24,
                            FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: size.width * 0.45,
                      child: NFTTraitlList(traits: nftdto.traits),
                    )
                  ]),
            ),
          )),
    );
  }
}

class NFTTraitlList extends StatelessWidget {
  final List<NFTTrait> traits;
  NFTTraitlList({required this.traits});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: traits.length,
        itemBuilder: (BuildContext context, int index) => Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.watch<ThemeProvider>().getHighLightColor(),
              ),
              alignment: Alignment.centerLeft,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      traits[index].value,
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getBackgroundColor(),
                          14,
                          FontWeight.w700),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      traits[index].trait_type,
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getBackgroundColor(),
                          14,
                          FontWeight.w500),
                    ),
                  ]),
            ));
  }
}

class NFTDetailList extends StatelessWidget {
  final details;
  NFTDetailList({required this.details});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: details.length,
        itemBuilder: (BuildContext context, int index) => Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        details[index]["pic"]
                            ? CircleAvatar(
                                radius: 16,
                                backgroundImage:
                                    NetworkImage(details[index]["profile"]),
                              )
                            : Container(),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          details[index]["value"].toString(),
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              16,
                              FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      details[index]["name"].toString(),
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          14,
                          FontWeight.w500),
                    ),
                  ]),
            ));
  }
}
