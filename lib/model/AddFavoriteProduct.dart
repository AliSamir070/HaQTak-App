/// id : 58
/// price : 1083
/// old_price : 1083
/// discount : 0
/// image : "https://student.valuxapps.com/storage/uploads/products/161545152160GOl.item_XXL_39275650_152762070.jpeg"

class AddFavoriteProduct {
  AddFavoriteProduct({
      this.id, 
      this.price, 
      this.oldPrice, 
      this.discount, 
      this.image,});

  AddFavoriteProduct.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['discount'] = discount;
    map['image'] = image;
    return map;
  }

}