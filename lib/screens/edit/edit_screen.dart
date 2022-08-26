import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:renderscan/theme/theme_provider.dart';

class EditScreen extends StatefulWidget {
  final Uint8List image;

  EditScreen({required this.image});

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              child: Image.asset(
                "assets/icons/back.png",
                height: 24,
                width: 24,
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
          ),
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          centerTitle: true,
          title: Text(
            "Edit",
            style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                30,
                FontWeight.bold),
          ),
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        body: Container(
          padding: EdgeInsets.symmetric(
            vertical: 40,
          ),
          child: Column(
            children: [
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
                  : Container(
                      child: Image.memory(
                        _image,
                        height: 300,
                        width: 300,
                      ),
                      alignment: Alignment.center,
                    ),
              inEditMode
                  ? Expanded(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () async {
                              final cropRect =
                                  editorKey.currentState?.getCropRect() as Rect;
                              var img = editorKey.currentState?.rawImageData
                                  as Uint8List;
                              ImageEditorOption option = ImageEditorOption();
                              option.addOption(ClipOption.fromRect(cropRect));
                              final result = await ImageEditor.editImage(
                                image: img,
                                imageEditorOption: option,
                              ) as Uint8List;
                              setState(() {
                                _image = result;
                              });
                            },
                            icon: Icon(
                              Icons.crop,
                              size: 30,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getFavouriteColor(),
                            )),
                        IconButton(
                          onPressed: () async {
                            editorKey.currentState?.rotate(right: true);
                            final angle = editorKey.currentState?.editAction
                                ?.rotateAngle as double;
                            var img = editorKey.currentState?.rawImageData
                                as Uint8List;
                            ImageEditorOption option = ImageEditorOption();
                            option.addOption(RotateOption(angle.toInt()));
                            final result = await ImageEditor.editImage(
                              image: img,
                              imageEditorOption: option,
                            ) as Uint8List;
                            setState(() {
                              _image = result;
                            });
                          },
                          icon: Icon(
                            FontAwesomeIcons.rotate,
                            color: context
                                .watch<ThemeProvider>()
                                .getFavouriteColor(),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            editorKey.currentState?.flip();
                            var img = editorKey.currentState?.rawImageData
                                as Uint8List;
                            ImageEditorOption option = ImageEditorOption();
                            option.addOption(
                                FlipOption(horizontal: true, vertical: false));
                            final result = await ImageEditor.editImage(
                              image: img,
                              imageEditorOption: option,
                            ) as Uint8List;
                            setState(() {
                              _image = result;
                            });
                          },
                          icon: Icon(
                            FontAwesomeIcons.leftRight,
                            color: context
                                .watch<ThemeProvider>()
                                .getFavouriteColor(),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              editorKey.currentState?.reset();
                              setState(() {
                                _image = widget.image;
                              });
                            },
                            icon: Icon(
                              FontAwesomeIcons.trash,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getFavouriteColor(),
                            )),
                        IconButton(
                            onPressed: () async {
                              var img = editorKey.currentState?.rawImageData
                                  as Uint8List;
                              setState(() {
                                _image = img;
                                inEditMode = false;
                              });
                            },
                            icon: Icon(
                              FontAwesomeIcons.floppyDisk,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getFavouriteColor(),
                            )),
                      ],
                    ))
                  : InkWell(
                      child: Container(
                        width: size.width * 0.65,
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: context
                                .watch<ThemeProvider>()
                                .getFavouriteColor(),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor())
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getBackgroundColor(),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Edit",
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getBackgroundColor(),
                                    22,
                                    FontWeight.bold)),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          inEditMode = true;
                        });
                      },
                    )
            ],
          ),
        ));
  }
}
