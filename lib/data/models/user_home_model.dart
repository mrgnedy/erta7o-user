class UserHomeModel {
  String msg;
  RestaurantData data;

  UserHomeModel({this.msg, this.data});

  UserHomeModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new RestaurantData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class RestaurantData {
  List<Ads> ads;
  List<Restaurants> restaurants;

  RestaurantData({this.ads, this.restaurants});

  RestaurantData.fromJson(Map<String, dynamic> json) {
    if (json['ads'] != null) {
      ads = new List<Ads>();
      json['ads'].forEach((v) {
        ads.add(new Ads.fromJson(v));
      });
    }
    if (json['restaurants'] != null) {
      restaurants = new List<Restaurants>();
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ads != null) {
      data['ads'] = this.ads.map((v) => v.toJson()).toList();
    }
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ads {
  int id;
  String image;
  String createdAt;
  String updatedAt;

  Ads({this.id, this.image, this.createdAt, this.updatedAt});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Restaurants {
  int id;
  String nameAr;
  String nameEn;
  String lat;
  String lng;
  String address;
  String image;
  String desc;
  String rate;
  num valueadded;
  String distance;
  String createdAt;
  String updatedAt;

  Restaurants(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.lat,
      this.lng,
      this.address,
      this.image,
      this.desc,
      this.rate,
      this.valueadded,
      this.createdAt,
      this.updatedAt,
      this.distance
      });

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    lat = json['lat'].toString();
    lng = json['lng'].toString();
    address = json['address'];
    image = json['image'];
    desc = json['desc'];
    rate = json['rate'].toString();
    valueadded = json['valueadded'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    distance = json['distance'] != null? (json['distance'] as num).toStringAsFixed(2):null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['image'] = this.image;
    data['desc'] = this.desc;
    data['rate'] = this.rate;
    data['valueadded'] = this.valueadded;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
