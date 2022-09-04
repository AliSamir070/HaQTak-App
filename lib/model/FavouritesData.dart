import 'Data3.dart';

/// current_page : 1
/// data3 : [{"id":89831,"FavouritesProduct":{"id":53,"price":5599,"old_price":10230,"discount":45,"image":"https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg","name":"JBL Xtreme 2 Portable Waterproof Bluetooth Speaker - Blue JBLXTREME2BLUAM","description":"GENERAL SPECIFICATIONS\r\nMusic playing time: 15 hours\r\nOutput power (W): 2 x 20\r\nDIMENSIONS\r\nDimensions: 13.6 x 28.8 x 13.2 centimeters\r\nWeight: 2.39 kilograms\r\nCONTROL AND CONNECTION SPECIFICATIONS\r\nBluetooth version: 4.2\r\nBATTERY\r\nBattery capacity: 10000 mAh\r\nCharging time: 3.5 hours\r\nFEATURES\r\n3.5 mm audio cable Input: Yes\r\nAuto power off: Yes\r\nBluetooth: Yes\r\nJBL Connect+: Yes\r\nPower bank: Yes\r\nSpeakerphone: Yes\r\nVoice Assistant: Yes\r\nWaterproof: Yes"}},{"id":89832,"product":{"id":58,"price":1083,"old_price":1083,"discount":0,"image":"https://student.valuxapps.com/storage/uploads/products/161545152160GOl.item_XXL_39275650_152762070.jpeg","name":"Stark Iron Kettlebell, 24 KG","description":"Brand: Stark\r\nColor: Black\r\nWeight: 24 Kg\r\nTargeted Group: Unisex"}}]
/// first_page_url : "https://student.valuxapps.com/api/favorites?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://student.valuxapps.com/api/favorites?page=1"
/// next_page_url : null
/// path : "https://student.valuxapps.com/api/favorites"
/// per_page : 35
/// prev_page_url : null
/// to : 2
/// total : 2

class FavouritesData {
  FavouritesData({
      this.currentPage, 
      this.data3, 
      this.firstPageUrl, 
      this.from, 
      this.lastPage, 
      this.lastPageUrl, 
      this.nextPageUrl, 
      this.path, 
      this.perPage, 
      this.prevPageUrl, 
      this.to, 
      this.total,});

  FavouritesData.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data3 = [];
      json['data'].forEach((v) {
        data3?.add(Data3.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  int? currentPage;
  List<Data3>? data3;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (data3 != null) {
      map['data'] = data3?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }

}