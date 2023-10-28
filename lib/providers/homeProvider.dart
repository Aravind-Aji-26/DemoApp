

import 'package:flutter/cupertino.dart';

import '../interfaces/homeInterface.dart';
import '../models/dummymodel.dart';

class HomeProvider extends ChangeNotifier {

  List<DummyModel> homeDataList = [];
  DummyModel? homeData;

  Future<List<DummyModel>> fetchHomeData() async {
    homeDataList = await HomeInterface.fetchHomeData();
    notifyListeners();
    return homeDataList;
  }

  Future<DummyModel?> fetchHomeDataById({required int? id}) async {
    homeData = await HomeInterface.fetchHomeDataById(id: id);
    notifyListeners();
    return homeData;
  }

}
