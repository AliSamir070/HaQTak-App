import 'AddFavoriteProduct.dart';

/// id : 89832
/// add_favorite product : {"id":58,"price":1083,"old_price":1083,"discount":0,"image":"https://student.valuxapps.com/storage/uploads/products/161545152160GOl.item_XXL_39275650_152762070.jpeg"}

class AddFavoriteData {
  AddFavoriteData({
      this.id, 
      this.addFavoriteproduct,});

  AddFavoriteData.fromJson(dynamic json) {
    id = json['id'];
    addFavoriteproduct = json['product'] != null ? AddFavoriteProduct.fromJson(json['product']) : null;
  }
  int? id;
  AddFavoriteProduct? addFavoriteproduct;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (addFavoriteproduct != null) {
      map['product'] = addFavoriteproduct?.toJson();
    }
    return map;
  }

}