class HttpServerConfig {
  final _host = "DEV";
  final _headers = {
    "accept": "application/json",
    "content-type": "application/json"
  };

  get headers => _headers;

  Uri getHost(String url) {
    if (_host == "DEV")
      return Uri.parse("http://192.168.1.14:5001/backend/v1" + url);
    return Uri.parse("https://api.renderverse.io/backend/v1" + url);
  }

  Uri azureServiceBusHost(String url) => Uri.parse(url);
}
