class ImageItem {
  String? filename;
  String? nft;
  ImageItem({this.filename, this.nft});
  ImageItem.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    nft = json['nft'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['nft'] = nft;
    return data;
  }
}

class ImageList {
  List<ImageItem>? images = [];
  ImageList({this.images});
  ImageList.fromJson(Map<String, dynamic> json) {
    var jsonImageList = json['images'];
    List<ImageItem> items = [];
    for (int i = 0; i < jsonImageList.length; i++) {
      ImageItem imageItem = ImageItem.fromJson(jsonImageList[i]);
      items.add(imageItem);
    }
    images = items;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    return data;
  }
}
