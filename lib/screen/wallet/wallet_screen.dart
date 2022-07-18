import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/screen/wallet/components/buy_ruby_modal.dart';
import 'package:renderscan/screen/wallet/components/wallet_transcation_list.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/wallet/wallet_api.dart';
import 'package:skeletons/skeletons.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    WalletApi().getTranscations().then((value) => log.i(value));
    super.initState();
  }

  topStatus(BuildContext context, Widget child) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.bottomToTop,
            child: BuyRubyModal(),
            ctx: context,
            duration: Duration(milliseconds: 300),
            childCurrent: child));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_outlined,
                    size: 32,
                    color:
                        context.watch<ThemeProvider>().getPriamryFontColor())),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                padding: EdgeInsets.only(top: 2, bottom: 2, left: 3, right: 2),
                child: Row(children: [
                  Icon(
                    CryptoFontIcons.ETH,
                    size: 14,
                    color: context.watch<ThemeProvider>().getBackgroundColor(),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text("1000",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getBackgroundColor(),
                          14,
                          FontWeight.w800)),
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color:
                            context.watch<ThemeProvider>().getBackgroundColor(),
                        borderRadius: BorderRadius.circular(4)),
                    child: Icon(
                      Icons.add_rounded,
                      color: context.watch<ThemeProvider>().getHighLightColor(),
                      size: 18,
                    ),
                  )
                ]),
                decoration: BoxDecoration(
                    color: context.watch<ThemeProvider>().getHighLightColor(),
                    borderRadius: BorderRadius.circular(6)),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 2, bottom: 2, left: 3, right: 2),
                child: Row(children: [
                  Icon(
                    CryptoFontIcons.ETH,
                    size: 14,
                    color: context.watch<ThemeProvider>().getBackgroundColor(),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text("0",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getBackgroundColor(),
                          14,
                          FontWeight.w800)),
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color:
                            context.watch<ThemeProvider>().getBackgroundColor(),
                        borderRadius: BorderRadius.circular(4)),
                    child: Icon(
                      Icons.add_rounded,
                      color: context.watch<ThemeProvider>().getHighLightColor(),
                      size: 18,
                    ),
                  )
                ]),
                decoration: BoxDecoration(
                    color: context.watch<ThemeProvider>().getFavouriteColor(),
                    borderRadius: BorderRadius.circular(6)),
              ),
            ])
          ],
        ),
      ),
    );
  }

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
                  topStatus(context, this.widget),
                  SingleChildScrollView(
                      child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: kPrimaryColor),
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  )),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: Text(
                      "Transcations",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          20,
                          FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: FutureBuilder(
                          future: WalletApi().getBalance(),
                          initialData: [],
                          builder: ((context, snapshot) {
                            return FutureBuilder(
                                future: WalletApi().getTranscations(),
                                builder: ((context, snapshot) {
                                  final data =
                                      snapshot.data as List<TransactionDTO>;

                                  return Skeleton(
                                    isLoading: snapshot.hasData,
                                    skeleton: SkeletonListView(
                                      itemCount: 10,
                                      itemBuilder: (context, index) {
                                        return Text("OK");
                                      },
                                    ),
                                    child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          var date = data[index]
                                              .date
                                              .toString()
                                              .substring(0, 10);
                                          var time = data[index]
                                              .date
                                              .toString()
                                              .substring(11, 16);
                                          return WalletTransactionList(
                                              type: data[index].type,
                                              title:
                                                  data[index].amount.toString(),
                                              date: date,
                                              subTitle: data[index]
                                                  .description
                                                  .toString(),
                                              time: time);
                                        }),
                                  );
                                }));
                          }),
                        )),
                  ))
                ],
              ),
            )));
  }
}
