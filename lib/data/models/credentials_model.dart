class CredentialsModel {
  String msg;
  String apiToken;
  String verifynumber;
  Credential data;

  CredentialsModel({this.msg, this.apiToken, this.verifynumber, this.data});

  CredentialsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    apiToken = json['api_token'];
    verifynumber = json['verifynumber'].toString();
    data = json['data'] != null ? new Credential.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['api_token'] = this.apiToken;
    data['verifynumber'] = this.verifynumber;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Credential {
  String name;
  String phone;
  String lat;
  String lng;
  String address;
  String personalimage;
  String type;
  int confirmed;
  int notify;
  String apiToken;
  String googleToken;
  String updatedAt;
  String createdAt;
  String password;
  String confirmPass;
  int id;

  Credential(
      {this.name,
      this.phone,
      this.lat,
      this.lng,
      this.address,
      this.personalimage,
      this.type,
      this.confirmed,
      this.notify,
      this.apiToken,
      this.googleToken,
      this.updatedAt,
      this.createdAt,
      this.confirmPass,
      this.password,
      this.id});

  Credential.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    personalimage = json['personalimage'];
    type = json['type'];
    confirmed = json['confirmed'];
    notify = json['notify'];
    apiToken = json['api_token'];
    googleToken = json['google_token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['personalimage'] = this.personalimage;
    data['type'] = this.type;
    data['confirmed'] = this.confirmed;
    data['notify'] = this.notify;
    data['api_token'] = this.apiToken;
    data['google_token'] = this.googleToken;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }

  Map<String, dynamic> register() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = "+966${this.phone}";
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['password'] = this.password;
    data['google_token'] = this.googleToken?? "r";
    return data;
  }

  Map<String, dynamic> login() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = "+966${this.phone}";
    data['password'] = this.password;
    data['google_token'] = this.googleToken?? "d";
    return data;
  }
}
