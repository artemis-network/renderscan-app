import 'package:flutter/material.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/static_screen/explore/components/explore_collection_search.dart';
import 'package:renderscan/static_screen/explore/components/explore_nfts_search_grid.dart';
import 'package:renderscan/static_screen/explore/components/explore_search_buttond.dart';
import 'package:renderscan/static_screen/explore/components/explore_search_input.dart';
import 'package:renderscan/static_screen/explore/components/explore_switch.dart';
import 'package:renderscan/static_screen/home/home_provider.dart';

class ExploreScreen extends StatefulWidget {
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool submit = false;
  int tabIndex = 0;
  String search = "";

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(child: SideBar()),
      body: Column(children: [
        Topbar(popSideBar: () => scaffoldKey.currentState?.openDrawer()),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ExploreSearchInput(
                onChange: (String s) {
                  setState(() {
                    search = s;
                  });
                },
                label: tabIndex == 0 ? "Search NFTs" : "Search Collections",
              ),
              ExploreSearchButton(
                  submit: submit,
                  cancel: () {
                    setState(() {
                      if (tabIndex == 0) {
                        setState(() {
                          submit = false;
                          controller.clear();
                        });
                      } else {
                        setState(() {
                          submit = false;
                          controller.clear();
                        });
                      }
                    });
                  },
                  search: () {
                    setState(() {
                      if (tabIndex == 0) {
                        final s = search;
                        setState(() {
                          controller.clear();
                          submit = true;
                          context.read<HomeProvider>().exploreSearchNFTs(s);
                        });
                      }

                      log.i(tabIndex);

                      if (tabIndex == 1) {
                        final s = search;
                        log.i(s + " in compon");
                        setState(() {
                          controller.clear();
                          submit = true;
                          context
                              .read<HomeProvider>()
                              .exploreSearchCollection(s);
                        });
                      }
                    });
                  })
            ],
          ),
        ),
        ExploreSwitch(
            search: search,
            tabOne: () {
              setState(() {
                submit = false;
                tabIndex = 0;
              });
              context.read<HomeProvider>().exploreClearSearchCollections();
            },
            tabTwo: () {
              setState(() {
                submit = false;
                tabIndex = 1;
              });
              context.read<HomeProvider>().exploreClearSearchNFTs();
            },
            tabIndex: tabIndex),
        Expanded(
          child: tabIndex == 0
              ? ExploreNFTsSearchGrid()
              : ExploreCollectionSearchGrid(),
        )
      ]),
    );
  }
}
