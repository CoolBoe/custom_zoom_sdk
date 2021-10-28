// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

List<CityModel> cityModelFromJson(String str) => List<CityModel>.from(json.decode(str).map((x) => CityModel.fromJson(x)));

String cityModelToJson(List<CityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel {
  CityModel({
    this.id,
    this.sortname,
    this.name,
    this.phonecode,
    this.countryId,
    this.stateId,
  });

  String id;
  String sortname;
  String name;
  String phonecode;
  String countryId;
  String stateId;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json["id"],
    sortname: json["sortname"],
    name: json["name"],
    phonecode: json["phonecode"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    stateId: json["state_id"] == null ? null : json["state_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sortname": sortname,
    "name": name,
    "phonecode": phonecode,
    "country_id": countryId == null ? null : countryId,
    "state_id": stateId == null ? null : stateId,
  };
}
