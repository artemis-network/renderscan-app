import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class NFTDetailList extends StatelessWidget {
  final details;
  NFTDetailList({required this.details});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: details.length,
        itemBuilder: (BuildContext context, int index) => Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details[index]["name"].toString(),
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          12,
                          FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        details[index]["pic"]
                            ? Container(
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundImage:
                                      NetworkImage(details[index]["profile"]),
                                ),
                                margin: EdgeInsets.only(right: 10),
                              )
                            : Container(),
                        Text(
                          details[index]["value"].toString(),
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              14,
                              FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ]),
            ));
  }
}
