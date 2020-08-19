import 'user_home_model.dart';

class RestaurantModel {
  String msg;
  RestaurantDetialed data;

  RestaurantModel({this.msg, this.data});

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new RestaurantDetialed.fromJson(json['data']) : null;
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

class RestaurantDetialed {
  Restaurants restaurant;
  List<Rates> rates;
  List<Times> times;
  List<Products> products;

  RestaurantDetialed({this.restaurant, this.rates, this.times, this.products});

  RestaurantDetialed.fromJson(Map<String, dynamic> json) {
    restaurant = json['restaurant'] != null
        ? new Restaurants.fromJson(json['restaurant'])
        : null;
    if (json['rates'] != null) {
      rates = new List<Rates>();
      json['rates'].forEach((v) {
        rates.add(new Rates.fromJson(v));
      });
    }
    if (json['times'] != null) {
      times = new List<Times>();
      json['times'].forEach((v) {
        times.add(new Times.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    if (this.rates != null) {
      data['rates'] = this.rates.map((v) => v.toJson()).toList();
    }
    if (this.times != null) {
      data['times'] = this.times.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Rates {
  int id;
  int userId;
  int restaurantId;
  int rate;
  String content;
  String createdAt;
  String updatedAt;

  Rates(
      {this.id,
      this.userId,
      this.restaurantId,
      this.rate,
      this.content,
      this.createdAt,
      this.updatedAt});

  Rates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    rate = json['rate'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['restaurant_id'] = this.restaurantId;
    data['rate'] = this.rate;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Times {
  int id;
  int restaurantId;
  String saturday;
  String saturdayStartTime;
  String saturdayEndTime;
  String sunday;
  String sundayStartTime;
  String sundayEndTime;
  String monday;
  String mondayStartTime;
  String mondayEndTime;
  String tuesday;
  String tuesdayStartTime;
  String tuesdayEndTime;
  String wednesday;
  String wednesdayStartTime;
  String wednesdayEndTime;
  String thursday;
  String thursdayStartTime;
  String thursdayEndTime;
  String friday;
  String fridayStartTime;
  String fridayEndTime;
  String createdAt;
  String updatedAt;

  Times(
      {this.id,
      this.restaurantId,
      this.saturday,
      this.saturdayStartTime,
      this.saturdayEndTime,
      this.sunday,
      this.sundayStartTime,
      this.sundayEndTime,
      this.monday,
      this.mondayStartTime,
      this.mondayEndTime,
      this.tuesday,
      this.tuesdayStartTime,
      this.tuesdayEndTime,
      this.wednesday,
      this.wednesdayStartTime,
      this.wednesdayEndTime,
      this.thursday,
      this.thursdayStartTime,
      this.thursdayEndTime,
      this.friday,
      this.fridayStartTime,
      this.fridayEndTime,
      this.createdAt,
      this.updatedAt});

  Times.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    saturday = json['saturday'];
    saturdayStartTime = json['saturday_start_time'];
    saturdayEndTime = json['saturday_end_time'];
    sunday = json['sunday'];
    sundayStartTime = json['sunday_start_time'];
    sundayEndTime = json['sunday_end_time'];
    monday = json['monday'];
    mondayStartTime = json['monday_start_time'];
    mondayEndTime = json['monday_end_time'];
    tuesday = json['tuesday'];
    tuesdayStartTime = json['tuesday_start_time'];
    tuesdayEndTime = json['tuesday_end_time'];
    wednesday = json['wednesday'];
    wednesdayStartTime = json['wednesday_start_time'];
    wednesdayEndTime = json['wednesday_end_time'];
    thursday = json['thursday'];
    thursdayStartTime = json['thursday_start_time'];
    thursdayEndTime = json['thursday_end_time'];
    friday = json['friday'];
    fridayStartTime = json['friday_start_time'];
    fridayEndTime = json['friday_end_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['saturday'] = this.saturday;
    data['saturday_start_time'] = this.saturdayStartTime;
    data['saturday_end_time'] = this.saturdayEndTime;
    data['sunday'] = this.sunday;
    data['sunday_start_time'] = this.sundayStartTime;
    data['sunday_end_time'] = this.sundayEndTime;
    data['monday'] = this.monday;
    data['monday_start_time'] = this.mondayStartTime;
    data['monday_end_time'] = this.mondayEndTime;
    data['tuesday'] = this.tuesday;
    data['tuesday_start_time'] = this.tuesdayStartTime;
    data['tuesday_end_time'] = this.tuesdayEndTime;
    data['wednesday'] = this.wednesday;
    data['wednesday_start_time'] = this.wednesdayStartTime;
    data['wednesday_end_time'] = this.wednesdayEndTime;
    data['thursday'] = this.thursday;
    data['thursday_start_time'] = this.thursdayStartTime;
    data['thursday_end_time'] = this.thursdayEndTime;
    data['friday'] = this.friday;
    data['friday_start_time'] = this.fridayStartTime;
    data['friday_end_time'] = this.fridayEndTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Products {
  int id;
  int restaurantId;
  String nameAr;
  String nameEn;
  String image;
  String price;
  String createdAt;
  String updatedAt;

  Products(
      {this.id,
      this.restaurantId,
      this.nameAr,
      this.nameEn,
      this.image,
      this.price,
      this.createdAt,
      this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    image = json['image'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['image'] = this.image;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
