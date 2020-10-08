class UserProfileModel {
  String msg;
  Data data;

  UserProfileModel({this.msg, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String name;
  String image;
  int notify;
  String phone;
  int orders;

  Data({this.name, this.image, this.notify, this.phone, this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    notify = json['notify'];
    phone = json['phone'];
    orders = json['orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['notify'] = this.notify;
    data['phone'] = this.phone;
    data['orders'] = this.orders;
    return data;
  }
}
