import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';


class CategoryServices{
  List<CategoryModel> categories = new List<CategoryModel>();

  Future<List<CategoryModel>>getCategories() => WebApiServices().getCategories().then((data){
      if(data.statusCode==HTTP_CODE_200){
        List<dynamic> values = new List<dynamic>();
        values =json.decode(data.body);
        printLog("API getCategories(200):- ",data.body);
        if(values.length>0){
          for(int i=0; i<values.length; i++ ){
            if(values[i]!=null){
              Map<String,dynamic> map = values[i];
              categories.add(CategoryModel.fromJson(map));
            }
          }
        }
      }else{
       printLog("Errorr", data.statusCode);
        toast(NETWORK_ERROR);
      }
      return categories;
    });
}