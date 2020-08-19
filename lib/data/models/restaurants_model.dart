import 'package:erta7o/data/models/user_home_model.dart';

class RestaurantsModel {
  String msg;
  List<Restaurants> data;

  RestaurantsModel({this.msg, this.data});

  RestaurantsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Restaurants>();
      json['data'].forEach((v) {
        data.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
