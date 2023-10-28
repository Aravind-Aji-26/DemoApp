
import 'dart:developer';


import '../api/api_methods.dart';
import '../api/api_request.dart';
import '../models/dummymodel.dart';
class HomeInterface {
  static Future<List<DummyModel>> fetchHomeData() async {
    try {
      final response = await ApiRequest.send(
          method: ApiMethod.GET,
          route: "posts",
          body: {},
          queries: {});
      return DummyModel.convertToList(response);
    } catch (err) {
      log(err.toString());
      return [];
    }
  }

  static Future<DummyModel?> fetchHomeDataById({required int? id}) async {
    try {
      final response = await ApiRequest.send(
          method: ApiMethod.GET,
          route: "posts/$id",
          body: {},
          queries: {});
      return DummyModel.fromJson(response);
    } catch (err) {
      log(err.toString());
      return null;
    }
  }


}