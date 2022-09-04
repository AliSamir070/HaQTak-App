import 'package:dio/dio.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/endpoint.dart';

class DioHelper{
  static late Dio dio;
  static void init(){
    dio = Dio(BaseOptions(baseUrl: Constants.baseUrl,
        receiveDataWhenStatusError: true,
    ));
  }
  static Future<Response> post_data({required String url ,required Map<String , dynamic> data,String lang="en", String? token})async{
    dio.options.headers = {
      "lang":lang,
      "Content-Type":"application/json",
      "Authorization":token
    };
    return dio.post(url,data: data);
  }
  static Future<Response> put_data({required String url ,required Map<String , dynamic> data,String lang="en", String? token})async{
    dio.options.headers = {
      "lang":lang,
      "Content-Type":"application/json",
      "Authorization":token
    };
    return dio.put(url,data: data);
  }
  static Future<Response> signout({required String url,required String token ,String lang = "en"})async{
    dio.options.headers = {
      "lang":lang,
      "Content-Type":"application/json",
      "Authorization":token
    };
    return dio.post(url);
  }
  static Future<Response> getData({required String url , Map<String , dynamic>? data,String lang="en", String? token}){
    dio.options.headers={
      "lang":lang,
      "Content-Type":"application/json",
      "Authorization":token
    };
    return dio.get(url);
  }
  static Future<Response> getCategories({required String url,String lang="en",int page=1}){
    dio.options.headers={
      "lang":lang,
    };
    return dio.get(url,queryParameters: {"page":page});
  }
}