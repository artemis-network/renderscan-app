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

class Images {
  List<ImageItem>? images;
  Images({this.images});
  Images.fromJson(Map<String, dynamic> json) {
    images = json['images'];
  }

  get nft => null;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    return data;
  }
}
