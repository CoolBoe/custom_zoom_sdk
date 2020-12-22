import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/services/app.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/widgets/loading.dart';

enum ProductBy{Default, Category, Price, Attribute}
class AppProvider with ChangeNotifier{
  bool isLoading = true;
  Map<String, dynamic> priceRangeModel ;
  ProductBy product = ProductBy.Default;
  String filterBy = "Default";
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;
  int productBy;
  AppServices _appServices = AppServices();

  AppProvider.initialize(){
      getPriceRange();
  }


  Future getPriceRange({String sort, String page, String per_page}) => WebApiServices().getPriceRange().then((data){
    if(data.statusCode==HTTP_CODE_200){
      printLog("API getPriceRange200 =>", data.body.toString());
      if(data.body.isNotEmpty){
        Map<String, dynamic> result = json.decode(data.body);
        return result;
      }
    }else{
      printLog("API getPriceRange Errorr Massage", data.body);

      // toast(NETWORK_ERROR);
    }
  });
  void changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }
  void changeProductBy({ProductBy newProductBy}){
    product = newProductBy;
    switch(newProductBy.toString()){
      case 'Category':
        filterBy = "Category";
        break;
      case 'Price':
        filterBy ='Price';
        break;
      case 'Attribute':
        filterBy ='Attribute';
        break;
      default :
        filterBy ='Default';
        break;
    }
    notifyListeners();
  }
}