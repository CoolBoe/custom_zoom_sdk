import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/services/category.dart';
import 'package:wooapp/widgets/loading.dart';

class CategoriesProvider with ChangeNotifier {

  List<CategoryModel> categories ;
  List<CategoryModel> get allCategories=> categories;

  fetchCategories()async{
    categories  = await WebApiServices().getCategories();
    notifyListeners();
  }
}
