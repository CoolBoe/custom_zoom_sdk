import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:wooapp/models/app.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/services/app.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/widgets/loading.dart';

class AppProvider with ChangeNotifier {
  WebApiServices _webApiServices = new WebApiServices();
  PriceRangeModel _priceRangeModel = new PriceRangeModel();
  PriceRangeModel get priceRange => _priceRangeModel;
  AppProvider(){
    resetStream();
  }
  void resetStream(){
    _webApiServices = new WebApiServices();
    _priceRangeModel = new PriceRangeModel();
  }

  fetchPriceRange() async{
   _priceRangeModel = await  _webApiServices.getPriceRange();
   notifyListeners();
  }
}