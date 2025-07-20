enum HttpMethod { get, post, delete }

abstract class BaseRequest {
  Map<String, String>? pathParams;
  var useHttps = true;

  String authority() {
    return 'api.devio.org';
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (pathStr.endsWith('/')) {
        pathStr = '$pathStr$pathParams';
      } else {
        pathStr = '$pathStr/$pathParams';
      }
    }

    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = {};
  BaseRequest add(String key, String value) {
    params[key] = value;
    return this;
  }

  Map<String, String> header = {};
  BaseRequest addHeader(String key, String value) {
    header[key] = value;
    return this;
  }
}
