class ScanResponse {
  String? filename;
  String? file;
  bool? isError;

  ScanResponse({this.filename, this.file, this.isError});

  ScanResponse.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    file = json['file'];
    isError = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['scan'] = file;
    data['error'] = isError;
    return data;
  }
}
