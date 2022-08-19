import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/theme/theme_provider.dart';

class HeadingWidget extends StatelessWidget {
  final String text;
  HeadingWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
      child: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: context.watch<ThemeProvider>().getPriamryFontColor()),
      ),
    );
  }
}

class HeadingWithIconWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  HeadingWithIconWidget({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
      child: Row(children: [
        Icon(
          icon,
          size: 24,
          color: context.watch<ThemeProvider>().getPriamryFontColor(),
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: context.watch<ThemeProvider>().getPriamryFontColor()),
        )
      ]),
    );
  }
}

class HeadingWithImageWidget extends StatelessWidget {
  final String text;
  final String image;
  HeadingWithImageWidget({required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
      child: Row(children: [
        Image.asset(
          image,
          width: 24,
          height: 24,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: context.watch<ThemeProvider>().getPriamryFontColor()),
        )
      ]),
    );
  }
}
