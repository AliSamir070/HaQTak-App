import 'FavouritesProduct.dart';

/// id : 89831
/// FavouritesProduct : {"id":53,"price":5599,"old_price":10230,"discount":45,"image":"https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg","name":"JBL Xtreme 2 Portable Waterproof Bluetooth Speaker - Blue JBLXTREME2BLUAM","description":"GENERAL SPECIFICATIONS\r\nMusic playing time: 15 hours\r\nOutput power (W): 2 x 20\r\nDIMENSIONS\r\nDimensions: 13.6 x 28.8 x 13.2 centimeters\r\nWeight: 2.39 kilograms\r\nCONTROL AND CONNECTION SPECIFICATIONS\r\nBluetooth version: 4.2\r\nBATTERY\r\nBattery capacity: 10000 mAh\r\nCharging time: 3.5 hours\r\nFEATURES\r\n3.5 mm audio cable Input: Yes\r\nAuto power off: Yes\r\nBluetooth: Yes\r\nJBL Connect+: Yes\r\nPower bank: Yes\r\nSpeakerphone: Yes\r\nVoice Assistant: Yes\r\nWaterproof: Yes"}

class Data3 {
  Data3({
      this.id, 
      this.favouritesProduct,});

  Data3.fromJson(dynamic json) {
    id = json['id'];
    favouritesProduct = json['product'] != null ? FavouritesProduct.fromJson(json['product']) : null;
  }
  int? id;
  FavouritesProduct? favouritesProduct;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (favouritesProduct != null) {
      map['product'] = favouritesProduct?.toJson();
    }
    return map;
  }

}