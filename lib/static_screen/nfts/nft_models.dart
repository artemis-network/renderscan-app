class ImageList {
  List<String>? images = [];
  ImageList({this.images});
  ImageList.fromJson(Map<String, dynamic> json) {
    var jsonImageList = json['images'];
    List<String> items = [];
    for (int i = 0; i < jsonImageList.length; i++) {
      items.add(jsonImageList[i]);
    }
    images = items;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    return data;
  }
}
