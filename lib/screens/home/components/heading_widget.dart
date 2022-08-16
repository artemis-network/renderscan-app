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
