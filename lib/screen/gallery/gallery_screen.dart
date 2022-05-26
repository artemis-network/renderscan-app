import 'package:flutter/material.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/gallery/gallery_api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);
  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<String> _imagesList = [];
  bool _isLoaded = false;
  bool _isRefreshed = false;
  get imagesList => _imagesList;
  get isLoaded => _isLoaded;
  get isRefreshed => _isRefreshed;
  void initializeImageList(List<String> imageList) {
    log.i(">> Images Loaded");
    setState(() {
      _imagesList = imageList;
    });
  }

  @override
  void initState() {
    super.initState();
    GalleryApi().callImages().then((resp) {
      List<String> imageList = resp.images as List<String>;
      initializeImageList(imageList);
    }).catchError((err) {
      log.e(">> Error");
      log.e(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kprimaryBackGroundColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: Text(
              "Gallery",
              style: kPrimartFont(kPrimaryLightColor, 24, FontWeight.bold),
            ),
          ),
          _GalleryGrid(gallery: _imagesList)
        ],
      ),
    );
  }
}

class _GalleryGrid extends StatelessWidget {
  final List<String> gallery;

  _GalleryGrid({required this.gallery});

  @override
  Widget build(BuildContext context) {
    ImageNBuilder(fileUrl) => Image.network(fileUrl, width: 220, height: 220);

    if (gallery.length == 0)
      return Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Text(
            "Gallery is empty",
            style: kPrimartFont(kPrimaryLightColor, 20, FontWeight.bold),
            textAlign: TextAlign.center,
          ));

    return Expanded(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => index % 7 == 0
            ? StaggeredTile.count(2, 2)
            : StaggeredTile.count(1, 1),
        itemBuilder: (context, index) {
          return RawMaterialButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => MintScreen(
              //             imageSource: getImageUrl(gallery[index]),
              //             filename: gallery[index],
              //           )),
              // );
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 2,
                          color: kprimaryNeuLight,
                          offset: Offset(-1, -1)),
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 8,
                          color: kprimaryNeuDark,
                          offset: Offset(5, 5)),
                    ]),
                // child: ImageNBuilder(gallery[index]),
                child: ImageNBuilder(
                  gallery[index].toString(),
                ),
              ),
            ),
          );
        },
        itemCount: gallery.length,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 3,
      ),
    ));
  }
}
