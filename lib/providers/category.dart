import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/rest/WebApiServices.dart';

class CategoriesProvider with ChangeNotifier {

  late List<CategoryModel> categories ;
  List<CategoryModel> get allCategories=> categories;

  CategoriesProvider.initialize(){
    fetchCategories();
  }

  fetchCategories()async{
    categories  = await WebApiServices().getCategories();
    notifyListeners();
  }
}
