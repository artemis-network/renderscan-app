import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: kPrimaryLightColor),
      ),
      onPressed: () => press(),
      style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              color: kPrimaryLightColor,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
    );
  }
}
