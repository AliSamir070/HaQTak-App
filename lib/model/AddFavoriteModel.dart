import 'AddFavoriteData.dart';

/// status : true
/// message : "تمت الإضافة بنجاح"
/// add_favorite data : {"id":89832,"add_favorite product":{"id":58,"price":1083,"old_price":1083,"discount":0,"image":"https://student.valuxapps.com/storage/uploads/products/161545152160GOl.item_XXL_39275650_152762070.jpeg"}}

class AddFavoriteModel {
  AddFavoriteModel({
      this.status, 
      this.message, 
      this.addFavoritedata,});

  AddFavoriteModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    addFavoritedata = json['data'] != null ? AddFavoriteData.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  AddFavoriteData? addFavoritedata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (addFavoritedata != null) {
      map['data'] = addFavoritedata?.toJson();
    }
    return map;
  }

}