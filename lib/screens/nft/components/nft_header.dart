import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_circle_left,
                size: 40,
                color: context.watch<ThemeProvider>().getSecondaryFontColor()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
