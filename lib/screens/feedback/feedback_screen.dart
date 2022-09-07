import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/feedback/feedback_api.dart';
import 'package:renderscan/screens/gallery/components/gallery_tag.dart';
import 'package:renderscan/theme/theme_provider.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double ratings = 3;
  String category = "UI";
  String feedback = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
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
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Feedback",
            textAlign: TextAlign.center,
            style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                26,
                FontWeight.bold),
          )),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Image.asset(
              "assets/icons/feedback_main.png",
              height: 150,
              width: 150,
            ),
            DropDown(
              category: category,
              onChange: (s) {
                setState(() {
                  setState(() {
                    category = s;
                  });
                });
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color:
                            context.watch<ThemeProvider>().getHighLightColor())
                  ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pleas rate your experience",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          14,
                          FontWeight.normal),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: RatingBar.builder(
                        initialRating: ratings,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        unratedColor: Colors.blueGrey,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            ratings = rating;
                          });
                        },
                      ),
                    ),
                    Text(
                      "Additional Comments",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          14,
                          FontWeight.normal),
                    ),
                    FormField(
                      onChange: (s) {
                        feedback = s;
                      },
                      label: "Gall",
                      noLines: 2,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {
                            FeedbackApi()
                                .sendFeedBack(category,
                                    ratings.toStringAsFixed(2), feedback)
                                .then((value) {
                              setState(() {
                                ratings = 0;
                                feedback = "";
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.greenAccent,
                                      content: Text(
                                        value.message,
                                        style: kPrimartFont(Colors.blueGrey, 22,
                                            FontWeight.bold),
                                      )));
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context
                                  .watch<ThemeProvider>()
                                  .getHighLightColor(),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              "Submit",
                              style: kPrimartFont(
                                  Colors.white, 20, FontWeight.bold),
                            ),
                          )),
                    ),
                  ]),
            )
          ],
        ),
      )),
    );
  }
}

class FormField extends StatelessWidget {
  final String label;
  final int noLines;
  final Function onChange;

  FormField(
      {required this.label, required this.noLines, required this.onChange});

  @override
  Widget build(BuildContext context) {
    var style = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 2,
          color: context.watch<ThemeProvider>().getFavouriteColor(),
          style: BorderStyle.solid,
        ));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: TextFormField(
          onChanged: ((value) => onChange),
          minLines: noLines,
          maxLines: noLines + 1,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getHighLightColor(),
              24,
              FontWeight.bold),
          decoration: InputDecoration(
            focusColor: context.watch<ThemeProvider>().getFavouriteColor(),
            focusedBorder: style,
            enabledBorder: style,
          )),
    );
  }
}

class DropDown extends StatelessWidget {
  final String category;
  final Function onChange;

  DropDown({required this.onChange, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: 50),
      decoration: BoxDecoration(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.list,
                size: 16,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: <String>['UI', 'Performance', 'Bug', 'Feature']
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: category,
          onChanged: (value) => onChange(value),
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
          buttonHeight: 50,
          buttonWidth: 160,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: context.watch<ThemeProvider>().getHighLightColor(),
          ),
          buttonElevation: 2,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 200,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: context.watch<ThemeProvider>().getHighLightColor(),
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      ),
    );
  }
}

class GalleryTagRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: context
            .watch<ThemeProvider>()
            .getHighLightColor()
            .withOpacity(0.66),
        elevation: 1,
        child: Container(
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          width: size.width * 1,
          height: size.height * .075,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              GalleryTag(
                tag: "Created",
                icon: "assets/icons/cc.png",
                isActive: true,
              ),
              GalleryTag(
                tag: "Gall",
                icon: "assets/icons/cc.png",
                isActive: false,
              ),
              GalleryTag(
                tag: "Collected",
                icon: "assets/icons/cc.png",
                isActive: false,
              ),
              GalleryTag(
                tag: "Imported",
                icon: "assets/icons/cc.png",
                isActive: false,
              ),
              GalleryTag(
                tag: "Generated",
                icon: "assets/icons/cc.png",
                isActive: false,
              ),
              GalleryTag(
                tag: "Activity",
                icon: "assets/icons/cc.png",
                isActive: false,
              ),
            ],
          ),
        ));
  }
}

fp() {
  return;
}
