
import 'dart:convert';

import 'package:hive/hive.dart';




class PrefUtils {
  static final String TOKEN = "TOKEN";
  static const String APP_NAME = "DemoApp";




  Box getBox() {
    return Hive.box(APP_NAME);
  }

  clearAllTokens(){
    getBox().clear();
  }

  openBox() async  {

  }

  setToken(String? token) async {
    await Hive.openBox(APP_NAME);
    getBox().put(TOKEN, token);
  }



  getToken()  async{
    await Hive.openBox(APP_NAME);
    final token = getBox().get(TOKEN);
    return token;
  }


}