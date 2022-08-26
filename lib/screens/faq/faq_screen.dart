import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/faq/faq_item_row.dart';
import 'package:renderscan/theme/theme_provider.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [],
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
          "FAQ & HELP",
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              26,
              FontWeight.bold),
        ),
      ),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Image.asset(
                    "assets/icons/qna.png",
                    fit: BoxFit.fitWidth,
                    height: 160,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Tell us how we can help?",
                    textAlign: TextAlign.center,
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        26,
                        FontWeight.bold),
                  ),
                ),
                FaqTagRow(),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return GFAccordion(
                          contentBackgroundColor: context
                              .watch<ThemeProvider>()
                              .getBackgroundColor(),
                          collapsedTitleBackgroundColor: context
                              .watch<ThemeProvider>()
                              .getHighLightColor(),
                          expandedTitleBackgroundColor: context
                              .watch<ThemeProvider>()
                              .getHighLightColor(),
                          textStyle: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              20,
                              FontWeight.bold),
                          title: 'GF Accordion',
                          contentChild: Text(
                            "LLOremLOremLOremLOremLOremLOremLOremLOremLOremLOremLOremLOremLOremOrem",
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                14,
                                FontWeight.normal),
                          ),
                          collapsedIcon: Icon(Icons.add),
                          expandedIcon: Icon(Icons.minimize));
                    })
              ],
            ),
          )),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String image;
  final String main;
  final String sub;

  FAQItem({required this.image, required this.main, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                color: context.watch<ThemeProvider>().getHighLightColor())
          ],
          borderRadius: BorderRadius.circular(10),
          color: context.watch<ThemeProvider>().getBackgroundColor()),
      child: Row(children: [
        SizedBox(
          width: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            image,
            height: 64,
            width: 64,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              main,
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  18,
                  FontWeight.bold),
            ),
            Text(
              sub,
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  14,
                  FontWeight.normal),
            ),
          ],
        )
      ]),
    );
  }
}
