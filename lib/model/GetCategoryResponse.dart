import 'Data2.dart';

class GetCategoryResponse {
  GetCategoryResponse({
      this.status, 
      this.message, 
      this.data2,});

  GetCategoryResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data2 = json['data'] != null ? Data2.fromJson(json['data']) : null;
  }
  bool? status;
  dynamic message;
  Data2? data2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data2 != null) {
      map['data'] = data2?.toJson();
    }
    return map;
  }

}