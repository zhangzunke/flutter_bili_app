import 'package:flutter_bili_app/http/request/base_request.dart';

class TestRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() => HttpMethod.get;

  @override
  bool needLogin() => false;

  @override
  String path() => 'uapi/test/test';
}
