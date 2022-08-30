import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/transcations/components/buy_ruby_modal.dart';
import 'package:renderscan/screens/transcations/components/transaction.dart';
import 'package:renderscan/screens/transcations/transaction_api.dart';
import 'package:renderscan/theme/theme_provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
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
            BalanceWidget()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [BalanceWidget()],
          ),
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              child: Image.asset(
                "assets/icons/back.png",
                height: 24,
                width: 24,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          ),
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(
          child: SideBar(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(
                    "assets/icons/transactions.png",
                    height: 46,
                    width: 46,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Transactions",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        20,
                        FontWeight.bold),
                  )
                ]),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: FutureBuilder(
                      future: TransactionApi().getTranscations(),
                      builder: ((context, snapshot) {
                        dynamic data = snapshot.data;
                        if (!snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [SizedBox(), SizedBox(), spinkit()],
                          );
                        }
                        if (data.length == 0) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/icons/not_found.png",
                                  height: 300,
                                  width: 300,
                                ),
                              ),
                              Text(
                                "No Transcations found!",
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    24,
                                    FontWeight.bold),
                              )
                            ],
                          );
                        }
                        return ListView.builder(
                            cacheExtent: 9999,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var date =
                                  data[index].date.toString().substring(0, 10);
                              var time =
                                  data[index].date.toString().substring(11, 16);
                              return Transaction(
                                  type: data[index].type,
                                  title: data[index].amount.toString(),
                                  date: date,
                                  subTitle: data[index].description.toString(),
                                  time: time);
                            });
                      }))),
            ],
          ),
        ));
  }
}
