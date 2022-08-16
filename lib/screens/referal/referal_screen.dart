import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/referal/referal_api.dart';
import 'package:renderscan/theme/theme_provider.dart';

class ReferalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        alignment: Alignment.center,
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: 32,
                  color: context.watch<ThemeProvider>().getPriamryFontColor(),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Referal Code",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    24,
                    FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: "clipped"));
                  },
                  icon: Icon(
                    Icons.copy_all_outlined,
                    size: 32,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: ReferalApi().getReferalCode(),
              builder: ((context, snapshot) {
                dynamic data = snapshot.data;
                if (snapshot.hasData)
                  return Text(
                    data.substring(0, 24) + "...",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        18,
                        FontWeight.bold),
                  );
                else
                  return CircularProgressIndicator();
              })),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              "Your Referals",
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  32,
                  FontWeight.bold),
            ),
          ),
          Container(
            child: FutureBuilder(
                future: ReferalApi().getReferals(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  dynamic data = snapshot.data;
                  return ListView.builder(
                    cacheExtent: 9999,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: context
                                .watch<ThemeProvider>()
                                .getBackgroundColor(),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1,
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor())
                            ]),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        padding: EdgeInsets.all(10),
                        child: Row(children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(data[index].avatarUrl),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index].username,
                                  style: kPrimartFont(
                                      context
                                          .watch<ThemeProvider>()
                                          .getPriamryFontColor(),
                                      20,
                                      FontWeight.bold)),
                              Text(data[index].amount.toString(),
                                  style: kPrimartFont(
                                      context
                                          .watch<ThemeProvider>()
                                          .getPriamryFontColor(),
                                      16,
                                      FontWeight.bold))
                            ],
                          )
                        ]),
                      );
                    },
                  );
                })),
          )
        ]),
      ),
    ));
  }
}
