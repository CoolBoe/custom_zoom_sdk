// To parse this JSON data, do
//
//     final colorSizeModel = colorSizeModelFromJson(jsonString);

import 'dart:convert';

List<ColorSizeModel> colorSizeModelFromJson(String str) => List<ColorSizeModel>.from(json.decode(str).map((x) => ColorSizeModel.fromJson(x)));

String colorSizeModelToJson(List<ColorSizeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ColorSizeModel {
  ColorSizeModel({
    this.id,
    this.name,
    this.slug,
    this.type,
    this.hasArchives,
    this.options,
  });

  int id;
  String name;
  String slug;
  String type;
  bool hasArchives;
  List<Option> options;

  factory ColorSizeModel.fromJson(Map<String, dynamic> json) => ColorSizeModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    type: json["type"],
    hasArchives: json["has_archives"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "type": type,
    "has_archives": hasArchives,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
  };
}

class Option {
  Option({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.count,
    this.checked,
  });

  int id;
  String name;
  String slug;
  String description;
  int count;
  bool checked;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    count: json["count"],
    checked: json["checked"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description,
    "count": count,
    "checked": checked,
  };
}


class Filters {

}
