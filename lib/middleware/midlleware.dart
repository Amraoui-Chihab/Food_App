import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mr_yummy_v2/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class existeduser extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print("hello midlleware");
    print(prefs!.getString("login"));

    if (prefs!.getString("login") != null) {
      return RouteSettings(name: "general_page");
    }
  }
}
