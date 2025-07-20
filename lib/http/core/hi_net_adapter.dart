import 'dart:convert';
import 'package:flutter_bili_app/http/request/base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

class HiNetResponse<T> {
  T data;
  BaseRequest request;
  int statusCode;
  String statusMessage;
  dynamic extra;

  HiNetResponse(
    this.data,
    this.request,
    this.statusCode,
    this.statusMessage, {
    this.extra,
  });

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }

    return data.toString();
  }
}
