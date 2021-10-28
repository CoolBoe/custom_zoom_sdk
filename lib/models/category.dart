import 'package:wooapp/widgets/rating_bar.dart';

class CategoryModel {
  int id;
  String name;
  String slug;
  int parent;
  String description;
  String display;
  ImageURL image;
  int count;

  CategoryModel(
      {this.id,
      this.name,
      this.slug,
      this.parent,
      this.description,
      this.display,
      this.image,
      this.count});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parent = json['parent'];
    description = json['description'];
    display = json['display'];
    image = json['image'] != null ? new ImageURL.fromJson(json['image']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['parent'] = this.parent;
    data['description'] = this.description;
    data['display'] = this.display;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    data['count'] = this.count;
    return data;
  }
}

class ImageURL {
  int id;
  String src;
  String title;

  ImageURL({this.id, this.src, this.title});

  ImageURL.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    src = json['src'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
    data['title'] = this.title;
    return data;
  }
}
