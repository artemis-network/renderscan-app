import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/transcations/components/buy_ruby_modal.dart';
import 'package:renderscan/screens/transcations/transaction_api.dart';
import 'package:renderscan/theme/theme_provider.dart';

class BalanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          Navigator.of(context).push(PageTransition(
              type: PageTransitionType.bottomToTop,
              child: BuyRubyModal(),
              ctx: context,
              duration: Duration(milliseconds: 300),
              fullscreenDialog: true,
              childCurrent: this));
        },
        child: Container(
            child: FutureBuilder(
                future: TransactionApi().getBalance(),
                initialData: BalanceDTO(ruby: 0, superRuby: 0),
                builder: (context, snapshot) {
                  final data = snapshot.data as BalanceDTO;
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 2, bottom: 2, left: 3, right: 2),
                          child: Row(children: [
                            Image.asset(
                              "assets/icons/bruby.png",
                              height: 18,
                              width: 18,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(data.ruby.toString(),
                                style: kPrimartFont(Colors.blueGrey.shade800,
                                    14, FontWeight.w800)),
                            SizedBox(
                              width: 4,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getBackgroundColor(),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Icon(
                                Icons.add_rounded,
                                color: context
                                    .watch<ThemeProvider>()
                                    .getHighLightColor(),
                                size: 18,
                              ),
                            )
                          ]),
                          decoration: BoxDecoration(
                              color: context
                                  .watch<ThemeProvider>()
                                  .getFavouriteColor(),
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 2, bottom: 2, left: 3, right: 2),
                          child: Row(children: [
                            Image.asset(
                              "assets/icons/pruby.png",
                              height: 18,
                              width: 18,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(data.superRuby.toString(),
                                style: kPrimartFont(
                                    Colors.white, 14, FontWeight.w800)),
                            SizedBox(
                              width: 4,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getBackgroundColor(),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Icon(
                                Icons.add_rounded,
                                color: context
                                    .watch<ThemeProvider>()
                                    .getHighLightColor(),
                                size: 18,
                              ),
                            )
                          ]),
                          decoration: BoxDecoration(
                              color: context
                                  .watch<ThemeProvider>()
                                  .getHighLightColor(),
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      ]);
                })));
  }
}
