

import 'package:flutter/material.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

import '../constant/pref_utils.dart';

class ApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      if (data.headers['content-type'] != 'multipart/form-data') {
        data.headers['content-type'] = 'application/json';
      }
      final token = await PrefUtils().getToken();

      if (token != null) {
        data.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      print(e);
    }

    debugPrint(
        "------->Request Start\n${data.method}: ${data.baseUrl} \nHeaders: ${data.headers}\nBody: \n${data.body}\n<----------Request End",
        wrapWidth: 500);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint(
        "------->Response Start\n${data.method}${data.statusCode}: ${data.url} \nBody: \n${data.body}\n<----------Response End",
        wrapWidth: 500);

    return data;
  }
}
