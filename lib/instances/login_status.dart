import 'package:shared_preferences/shared_preferences.dart';

class Instances {
  static void saveLoginStatus(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login', status);
  }

  static void getLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    status = prefs.getBool('login')!;
  }
}
