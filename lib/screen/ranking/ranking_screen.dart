import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screen/ranking/components/ranking_item.dart';
import 'package:renderscan/screen/ranking/ranking_mock.dart';
import 'package:renderscan/constants.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

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
                children: [
                  Topbar(
                    popSideBar: () => scaffoldKey.currentState?.openDrawer(),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Ranking 🏆",
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                20,
                                FontWeight.bold),
                          ),
                          Container(
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
                                          .getHighLightColor()
                                          .withOpacity(0.66),
                                      offset: Offset(0, 0)),
                                ]),
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              child: Options(),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                            ),
                          )
                        ],
                      )),
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: rankingMock.length,
                          itemBuilder: (context, index) => RankingItem(
                              ranking: rankingMock[index]['rank'].toString(),
                              url: rankingMock[index]['url'].toString(),
                              name: rankingMock[index]['name'].toString(),
                              floor: rankingMock[index]['floor'].toString(),
                              totalValue:
                                  rankingMock[index]['totalValue'].toString(),
                              owners: rankingMock[index]['owners'].toString(),
                              volume: rankingMock[index]['volume'].toString())),
                    ),
                  ))
                ],
              ),
            )));
  }
}

class Options extends StatefulWidget {
  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  String dropdownValue = 'Daily';

  @override
  Widget build(BuildContext context) {
    final Color color = context.watch<ThemeProvider>().getHighLightColor();
    final Color bg = context.watch<ThemeProvider>().getBackgroundColor();
    return DropdownButton<String>(
      dropdownColor: bg,
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      elevation: 16,
      style: TextStyle(color: color),
      underline: Container(
        height: 2,
        color: color,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Daily', 'Weekly', 'Monthly', 'Yearly']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
