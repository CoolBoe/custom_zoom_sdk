import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';
import 'package:wooapp/models/app.dart';
import 'package:wooapp/models/app_setting.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/cityModel.dart';
import 'package:wooapp/models/filter.dart';
import 'package:wooapp/models/homeLayout.dart';
import 'package:wooapp/models/paymentGateway.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

class AppProvider with ChangeNotifier {
  WebApiServices _webApiServices = new WebApiServices();
  List<PaymentGateway> _paymentGateway ;
  List<PaymentGateway> get getPaymentGateway => _paymentGateway;
  List<CategoryModel> categories ;
  List<CategoryModel> get allCategories=> categories;
  PriceRangeModel _priceRangeModel = new PriceRangeModel();
  PriceRangeModel get priceRange => _priceRangeModel;
  HomeLayout _homeLayout = new HomeLayout();
  HomeLayout get getHomeLayout => _homeLayout;
  AppSetting _appSetting;
  String _appStatus;
  String get appStatus=>_appStatus;
  AppSetting get getAppSetting  => _appSetting;
  List<Option> _sizeList;
  List<Option> _colorList;
  List<Option> get getSizeList =>_sizeList;
  List<Option> get getColorList=>_colorList;
  List<ColorSizeModel> colorSizelist;
  List<ColorSizeModel> get getColorSizelist=> colorSizelist;

  List<CityModel> get getCityList => _citylist;
  List<CityModel> _citylist ;
  AppProvider.initialize(){
    fetchAppSetting();
    fetchHomeLayout();
    fetchPriceRange();
    fetchCategories();
    fetchColorSize();
    resetStream();
  }

  void resetStream(){
    _webApiServices = new WebApiServices();
    _priceRangeModel = new PriceRangeModel();
  }

  fetchAppSetting() async{
    _appSetting = await _webApiServices.getAppSetting();
    notifyListeners();
  }

  fetchPriceRange() async{
   _priceRangeModel = await  _webApiServices.getPriceRange();
   notifyListeners();
  }

  fetchCategories()async{
    categories  = await WebApiServices().getCategories();
    notifyListeners();
  }
  fetchColorSize()async{
    colorSizelist  = await WebApiServices().getColorSizeList(id: "1");
    if(colorSizelist!=null && colorSizelist.length>0){

      for(int i =0; i<colorSizelist.length; i++){
        if(colorSizelist[i].name=="Color"){
          _colorList = colorSizelist[i].options;
        }else if (colorSizelist[i].name=="Size"){
         _sizeList = colorSizelist[i].options;
        }
      }
    }
    notifyListeners();
  }

  fetchStateLIst({String states})async{
    printLog("responsee", states);
    _citylist = await _webApiServices.getStates(countryCode: states);
    printLog("fetchStateLIst", _citylist);
    notifyListeners();
  }
  fetchPaymentMethod()async{
    _paymentGateway = await _webApiServices.getPaymentGateway();
    notifyListeners();
  }
  fetchHomeLayout()async{
    _homeLayout = await _webApiServices.getHomeLayout();
    notifyListeners();
  }
}