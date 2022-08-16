import 'package:flutter/material.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';

class GalleryTag extends StatelessWidget {
  final String tag;
  final IconData icon;
  final bool isActive;

  GalleryTag({required this.tag, required this.icon, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isActive
              ? context.watch<ThemeProvider>().getHighLightColor()
              : context.watch<ThemeProvider>().getBackgroundColor(),
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Icon(icon,
              size: 30,
              color: isActive
                  ? context.watch<ThemeProvider>().getBackgroundColor()
                  : context.watch<ThemeProvider>().getHighLightColor()),
          SizedBox(
            width: 15,
          ),
          Text(
            tag,
            style: kPrimartFont(
                isActive
                    ? context.watch<ThemeProvider>().getBackgroundColor()
                    : context.watch<ThemeProvider>().getHighLightColor(),
                16,
                FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
