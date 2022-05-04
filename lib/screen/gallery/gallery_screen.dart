import 'package:flutter/material.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/gallery/gallery_api.dart';

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
    log.i(">> Images");
    log.i(imageList);
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
    return Scaffold(
      backgroundColor: kprimaryBackGroundColor,
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Text(
              'Gallery',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: kPrimaryLightColor,
              ),
              textAlign: TextAlign.center,
            ),
            _GalleryGrid(gallery: _imagesList)
          ])),
    );
  }
}

class _GalleryGrid extends StatelessWidget {
  final List<String> gallery;

  _GalleryGrid({required this.gallery});

  Future<String> getImageUrl(String filename) async {
    var username = await Storage().getItem("username");
    return 'https://renderscanner.blob.core.windows.net/scans/$username/$filename';
  }

  @override
  Widget build(BuildContext context) {
    ImageNBuilder(filename) {
      return FutureBuilder(
          future: getImageUrl(filename),
          builder: (context, snap) {
            if (snap.connectionState.name == "done") {
              return Image.network(snap.data.toString(),
                  height: 160, width: 120);
            }
            return spinkit;
          });
    }

    if (gallery.length == 0)
      return Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Text(
            "Gallery is empty",
            style: kPrimartFont(kPrimaryLightColor, 20, FontWeight.bold),
            textAlign: TextAlign.center,
          ));

    return Container(
      child: Expanded(
          child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 80,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
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
                padding: EdgeInsets.all(3),
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
                  child: ImageNBuilder(gallery[index]),
                ),
              ),
            );
          },
          itemCount: gallery.length,
        ),
      )),
    );
  }
}
