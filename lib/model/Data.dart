/// id : 18033
/// name : "Ali Samir"
/// email : "aliSamir@gmail.com"
/// phone : "01011100222"
/// image : "https://student.valuxapps.com/storage/assets/defaults/user.jpg"
/// points : 0
/// credit : 0
/// token : "ewYurpnomQ2mE1cn81uIjcGu08nGM9n4ug8iApYG9KhubwpQ9RAxaln0ndckvFYeAwVePf"

class Data {
  Data({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.image, 
      this.points, 
      this.credit, 
      this.token,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['image'] = image;
    map['points'] = points;
    map['credit'] = credit;
    map['token'] = token;
    return map;
  }

}