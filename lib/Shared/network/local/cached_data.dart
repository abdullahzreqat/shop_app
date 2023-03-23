import 'package:shared_preferences/shared_preferences.dart';

class UserCached {
  static late SharedPreferences cachedData;

  static init() async {
    cachedData = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await cachedData.setString(key, value);
    }
    if (value is double) {
      return await cachedData.setDouble(key, value);
    }
    if (value is int) {
      return await cachedData.setInt(key, value);
    }

    return await cachedData.setBool(key, value);
  }

  static dynamic getData(key) {
    print("Get Data '$key'");
    return cachedData.get(key);
  }

  static Future<bool> removeData(key) async {
    return await cachedData.remove(key);
  }
}
