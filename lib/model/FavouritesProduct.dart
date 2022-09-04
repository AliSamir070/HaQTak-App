/// id : 53
/// price : 5599
/// old_price : 10230
/// discount : 45
/// image : "https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg"
/// name : "JBL Xtreme 2 Portable Waterproof Bluetooth Speaker - Blue JBLXTREME2BLUAM"
/// description : "GENERAL SPECIFICATIONS\r\nMusic playing time: 15 hours\r\nOutput power (W): 2 x 20\r\nDIMENSIONS\r\nDimensions: 13.6 x 28.8 x 13.2 centimeters\r\nWeight: 2.39 kilograms\r\nCONTROL AND CONNECTION SPECIFICATIONS\r\nBluetooth version: 4.2\r\nBATTERY\r\nBattery capacity: 10000 mAh\r\nCharging time: 3.5 hours\r\nFEATURES\r\n3.5 mm audio cable Input: Yes\r\nAuto power off: Yes\r\nBluetooth: Yes\r\nJBL Connect+: Yes\r\nPower bank: Yes\r\nSpeakerphone: Yes\r\nVoice Assistant: Yes\r\nWaterproof: Yes"

class FavouritesProduct {
  FavouritesProduct({
      this.id, 
      this.price, 
      this.oldPrice, 
      this.discount, 
      this.image, 
      this.name, 
      this.description,});

  FavouritesProduct.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['discount'] = discount;
    map['image'] = image;
    map['name'] = name;
    map['description'] = description;
    return map;
  }

}