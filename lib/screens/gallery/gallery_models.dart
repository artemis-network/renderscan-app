class GalleryList {
  List<String>? images = [];
  GalleryList({this.images});
  GalleryList.fromJson(Map<String, dynamic> json) {
    var jsonGalleryList = json['images'];
    List<String> items = [];
    for (int i = 0; i < jsonGalleryList.length; i++) {
      items.add(jsonGalleryList[i]);
    }
    images = items;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    return data;
  }
}
