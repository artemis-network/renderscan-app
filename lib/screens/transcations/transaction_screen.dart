import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
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
                        decoration: BoxDecoration(
                            color: context
                                .watch<ThemeProvider>()
                                .getHighLightColor()),
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
                            future: TransactionApi().getTranscations(),
                            builder: ((context, snapshot) {
                              dynamic data = snapshot.data;
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              return ListView.builder(
                                  cacheExtent: 9999,
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
                                    return Transaction(
                                        type: data[index].type,
                                        title: data[index].amount.toString(),
                                        date: date,
                                        subTitle:
                                            data[index].description.toString(),
                                        time: time);
                                  });
                            }))),
                  ))
                ],
              ),
            )));
  }
}
