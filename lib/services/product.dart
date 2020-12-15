import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

class ProductServices{

  List<ProductModel> products = new List<ProductModel>();

  Future<List<ProductModel>>getProducts({String sort, String page, String per_page}) => WebApiServices().getProducts(sort,page, per_page ).then((data){
    if(data.statusCode==HTTP_CODE_200){
      printLog("API getProduct200 =>", data.body.toString());
      List<dynamic> values = new List<dynamic>();
      if(data.body.isNotEmpty){
      values =json.decode(data.body);
        if(values.length>0){
          for(int i=0; i<values.length; i++ ){
            if(values[i]!=null){
              Map<String,dynamic> map = values[i];
              products.add(ProductModel.fromJson(map));
            }
          }
        }
      }
    }else{
      printLog("API getProduct Errorr Massage", data.body);
      toast(NETWORK_ERROR);
    }
    return products;
  });

  Future<List<ProductModel>>getProductsByCategory({String sort, String page, String per_page, String category}) => WebApiServices().getProductByCategory(sort,page, per_page, category ).then((data){
    if(data.statusCode==HTTP_CODE_200){
      printLog("API getProductByCategory200 =>", data.body.toString());
      List<dynamic> values = new List<dynamic>();
      if(data.body.isNotEmpty){
        products.clear();
        values =json.decode(data.body);
        if(values.length>0){
          for(int i=0; i<values.length; i++ ){
            if(values[i]!=null){
              Map<String,dynamic> map = values[i];
              products.add(ProductModel.fromJson(map));
            }
          }
        }
      }
    }else{
      printLog("API getProduct Errorr Massage", data.body);
      toast(NETWORK_ERROR);
    }
    return products;
  });
  Future<List<ProductModel>>getProductsByPrice({String sort, String page, String per_page, String min_price, String max_price}) => WebApiServices().getProductByPrice(sort,page, per_page, min_price, max_price ).then((data){
    if(data.statusCode==HTTP_CODE_200){
      printLog("API getProductByPrice200 =>", data.body.toString());
      List<dynamic> values = new List<dynamic>();
      if(data.body.isNotEmpty){
        products.clear();
        values =json.decode(data.body);
        if(values.length>0){
          for(int i=0; i<values.length; i++ ){
            if(values[i]!=null){
              Map<String,dynamic> map = values[i];
              products.add(ProductModel.fromJson(map));
            }
          }
        }
      }
    }else{
      printLog("API getProduct Errorr Massage", data.body);
      toast(NETWORK_ERROR);
    }
    return products;
  });

}