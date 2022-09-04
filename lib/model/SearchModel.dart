import 'FavouritesData.dart';
import 'SearchData.dart';

class SearchModel{
  SearchModel({
    this.status,
    this.message,
    this.searchData,});

  SearchModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    searchData = json['data'] != null ? SearchData.fromJson(json['data']) : null;
  }
  bool? status;
  dynamic message;
  SearchData? searchData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (searchData != null) {
      map['data'] = searchData?.toJson();
    }
    return map;
  }
}