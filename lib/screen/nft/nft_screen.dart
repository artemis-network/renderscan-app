import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class NFTScreen extends StatelessWidget {
  int id;
  NFTScreen({required this.id});

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
                            "Doodles XIIV",
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                24,
                                FontWeight.bold),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                AssetImage("assets/images/lion.png"),
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
                            image: AssetImage("assets/images/lion.png"),
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
                              "Doodle #3221",
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  22,
                                  FontWeight.normal),
                            ),
                            Text(
                              "2.2 ETH",
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
                                  "Owned by Bear",
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
                                  backgroundImage:
                                      AssetImage("assets/images/lion.png"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Cyber Galz – The Customisable Female Humanoid from A.D. 2136 The genesis collection of 9,999 Galz features customisation via a crafting solution. Galz NFT holders can customise their NFT by adding, removing and changing a combination of Partz, the changeable attributes of Cyber Galz. NOTE: as the owner of Galz, you are entitled to a commercial license of Cyber Galz, which explained here: https://cybergalznft.com/legaloverview",
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
                    NFTTraitsList(traitsList: temp),
                    SizedBox(
                      height: 15,
                    )
                  ]),
            ),
          )),
    );
  }
}

var temp = [
  {"name": "Blockchain", "value": "Polygon"},
  {"name": "Address", "value": "0x06012c8cc2294xc29sca24c29ssc22"},
  {"name": "Token ID", "value": "0x06012c8cc2294xc29sca24c2312cs"}
];

class NFTTraitsList extends StatelessWidget {
  var traitsList = [];
  NFTTraitsList({required this.traitsList});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: traitsList.length,
        itemBuilder: (BuildContext context, int index) => Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      traitsList[index]["value"].toString(),
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          16,
                          FontWeight.w700),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      traitsList[index]["name"].toString(),
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          14,
                          FontWeight.w500),
                    ),
                  ]),
            ));
  }
}
