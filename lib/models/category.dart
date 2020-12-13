import 'package:wooapp/widgets/rating_bar.dart';

class CategoryModel{
  String id;
  String name;
  String slug;
  String parent;
  String description;
  String display;
  String image;
  String count;


  CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.parent,
    this.description,
    this.display,
    this.image,
    this.count,
   });

  factory CategoryModel.fromJson(Map<String, dynamic>jsonMap){
    return CategoryModel(
      id: jsonMap['id'].toString(),
      name: jsonMap['name'].toString(),
      slug: jsonMap['slug'],
      parent: jsonMap['parent'].toString(),
      description: jsonMap['description'],
      display: jsonMap['display'],
      image: jsonMap['image'].toString(),
      count: jsonMap['count'].toString(),
    );
  }
  Map<String, dynamic> toJson()=>{
    'id':id,
    'name':name,
    'slug':slug,
    'parent':parent,
    'description':description,
    'display':display,
    'image':image,
    'count':count,
  };

}