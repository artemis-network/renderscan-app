import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/referal/referal_api.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/logger.dart';

class ReferalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      appBar: AppBar(
        elevation: 0,
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        centerTitle: true,
        title: Text(
          "Refer & Earn",
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              24,
              FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        alignment: Alignment.center,
        child: Column(children: [
          Column(
            children: [
              Container(
                child: Image.asset("assets/icons/sound.png", fit: BoxFit.fill),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              ),
              SizedBox(
                height: 30,
              ),
              FutureBuilder(
                  future: ReferalApi().getReferalCode(),
                  builder: ((context, snapshot) {
                    dynamic data = snapshot.data;
                    if (snapshot.hasData)
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Referal Code",
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    24,
                                    FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: data));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.greenAccent,
                                      content: Text("Referal copied",
                                          style: kPrimartFont(Colors.blueGrey,
                                              22, FontWeight.bold)),
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.copy_all_outlined,
                                    size: 32,
                                    color: context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                  ))
                            ],
                          ),
                          Text(
                            data.length > 10
                                ? data.substring(0, 10) + "..."
                                : data,
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                18,
                                FontWeight.bold),
                          )
                        ],
                      );
                    else
                      return spinkit();
                  })),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            color: context
                                .watch<ThemeProvider>()
                                .getHighLightColor())
                      ]),
                  child: FutureBuilder(
                      future: ReferalApi().getReferals(),
                      builder: ((context, snapshot) {
                        if (!snapshot.hasData) return spinkit();
                        dynamic data = snapshot.data;
                        final totalReferals = data.length.toString();
                        log.i(totalReferals);
                        return Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage("assets/avtars/1.png"),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "500",
                                        style: kPrimartFont(
                                            context
                                                .watch<ThemeProvider>()
                                                .getPriamryFontColor(),
                                            16,
                                            FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Image.asset(
                                        "assets/icons/pruby.png",
                                        height: 18,
                                        width: 18,
                                      )
                                    ],
                                  ),
                                  Text(
                                    "You've earned till now",
                                    style: kPrimartFont(
                                        context
                                            .watch<ThemeProvider>()
                                            .getPriamryFontColor(),
                                        14,
                                        FontWeight.normal),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      })),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            color: context
                                .watch<ThemeProvider>()
                                .getHighLightColor())
                      ]),
                  child: FutureBuilder(
                      future: ReferalApi().getReferals(),
                      builder: ((context, snapshot) {
                        if (!snapshot.hasData) return spinkit();
                        dynamic data = snapshot.data;
                        final totalReferals = data.length.toString();
                        return Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage("assets/avtars/1.png"),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    totalReferals + " peers",
                                    style: kPrimartFont(
                                        context
                                            .watch<ThemeProvider>()
                                            .getPriamryFontColor(),
                                        16,
                                        FontWeight.bold),
                                  ),
                                  Text(
                                    "accepted your referals",
                                    style: kPrimartFont(
                                        context
                                            .watch<ThemeProvider>()
                                            .getPriamryFontColor(),
                                        14,
                                        FontWeight.normal),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      })),
                )
              ],
            ),
          )
        ]),
      )),
    );
  }
}
