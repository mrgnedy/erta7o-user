import 'dart:convert';

class OrderByIdModel {
  String msg;
  List<CurrentOrder> data;

  OrderByIdModel({this.msg, this.data}) {
    data = [
      CurrentOrder(
        menus: [Menus()],
        order: Order(),
      )
    ];
  }

  OrderByIdModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<CurrentOrder>();
      json['data'].forEach((v) {
        data.add(new CurrentOrder.fromJson(v));
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

class CurrentOrder {
  Order order;
  List<Menus> menus;

  CurrentOrder({this.order, this.menus});

  CurrentOrder.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['menus'] != null) {
      menus = new List<Menus>();
      json['menus'].forEach((v) {
        menus.add(new Menus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      //   data['order'] = this.order.toJson();
      data.addAll(order.toJson());
    }
    if (this.menus != null) {
      //   data['menus'] = this.menus.map((v) => v.toJson()).toList();
      data['products'] =
          json.encode({'products': this.menus.map((v) => v.toJson()).toList()});
    }
    return data;
  }
}

class Order {
  int id;
  int restaurantId;
  String restaurantAr;
  String restaurantEn;
  int userId;
  String user;
  String deliveryId;
  String deliveryIdRate;
  String delivery;
  String time;
  // S paymentType;
  String lat;
  String lng;
  String address;
  String totalPrice;
  String status;
  String copon;
  String createdAt;
  String updatedAt;

  Order(
      {this.id,
      this.restaurantId,
      this.restaurantAr,
      this.restaurantEn,
      this.userId,
      this.user,
      this.deliveryId,
      this.deliveryIdRate,
      this.delivery,
      this.time,
      // this.paymentType,
      this.lat,
      this.lng,
      this.address,
      this.totalPrice,
      this.status,
      this.copon='',
      this.createdAt,
      this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id '];
    restaurantAr = json['restaurant_ar'];
    restaurantEn = json['restaurant_en'];
    userId = json['user_id '];
    user = json['user'];
    deliveryId = json['delivery_id '].toString();
    deliveryIdRate = json['delivery_id_for_rate'].toString();
    delivery = json['delivery'];
    time = json['time'];
    // paymentType = json['payment_type'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    totalPrice = json['total_price'];
    status = json['status'].toString();
    createdAt = json['created_at '];
    updatedAt = json['updated_at'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['time'] = this.time;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['restaurant_id'] = this.restaurantId.toString();
    data['copon'] = this.copon??'';
    // data['restaurant_ar'] = this.restaurantAr;
    // data['restaurant_en'] = this.restaurantEn;
    // data['user_id '] = this.userId;
    // data['user'] = this.user;
    // data['delivery_id '] = this.deliveryId;
    // data['delivery'] = this.delivery;
    // // data['payment_type'] = this.paymentType;
    // data['total_price'] = this.totalPrice;
    // data['status'] = this.status;
    // data['created_at '] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Menus {
  int id;
  int orderId;
  int menuId;
  String menuAr;
  String menuEn;
  int type;
  String addittions;
  String quantity;
  num price;
  String createdAt;
  String updatedAt;

  Menus(
      {this.id,
      this.orderId,
      this.menuId,
      this.menuAr,
      this.menuEn,
      this.type = 0,
      this.addittions = '',
      this.quantity ='1',
      this.price,
      this.createdAt,
      this.updatedAt});

  Menus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id '];
    menuId = json['menu_id '];
    menuAr = json['menu_ar'];
    menuEn = json['menu_en'];
    type = json['type'];
    addittions = json['addittions'];
    quantity = json['quantity '];
    price = json['price '];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['menu_id'] = this.menuId.toString();
    data['quantity'] = this.quantity;
    data['addittions'] = this.addittions;
    data['type'] = this.type.toString();
    // data['id'] = this.id;
    // data['order_id '] = this.orderId;
    // data['menu_ar'] = this.menuAr;
    // data['menu_en'] = this.menuEn;
    // data['price '] = this.price;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}
