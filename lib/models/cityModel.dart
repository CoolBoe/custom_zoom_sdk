// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

List<CityModel> cityModelFromJson(String str) => List<CityModel>.from(json.decode(str).map((x) => CityModel.fromJson(x)));

String cityModelToJson(List<CityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel {
  CityModel({
    this.id,
    this.sortName,
    this.name,
    this.code,
    this.countryId,
    this.stateId,
  });

  String? id;
  String? sortName;
  String? name;
  String? code;
  String? countryId;
  String? stateId;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json["id"],
    sortName: json["sort_name"],
    name: json["name"],
    code: json["code"],
    countryId:json["country_id"],
    stateId: json["state_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sort_name": sortName,
    "name": name,
    "code": code,
    "country_id": countryId,
    "state_id":  stateId,
  };
}
