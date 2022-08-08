import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class ImageView extends StatelessWidget {
  final String url;
  final String tag;

  ImageView({required this.url, required this.tag});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  size: 32,
                )),
            Image.network(
              url,
              height: 500,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Mint",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        32,
                        FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 2,
                            color: context
                                .watch<ThemeProvider>()
                                .getHighLightColor()),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Delete",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        32,
                        FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 2,
                            color: context
                                .watch<ThemeProvider>()
                                .getHighLightColor()),
                      ]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
