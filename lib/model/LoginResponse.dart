import 'Data.dart';

/// status : true
/// message : "تم تسجيل الدخول بنجاح"
/// data : {"id":18033,"name":"Ali Samir","email":"aliSamir@gmail.com","phone":"01011100222","image":"https://student.valuxapps.com/storage/assets/defaults/user.jpg","points":0,"credit":0,"token":"ewYurpnomQ2mE1cn81uIjcGu08nGM9n4ug8iApYG9KhubwpQ9RAxaln0ndckvFYeAwVePf"}

class LoginResponse {
  LoginResponse({
      this.status, 
      this.message, 
      this.data,});

  LoginResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}