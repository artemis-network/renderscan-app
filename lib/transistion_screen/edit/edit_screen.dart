import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditScreen extends StatefulWidget {
  final String url;
  final Uint8List image;

  EditScreen({required this.url, required this.image});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool inEditMode = true;
  late Uint8List _image;

  @override
  void initState() {
    setState(() {
      _image = widget.image;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ExtendedImageEditorState> editorKey =
        new GlobalKey<ExtendedImageEditorState>();
    return SafeArea(
      child: Scaffold(
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          body: Container(
            padding: EdgeInsets.symmetric(
              vertical: 40,
            ),
            child: Column(
              children: [
                Text(
                  "Edit",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      24,
                      FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                inEditMode
                    ? Expanded(
                        child: ExtendedImage.memory(
                          _image,
                          fit: BoxFit.contain,
                          cacheRawData: true,
                          mode: ExtendedImageMode.editor,
                          extendedImageEditorKey: editorKey,
                          isAntiAlias: true,
                          initEditorConfigHandler: (state) => EditorConfig(),
                        ),
                      )
                    : Image.memory(
                        _image,
                        height: 300,
                        width: 300,
                      ),
                inEditMode
                    ? Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () =>
                                editorKey.currentState?.rotate(right: true),
                            icon: Icon(
                              FontAwesomeIcons.rotate,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getFavouriteColor(),
                            ),
                          ),
                          IconButton(
                            onPressed: () => editorKey.currentState?.flip(),
                            icon: Icon(
                              FontAwesomeIcons.leftRight,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getFavouriteColor(),
                            ),
                          ),
                          IconButton(
                              onPressed: () => editorKey.currentState?.reset(),
                              icon: Icon(
                                FontAwesomeIcons.trash,
                                color: context
                                    .watch<ThemeProvider>()
                                    .getFavouriteColor(),
                              )),
                          IconButton(
                              onPressed: () async {
                                editorKey.currentState!.activate();
                                final resp =
                                    await editorKey.currentState!.rawImageData;

                                setState(() {
                                  _image = resp;
                                  inEditMode = false;
                                });
                                // File file = File.fromRawPath(image);
                              },
                              icon: Icon(
                                FontAwesomeIcons.floppyDisk,
                                color: context
                                    .watch<ThemeProvider>()
                                    .getFavouriteColor(),
                              )),
                        ],
                      ))
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            inEditMode = true;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: context
                              .watch<ThemeProvider>()
                              .getFavouriteColor(),
                        ))
              ],
            ),
          )),
    );
  }
}

class EditButtonsGroup extends StatelessWidget {
  final List<Function> funcs;
  final List<IconData> icons;

  EditButtonsGroup({required this.funcs, required this.icons});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: funcs.length,
      cacheExtent: 9999,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        print(index);

        return IconButton(
            onPressed: () => funcs[index](),
            icon: Icon(
              icons[index],
              color: Colors.white,
              size: 30,
            ));
      },
    );
  }
}
