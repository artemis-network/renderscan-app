import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/transistion_screen/feedback/feedback_api.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String category = "UI";
  double ratings = 3;
  String message = "";
  String feedback = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(
                "Feedback",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    32,
                    FontWeight.bold),
              ),
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
            SizedBox(
              height: 30,
            ),
            FormField(
              label: "label",
              noLines: 1,
              onChange: (s) {
                setState(() {
                  message = s;
                });
              },
            ),
            FormField(
              onChange: (s) {
                feedback = s;
              },
              label: "feedback",
              noLines: 5,
            ),
            SizedBox(
              height: 30,
            ),
            RatingBar.builder(
              initialRating: ratings,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  ratings = rating;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            OutlinedButton(
                onPressed: () {
                  FeedbackApi()
                      .sendFeedBack(
                          category, ratings.toStringAsFixed(2), feedback)
                      .then((value) {
                    setState(() {
                      category = "UI";
                      ratings = 0;
                      message = "";
                      feedback = "";
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.greenAccent,
                        content: Text(
                          value.message,
                          style: kPrimartFont(
                              Colors.blueGrey, 22, FontWeight.bold),
                        )));
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      context.watch<ThemeProvider>().getPriamryFontColor()),
                  elevation: MaterialStateProperty.all(30),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "Submit",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getBackgroundColor(),
                        20,
                        FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
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
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
            labelText: label,
            labelStyle: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                18,
                FontWeight.bold),
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
