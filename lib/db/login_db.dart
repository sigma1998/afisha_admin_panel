import 'package:shared_preferences/shared_preferences.dart';

class LoginDb {
  static SharedPreferences? _sharedPreferences;

  static void init() async {
    if (_sharedPreferences != null) return;
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static void setToken(String token) {
    _sharedPreferences?.setString("token", token);
  }

  static String? getToken() {
    return _sharedPreferences?.getString('token');
  }

  static bool isRegistered() {
    if (getToken() == null) {
      return false;
    } else {
      return true;
    }
  }





  static logOut() async  {
    await _sharedPreferences?.remove('token');
  }
}