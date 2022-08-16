import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screens/gallery/components/gallery_tag.dart';

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
                icon: Icons.create_outlined,
                isActive: true,
              ),
              GalleryTag(
                tag: "All Gallerys",
                icon: Icons.insert_photo_outlined,
                isActive: false,
              ),
              GalleryTag(
                tag: "Collected",
                icon: Icons.collections_outlined,
                isActive: false,
              ),
              GalleryTag(
                tag: "Imported",
                icon: Icons.import_export_outlined,
                isActive: false,
              ),
              GalleryTag(
                tag: "Generated",
                icon: Icons.settings_applications_outlined,
                isActive: false,
              ),
              GalleryTag(
                tag: "Acitivity",
                icon: Icons.history_outlined,
                isActive: false,
              ),
            ],
          ),
        ));
  }
}