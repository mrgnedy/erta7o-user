
class NotificationModel {
  String msg;
  List<NotificationDetail> data;

  NotificationModel({this.msg, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<NotificationDetail>();
      json['data'].forEach((v) {
        data.add(new NotificationDetail.fromJson(v));
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

class NotificationDetail {
  int id;
  String title;
  String body;
  int type;
  int userId;
  int restaurantID;
  int orderID;
  String createdAt;
  String updatedAt;

  NotificationDetail(
      {this.id,
      this.title,
      this.body,
      this.type,
      this.restaurantID,
      this.userId,
      this.orderID,
      this.createdAt,
      this.updatedAt});

  NotificationDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    restaurantID = json['restaurant_id'];
    orderID = json['order_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
