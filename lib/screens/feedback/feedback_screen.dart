import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/feedback/feedback_api.dart';
import 'package:renderscan/theme/theme_provider.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double ratings = 3;
  String feedback = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          actions: [],
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
              "assets/images/lion.png",
              height: 150,
              width: 150,
            ),
            SizedBox(
              height: 30,
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
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
                          color: context
                              .watch<ThemeProvider>()
                              .getHighLightColor(),
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            ratings = rating;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                      label: "feedback",
                      noLines: 3,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {
                            FeedbackApi()
                                .sendFeedBack(
                                    "", ratings.toStringAsFixed(2), feedback)
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
    ));
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
        color: context.watch<ThemeProvider>().getPriamryFontColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: DropdownButton<String>(
        isExpanded: true,
        borderRadius: BorderRadius.circular(10),
        value: category,
        dropdownColor: context.watch<ThemeProvider>().getPriamryFontColor(),
        icon: Icon(Icons.arrow_drop_down,
            color: context.watch<ThemeProvider>().getBackgroundColor()),
        alignment: Alignment.center,
        elevation: 40,
        style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: context.watch<ThemeProvider>().getHighLightColor()),
        focusColor: context.watch<ThemeProvider>().getNavbarColor(),
        onChanged: (String? newValue) => onChange(newValue),
        items: <String>['UI', 'Performance', 'Bug', 'Feature']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                value,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
