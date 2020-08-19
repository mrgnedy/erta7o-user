class DeliveryOffersModel {
  String msg;
  List<DeliveryDetails> data;

  DeliveryOffersModel({this.msg, this.data});

  DeliveryOffersModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<DeliveryDetails>();
      json['data'].forEach((v) {
        data.add(new DeliveryDetails.fromJson(v));
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

class DeliveryDetails {
  int id;
  int deliveryId;
  int orderId;
  int userId;
  String price;
  String name;
  String rate;
  String image;
  String phone;
  String createdAt;
  String updatedAt;

  DeliveryDetails(
      {this.id,
      this.deliveryId,
      this.userId,
      this.price,
      this.name,
      this.rate,
      this.image,
      this.phone,
      this.orderId,
      this.createdAt,
      this.updatedAt});

  DeliveryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryId = json['delivery_id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    price = json['price'];
    name = json['name'];
    rate = json['rate'].toString();
    image = json['image'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delivery_id'] = this.deliveryId;
    data['user_id'] = this.userId;
    data['price'] = this.price;
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['image'] = this.image;
    data['order_id'] = this.orderId;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
