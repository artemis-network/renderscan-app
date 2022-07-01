class HttpServerConfig {
  final _host = "DEV";
  final _headers = {
    "accept": "application/json",
    "content-type": "application/json"
  };

  get headers => _headers;

  Uri getImageHost(String url) {
    if (_host == "DEV") return Uri.parse("http://192.168.1.14:5001/" + url);
    return Uri.parse("https://api.renderverse.io/backend" + url);
  }

  Uri getHost(String url) {
    if (_host == "DEV") return Uri.parse("http://192.168.1.14:5000/" + url);
    return Uri.parse("https://api.renderverse.io/backend" + url);
  }

  Uri azureServiceBusHost(String url) => Uri.parse(url);
}
