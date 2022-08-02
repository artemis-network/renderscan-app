import 'package:flutter/material.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';

class NFTTag extends StatelessWidget {
  final String tag;
  final IconData icon;

  NFTTag({required this.tag, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().getHighLightColor(),
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Icon(icon,
              size: 30,
              color: context.watch<ThemeProvider>().getBackgroundColor()),
          SizedBox(
            width: 15,
          ),
          Text(
            tag,
            style: kPrimartFont(
                context.watch<ThemeProvider>().getBackgroundColor(),
                16,
                FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class NFTTagRow extends StatelessWidget {
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
              NFTTag(tag: "Created", icon: Icons.create_outlined),
              NFTTag(tag: "All NFTs", icon: Icons.insert_photo_outlined),
              NFTTag(tag: "Collected", icon: Icons.collections_outlined),
              NFTTag(tag: "Imported", icon: Icons.import_export_outlined),
              NFTTag(
                  tag: "Generated", icon: Icons.settings_applications_outlined),
              NFTTag(tag: "Acitivity", icon: Icons.history_outlined),
            ],
          ),
        ));
  }
}
