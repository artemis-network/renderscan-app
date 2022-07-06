import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/nft/nft_screen.dart';
import 'package:renderscan/screen/nfts/nfts_mock.dart';

class NFTCollectionScreen extends StatelessWidget {
  showModal(context) {
    final size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Filter",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            24,
                            FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: size.width * 1,
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      child: Text(
                        "Sort by",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            18,
                            FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: size.height * 0.28,
                      child: Expanded(child: ExploreSortByGrid()),
                    ),
                    Container(
                      width: size.width * 1,
                      padding: EdgeInsets.fromLTRB(20, 22, 20, 0),
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      child: Text(
                        "Filter by",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            18,
                            FontWeight.bold),
                      ),
                    ),
                    Expanded(child: ExploreFliterByGrid())
                  ]),
            ),
            color: context.watch<ThemeProvider>().getBackgroundColor(),
          );
        });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String id;
  NFTCollectionScreen({required this.id});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: SideBar(),
      ),
      body: Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Topbar(
              popSideBar: () => scaffoldKey.currentState?.openDrawer(),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SearchButton(),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: IconButton(
                        onPressed: () => showModal(context),
                        icon: Icon(Icons.menu,
                            size: 30,
                            color: context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor())),
                  )
                ]),
            SizedBox(
              height: 25,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: AssetImage("assets/images/lion.png"),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Doodles XIIV",
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  20,
                                  FontWeight.normal),
                            ),
                            Text(
                              "Creator",
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  16,
                                  FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Doodle",
                      style: kPrimartFont(
                          context
                              .watch<ThemeProvider>()
                              .getSecondaryFontColor(),
                          20,
                          FontWeight.normal),
                    ),
                    Text(
                      "Collection Name",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          16,
                          FontWeight.bold),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: NFTCollectionGrid(
              nftItems: nfts,
            ))
          ],
        ),
      ),
    ));
  }
}

class NFTCollectionItem extends StatelessWidget {
  final String url;
  final String name;
  final double price;
  final bool isHighlight;

  NFTCollectionItem(
      {required this.url,
      required this.name,
      required this.price,
      required this.isHighlight});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NFTScreen(id: 1)));
      },
      child: Container(
          height: size.height,
          decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 100,
                  color: context
                      .watch<ThemeProvider>()
                      .getHighLightColor()
                      .withOpacity(0.66),
                )
              ]),
          margin: EdgeInsets.fromLTRB(10, 25, 10, 90),
          width: size.width * 0.85,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAlias,
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            child: Column(
              children: [
                InkWell(
                  child: Ink.image(
                      height: size.height * 0.25,
                      image: NetworkImage(url),
                      fit: BoxFit.fitWidth),
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  16,
                                  FontWeight.normal),
                            ),
                            Text(
                              price.toString() + " ETH",
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  14,
                                  FontWeight.bold),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () => {},
                            icon: Icon(
                              Icons.favorite_outline,
                              size: 30,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getFavouriteColor(),
                            ))
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}

class NFTCollectionGrid extends StatefulWidget {
  final nftItems;
  NFTCollectionGrid({required this.nftItems});

  @override
  State<NFTCollectionGrid> createState() => _NFTCollectionGridState();
}

class _NFTCollectionGridState extends State<NFTCollectionGrid> {
  @override
  Widget build(BuildContext context) {
    int currentPageIndex = widget.nftItems.length ~/ 2;
    return Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: PageView.builder(
          allowImplicitScrolling: true,
          clipBehavior: Clip.antiAlias,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: PageController(
            viewportFraction: .8,
            initialPage: widget.nftItems.length ~/ 2,
          ),
          reverse: true,
          itemCount: widget.nftItems.length,
          onPageChanged: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          itemBuilder: (BuildContext context, int index) {
            if (currentPageIndex == index) {
              return NFTCollectionItem(
                  name: widget.nftItems[index]["name"],
                  price: widget.nftItems[index]["price"],
                  url: widget.nftItems[index]["url"],
                  isHighlight: true);
            }
            return NFTCollectionItem(
                name: widget.nftItems[index]["name"],
                price: widget.nftItems[index]["price"],
                url: widget.nftItems[index]["url"],
                isHighlight: false);
          },
        ));
  }
}

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.08,
      width: size.width * 0.78,
      child: TextField(
        style: kPrimartFont(context.watch<ThemeProvider>().getForegroundColor(),
            16, FontWeight.normal),
        cursorColor: context.watch<ThemeProvider>().getForegroundColor(),
        decoration: InputDecoration(
            focusColor: context.watch<ThemeProvider>().getForegroundColor(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: context.watch<ThemeProvider>().getHighLightColor()),
                borderRadius: BorderRadius.circular(20)),
            hintText: "Search for NFTs",
            hintStyle: kPrimartFont(
                context.watch<ThemeProvider>().getForegroundColor(),
                18,
                FontWeight.bold),
            suffixIcon: Icon(Icons.clear_outlined,
                color: context.watch<ThemeProvider>().getPriamryFontColor()),
            prefixIcon: Icon(Icons.search_rounded,
                color: context.watch<ThemeProvider>().getPriamryFontColor())),
      ),
    );
  }
}

class ExploreSortByGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 5 / 2,
          children: [
            ExploreSortByTag(text: "Low price"),
            ExploreSortByTag(text: "High price"),
            ExploreSortByTag(text: "Low volume"),
            ExploreSortByTag(text: "High volume"),
            ExploreSortByTag(text: "Trending"),
            ExploreSortByTag(text: "Almost sold"),
            ExploreSortByTag(text: "Most Owners"),
            ExploreSortByTag(text: "Few Owners"),
            ExploreSortByTag(text: "Oldest️"),
            ExploreSortByTag(text: "Newest"),
          ],
        ));
  }
}

class ExploreFliterByGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 5 / 2,
          children: [
            ExploreSortByTag(text: "Upcoming"),
            ExploreSortByTag(text: "Sale"),
          ],
        ));
  }
}

class ExploreSortByTag extends StatelessWidget {
  final String text;

  ExploreSortByTag({required this.text}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20,
        width: 50,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text(
          text,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              12,
              FontWeight.bold),
        ),
        decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().getHighLightColor(),
          borderRadius: BorderRadius.circular(15),
        ));
  }
}
