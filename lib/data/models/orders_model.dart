class OrdersModel {
  String msg;
  List<OrderDetail> data;

  OrdersModel({this.msg, this.data});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<OrderDetail>();
      json['data'].forEach((v) {
        data.add(new OrderDetail.fromJson(v));
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

class OrderDetail {
  int id;
  String restaurantAr;
  String restaurantEn;
  String time;
  String image;
  String delivery;
  String deliveryId;
  String idForRate;
  String status;

  OrderDetail(
      {this.id,
      this.restaurantAr,
      this.restaurantEn,
      this.time,
      this.image,
      this.deliveryId,
      this.delivery,
      this.idForRate,
      this.status});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idForRate = json['id_for_rate'].toString();
    restaurantAr = json['restaurant_ar'];
    restaurantEn = json['restaurant_en'];
    time = json['time'];
    image = json['image'];
    delivery = json['delivery'];
    deliveryId = json['delivery_id'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_ar'] = this.restaurantAr;
    data['restaurant_en'] = this.restaurantEn;
    data['time'] = this.time;
    data['image'] = this.image;
    data['delivery'] = this.delivery;
    data['delivery_id'] = this.deliveryId;
    data['status'] = this.status;
    data['id_for_rate'] = this.idForRate;
    return data;
  }
}
