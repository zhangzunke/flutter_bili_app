import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bili_app/http/core/hi_net_adapter.dart';
import 'package:flutter_bili_app/http/core/hi_net_error.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    Response? dioResponse;
    var options = Options(headers: request.header);
    dynamic error;
    try {
      if (request.httpMethod() == HttpMethod.get) {
        dioResponse = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.post) {
        dioResponse = await Dio().post(
          request.url(),
          data: request.params,
          options: options,
        );
      } else if (request.httpMethod() == HttpMethod.delete) {
        dioResponse = await Dio().delete(
          request.url(),
          data: request.params,
          options: options,
        );
      }
    } on DioException catch (e) {
      error = e;
      dioResponse = e.response;
    }

    if (error != null) {
      throw HiNetError(
        dioResponse?.statusCode ?? -1,
        error.toString(),
        data: buildResponse<T>(dioResponse, request),
      );
    }

    return buildResponse<T>(dioResponse, request);
  }

  HiNetResponse<T> buildResponse<T>(Response? response, BaseRequest request) {
    return HiNetResponse<T>(
      response?.data as T,
      request,
      response?.statusCode ?? 0,
      response?.statusMessage ?? '',
      extra: response,
    );
  }
}
