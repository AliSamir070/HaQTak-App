import 'package:shared_preferences/shared_preferences.dart';

class PrefsCacheHelper{
  static SharedPreferences? sharedPreferences;

  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> saveData({required String key , required dynamic value})async{
    if(value is int) return await sharedPreferences!.setInt(key, value);
    if(value is bool) return await sharedPreferences!.setBool(key, value);
    if(value is String) return await sharedPreferences!.setString(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }
  static bool getOnboarding({required String key}){
    return sharedPreferences?.getBool(key)??false;
  }
  static String getToken({required String key}){
    return sharedPreferences?.getString(key)??"";
  }
  static Future<bool> clearToken() async{
    return await sharedPreferences!.remove("token");
  }
}