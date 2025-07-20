import 'package:flutter_bili_app/http/core/dio_adapter.dart';
import 'package:flutter_bili_app/http/core/hi_net_adapter.dart';
import 'package:flutter_bili_app/http/core/hi_net_error.dart';
import 'package:flutter_bili_app/http/core/mock_adapter.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

class HiNet {
  HiNet._();
  static late HiNet _instance;
  factory HiNet.getInstance() {
    _instance = HiNet._();
    return _instance;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    dynamic error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      print(e.message);
    } catch (e) {
      error = e;
      print(e);
    }

    if (response == null) {
      printLog(error);
    }

    var result = response?.data;
    printLog(result);

    var status = response?.statusCode ?? 500;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status, result.toString(), data: result);
    }
  }

  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var adapter = DioAdapter();
    printLog('url:${request.url()}');
    printLog('method:${request.httpMethod()}');
    request.addHeader('test', '123');
    printLog('header:${request.header}');
    return adapter.send<T>(request);
  }

  void printLog(dynamic log) {
    print('hi_net:${log.toString()}');
  }
}
