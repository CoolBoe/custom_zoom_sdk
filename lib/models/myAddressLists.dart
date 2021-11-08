import 'dart:convert';

import 'package:wooapp/models/user.dart';
List<MyAddressList> myAddressFromJson(String str) => List<MyAddressList>.from(json.decode(str).map((x) => MyAddressList.fromJson(x)));

String myAddressToJson(List<MyAddressList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class MyAddressList{
  String? title;
  UserModel? userModel;
  MyAddressList(
      {
        this.title,
        this.userModel});

  MyAddressList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    userModel =
    json['userModel'] != null ? new UserModel.fromJson(json['userModel']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.userModel != null) {
      data['details'] = this.userModel!.toJson();
    }
    return data;
  }
}