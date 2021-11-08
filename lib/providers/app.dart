import 'package:flutter/cupertino.dart';
import 'package:wooapp/models/app.dart';
import 'package:wooapp/models/app_setting.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/cityModel.dart';
import 'package:wooapp/models/filter.dart';
import 'package:wooapp/models/homeLayout.dart';
import 'package:wooapp/models/paymentGateway.dart';
import 'package:wooapp/rest/WebApiServices.dart';

class AppProvider with ChangeNotifier {
  late WebApiServices _webApiServices ;
  late List<PaymentGateway> _paymentGateway ;
  List<PaymentGateway> get getPaymentGateway => _paymentGateway;
  late List<CategoryModel> categories ;
  List<CategoryModel> get allCategories=> categories;
  late PriceRangeModel _priceRangeModel ;
  PriceRangeModel get priceRange => _priceRangeModel;
  late HomeLayout _homeLayout;
  HomeLayout get getHomeLayout => _homeLayout;
  late AppSetting _appSetting;
  late String _appStatus;
  String get appStatus=>_appStatus;
  AppSetting get getAppSetting  => _appSetting;
  late List<Option> _sizeList;
  late List<Option> _colorList;
  List<Option> get getSizeList =>_sizeList;
  List<Option> get getColorList=>_colorList;
  late List<ColorSizeModel> colorSizeList;
  List<ColorSizeModel> get getColorSizeList=> colorSizeList;

  List<CityModel> get getCityList => _cityList;
  late List<CityModel> _cityList ;
  AppProvider.initialize(){
    _webApiServices = new WebApiServices();
    _priceRangeModel = new PriceRangeModel();
    _homeLayout = new HomeLayout();
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
    colorSizeList  = await WebApiServices().getColorSizeList(id: "1");
    if(colorSizeList.length>0){

      for(int i =0; i<colorSizeList.length; i++){
        if(colorSizeList[i].name=="Color"){
          _colorList = colorSizeList[i].options!;
        }else if (colorSizeList[i].name=="Size"){
         _sizeList = colorSizeList[i].options!;
        }
      }
    }
    notifyListeners();
  }

  fetchStateList({String? states})async{
    _cityList = await _webApiServices.getStates(countryCode: states??"In");
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