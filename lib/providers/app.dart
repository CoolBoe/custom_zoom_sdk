import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:wooapp/models/app.dart';
import 'package:wooapp/models/cityModel.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/services/app.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/widgets/loading.dart';

class AppProvider with ChangeNotifier {
  WebApiServices _webApiServices = new WebApiServices();
  List<CityModel> _citylist ;
  PriceRangeModel _priceRangeModel = new PriceRangeModel();
  List<CityModel> get getCityList => _citylist;
  PriceRangeModel get priceRange => _priceRangeModel;
  AppProvider(){
    resetStream();
  }
  void resetStream(){
    _webApiServices = new WebApiServices();
    _priceRangeModel = new PriceRangeModel();
    _citylist = new List<CityModel>();
  }

  fetchPriceRange() async{
   _priceRangeModel = await  _webApiServices.getPriceRange();
   notifyListeners();
  }
  fetchStateLIst({String states})async{
    printLog("responsee", states);
    _citylist = await _webApiServices.getStates(countryCode: states);
    printLog("fetchStateLIst", _citylist);
    notifyListeners();
  }
}