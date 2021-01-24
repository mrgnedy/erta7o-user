// import 'dart:convert' as convert;

// class OrderModel {
//   OrderProductModel orderProductModel;
//   String time;
//   String lat;
//   String lng;
//   String address;
//   String copoun;
//   String restaurantID;

//   OrderModel(
//       {this.orderProductModel,
//       this.time,
//       this.lat,
//       this.lng,
//       this.address,
//       this.copoun,
//       this.restaurantID});

//   OrderModel.fromJson(Map<String, dynamic> json) {
//     // if()
//   }

//   Map<String, String> toJson() {
//     Map<String, String> json = Map<String, String>();
//     json['products'] = convert.json.encode(this.orderProductModel.toJson());
//     json['time'] = this.time;
//     json['lat'] = this.lat;
//     json['lng'] = this.lng;
//     json['address'] = this.address;
//     json['copon'] = this.copoun;
//     json['restaurant_id'] = this.restaurantID;
//     return json;
//   }
// }

// class OrderProductModel {
//   List<Product> products;

//   OrderProductModel({this.products});

//   OrderProductModel.fromJson(Map<String, dynamic> json) {
//     if (json['products'] != null) {
//       products = new List<Product>();
//       json['products'].forEach((v) {
//         products.add(new Product.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.products != null) {
//       data['products'] = this.products.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Product {
//   int menuId;
//   int quantity;
//   int type;
//   String addittions;

//   Product({this.menuId, this.quantity, this.type, this.addittions});

//   Product.fromJson(Map<String, dynamic> json) {
//     menuId = json['menu_id'];
//     quantity = json['quantity'];
//     type = json['type'];
//     addittions = json['addittions'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['menu_id'] = this.menuId;
//     data['quantity'] = this.quantity;
//     data['type'] = this.type;
//     data['addittions'] = this.addittions;
//     return data;
//   }
// }
