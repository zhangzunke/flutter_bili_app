import 'package:flutter_bili_app/http/request/base_request.dart';

class LoginRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() => HttpMethod.post;

  @override
  bool needLogin() => false;

  @override
  String path() => '/uapi/user/login';
}
