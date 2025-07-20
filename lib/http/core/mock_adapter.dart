import 'package:flutter_bili_app/http/core/hi_net_adapter.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future<HiNetResponse<T>>.delayed(Duration(seconds: 1), () {
      return HiNetResponse<T>(
        {'code': 0, 'message': 'Success'} as T,
        request,
        401,
        'OK',
      );
    });
  }
}
