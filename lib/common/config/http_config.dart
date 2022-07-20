class HttpServerConfig {
  final _host = "PROD";
  final _headers = {
    "accept": "application/json",
    "content-type": "application/json"
  };

  get headers => _headers;

  Uri getHost(String url) {
    if (_host == "DEV")
      return Uri.parse("http://localhost:5001/renderscan/v1" + url);
    return Uri.parse("https://api.renderverse.io/renderscan/v1" + url);
  }

  Uri azureServiceBusHost(String url) => Uri.parse(url);
}
