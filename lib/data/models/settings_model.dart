class SettingsModel {
  String msg;
  SettingInfo data;

  SettingsModel({this.msg, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new SettingInfo.fromJson(json['data']) : null;
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

class SettingInfo {
  int id;
  String siteName;
  String siteLogo;
  String usage;
  String policy;
  String about;
  String how;
  num commission;
  String createdAt;
  String updatedAt;

  SettingInfo(
      {this.id,
      this.siteName,
      this.siteLogo,
      this.usage,
      this.policy,
      this.about,
      this.how,
      this.commission,
      this.createdAt,
      this.updatedAt});

  SettingInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteName = json['site_name'];
    siteLogo = json['site_logo'];
    usage = json['usage'];
    policy = json['policy'];
    about = json['about'];
    how = json['how'];
    commission = json['commission'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['site_name'] = this.siteName;
    data['site_logo'] = this.siteLogo;
    data['usage'] = this.usage;
    data['policy'] = this.policy;
    data['about'] = this.about;
    data['how'] = this.how;
    data['commission'] = this.commission;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
