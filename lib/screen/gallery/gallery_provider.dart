import 'package:flutter/material.dart';
import 'package:renderscan/screen/gallery/gallery_models.dart';

class GalleryProvider extends ChangeNotifier {
  List<ImageItem> _imagesList = [];
  get imagesList => _imagesList;
  void initializeImageList(List<ImageItem> imageList) =>
      _imagesList = imageList;
}
