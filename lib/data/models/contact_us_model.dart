import 'package:flutter/material.dart';

class ContactUsModel {
  String name;
  String phone;
  String message;

  ContactUsModel({this.name, this.phone, this.message});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = Map<String,dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['message'] = this.message;
    return data;
  }
}
