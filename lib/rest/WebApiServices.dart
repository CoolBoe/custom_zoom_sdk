import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/app.dart';
import 'package:wooapp/models/app_setting.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/models/cityModel.dart';
import 'package:wooapp/models/coupons.dart';
import 'package:wooapp/models/filter.dart';
import 'package:wooapp/models/homeLayout.dart';
import 'package:wooapp/models/order.dart';
import 'package:wooapp/models/paymentGateway.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/models/revieworder.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:wooapp/widgets/loading.dart';

class WebApiServices {
  var dio = Dio();
  Response response;
  String BaseAuth = 'Basic ' + base64Encode(utf8.encode('${WebRequestConstants.BaseAuthId}:${WebRequestConstants.BaseAuthPass}'));
  Map<String, String> cookies = {};
  Map<String, String> headers =<String, String> {
    HttpHeaders.contentTypeHeader: "application/json",
  };

  Future<Details> userLogin(String email, String password) async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      var params = new FormData.fromMap(
          {'email': email, 'password': password});
      String url = WebRequestConstants.getWPBaseUrl +
          WebRequestConstants.getDomainUrl +
          WebRequestConstants.LOGIN;
      var response = await dio.post(url, options: new Options(headers: headers), data: params);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
       UserModel userModel = UserModel.fromJson(response.data);
       if (userModel.code == '1') {
         Details model = userModel.details;
         return model;
       } else {
         return null;
       }
      } else {
        return null;
      }
    }on DioError catch(e){
      return null;
    }
  }

  Future<bool> userRegister(String name, String email, String password) async {
    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar cookies = new PersistCookieJar(
          dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(cookies));
      var params = new FormData.fromMap(
          {'fname': name, 'email': email, 'password': password});
      response = await dio.post(WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.REGISTER,options: new Options(headers: headers), data: params,);
      Map<String, dynamic> result = response.data;
      if (result['status'] == '0'){
        return false;
      }
      else {
        return true;
      }

    } on DioError catch(e){
      return false;
    }

  }

  Future<bool> forgetPassword(String email) async{
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getBaseUrl +
          WebRequestConstants.getDomainUrl +
          WebRequestConstants.FORGOT_PASSWORD;
      var params = new FormData.fromMap(
          {'email': email});
      var response = await dio.post(url, options: new Options(headers: headers), data:params );
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        Map<String, dynamic> result = json.decode(response.data);
        if (result['code'] == '1') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }on DioError catch(e){
      return false;
    }
  }

  Future<bool> changePassword(String user_id) async{
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getBaseUrl +
          WebRequestConstants.getDomainUrl +
          WebRequestConstants.CHANGE_PASSWORD;
      var params = new FormData.fromMap(
          {'user_id': user_id});
      var response = await dio.post(url, options: new Options(headers: headers),data: params);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        Map<String, dynamic> result = json.decode(response.data);
        if (result['code'] == '1') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }on DioError catch(e){
     return false;
    }
  }

  Future<Details> socialLogin({String mode, String name, String email, String firstName, String lastName}) async{
    try{
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
    dio.interceptors.add(CookieManager(sj));
    String url  = WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.SOCIAL_LOGIN;
    var facebookParams =
        { 'mode': mode,
          'name': name,
          'email': email,
          'first_name': firstName,
          'last_name': lastName};
    var googleParams =
    { 'mode': mode,
      'displayName': name,
      'email': email,
      'givenName': firstName,
      'familyName': lastName};

    var response = await dio.post(url, options: new Options(headers: headers), data: mode=="google" ? googleParams: facebookParams);
   if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
      UserModel userModel = UserModel.fromJson(response.data);
      if (userModel.code == '1') {
        Details model = userModel.details;
        return model;
      } else {
        return null;
      }
    } else {
     return null;
    }
    }on DioError catch(e){
    return null;
  }
  }

  Future<List<CategoryModel>> getCategories()async {
     List<CategoryModel> list =[];
     try{
       Directory tempDir = await getApplicationDocumentsDirectory();
       String tempPath = tempDir.path;
       CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
       dio.interceptors.add(CookieManager(sj));
       String url  = WebRequestConstants.getWPBaseUrl +
           WebRequestConstants.getDomainUrl +
           WebRequestConstants.ALL_CATEGORIES;
       var response = await dio.get(url, options: new Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}));
       printLog("getCategories", url);
       if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
         list = (response.data as List).map((i) => CategoryModel.fromJson(i)).toList();
         return list;
       } else {
         return null;
        }
     }on DioError catch(e){
       printLog("getCategoryError=>", e.response);
       return null;
     }
  }

  Future<List<ProductModel>> getProducts(
      {String sort, String page, String per_page, String category_id, String str_search, String brand, String max_price, String min_price,
        bool on_sale, bool featured, List<int> productIDs, String colorList, String sizeList }) async {
    printLog("ghjghjghjgh", productIDs);
     List<ProductModel> list = [];
    try{
        String parameter = "";
        if(sort!=null){
          parameter+="?sort=$sort";
        }
        if(featured!=null){
          parameter+="&featured=$featured";
        }
        if(on_sale!=null){
          parameter+="&on_sale=$on_sale";
        }
        if(min_price!=null){
          parameter+="&min_price=$min_price";
        }
        if(max_price!=null){
          parameter+="&max_price=$max_price";
        }
        if(brand!=null){
          parameter+="&brand=$brand";
        }
        if(str_search!=null){
          parameter+="&search=$str_search";
        }
        if(per_page!=null){
          parameter+="&per_page=$per_page";
        }
        if(page!=null){
          parameter+="&page=$page";
        }
        if(category_id!=null){
          parameter+="&category=$category_id";
        }
        if(productIDs!=null){
          parameter+="&include=${productIDs.join(",").toString()}";
        }
        if(colorList!=null){
          var value = "pa_color:$colorList";
          parameter+=jsonEncode(value);
        }
        if(sizeList!=null){
          var value = "pa_size:$sizeList";
          parameter+=jsonEncode(value);
        }

        Directory tempDir = await getApplicationDocumentsDirectory();
        String tempPath = tempDir.path;
        CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
        dio.interceptors.add(CookieManager(sj));
        String url  = WebRequestConstants.getWPBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.CUSTOM_PRODUCT+parameter;
        var response = await dio.get(url, options: new Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}));
        if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {

          list = (response.data as List).map((i) => ProductModel.fromJson(i)).toList();
         return list;
        } else {
          return null;
        }
    }on DioError catch(e){
      return null;
    }
  }

  Future<List<ProductModel>> getProductByRelatedIds({List<int> productIDs}) async {
    printLog("ghjghjghjgh", productIDs);
    try{
      String parameter = "";
      if(productIDs!=null){
        parameter+="?include=${productIDs.join(",").toString()}";
      }
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl +
          WebRequestConstants.getDomainUrl +
          WebRequestConstants.PRODUCT_BY_ID+parameter;
      var response = await dio.get(url, options: new Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        List<ProductModel> list  = (response.data as List).map((i) => ProductModel.fromJson(i)).toList();
        return list;
      } else {
        return null;
      }
    }on DioError catch(e){
      return null;
    }
  }

  Future<PriceRangeModel> getPriceRange() async {
    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl +
          WebRequestConstants.getDomainUrl +
          WebRequestConstants.PRICE_RANGE;
      var response = await dio.get(url, options: new Options(headers: headers));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        PriceRangeModel model = PriceRangeModel.fromJson(response.data);
        return model;
      } else {

      return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<ProductModel> getProductById(String id) async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      var params = new FormData.fromMap(
          { 'id': id,});
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.PRODUCT_BY_ID;
      var response = await dio.post(url, options: new Options(headers: headers), data: params);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        ProductModel model = ProductModel.fromJson(response.data);
        return model;
      } else {

        return null;
      }} on DioError catch(e){

      return null;
    }
    }

  Future<WebResponseModel> getAddToCart(int id, String quantity) async {
  try{
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
    dio.interceptors.add(CookieManager(sj));
    var params = { 'id': id,
          'quantity':quantity};
    String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.ADD_CART;
    printLog("dtdtdtdt", url);
    printLog("hgjhgjghvg", params);
    var response = await dio.post(url, options: new Options(headers: headers), data: params);
    if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {

      WebResponseModel model = WebResponseModel.fromJson(response.data);
      return model;
    } else {

      return null;
    }} on DioError catch(e){

    return null;
  }
  }

  Future<WebResponseModel> getAddToCartVariationProduct({VariableProduct variableProduct}) async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));

      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.ADD_CART;
      var response = await dio.post(url, options: new Options(headers: headers), data: variableProduct.toJson());
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        WebResponseModel model = WebResponseModel.fromJson(response.data);
        return model;
      } else {

        return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<CartModel> getUpdateToCart(String cartItemKey, int quantity) async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String params = "";
      if(cartItemKey!=null){
        params+="?cart_item_key=$cartItemKey";
      }
      if(quantity!=null){
        params+="&quantity=$quantity";
      }
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.CART_UPDATE +params;
      var response = await dio.post(url, options: new Options(headers: headers));

      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        CartModel model =CartModel.fromJson(response.data);
        return model;
      } else {

        return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<CartModel> getRemoveToCart(String cartItemKey) async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      var params = new FormData.fromMap(
          { WebRequestConstants.CART_ITEM_KEY: cartItemKey,
          });
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.CART_REMOVE;
      var response = await dio.post(url, options: new Options(headers: headers), data: params);

      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        CartModel model =CartModel.fromJson(response.data);
        return model;
      } else {
        return null;
      }} on DioError catch(e){
      return null;
    }
  }

  Future<bool> getClearToCart() async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));https://gist.github.com/mayur19/26417eeba02f5e5ced8138f4d9040d6a
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.CART_CLEAR;
      var response = await dio.get(url, options: new Options(headers: headers));

      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
          if(response.data==1){
            return true;
          }
        return false;
      } else {
        return false;
      }} on DioError catch(e){

      return false;
    }
  }

  Future<int> getCartItemCount() async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.CART_ITEM_COUNT;
      var response = await dio.get(url, options: new Options(headers: headers));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        int itemCount = response.data;
        return itemCount;
      } else {

        return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<List<Coupons>> getCoupons() async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.COUPON;
      var response = await dio.get(url, options: new Options(headers: {
        HttpHeaders.authorizationHeader: BaseAuth
      }));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        Iterable l = response.data;
        List<Coupons> Cupons = List<Coupons>.from(l.map((model)=> Coupons.fromJson(model)));
        return Cupons;
      } else {
        return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<ReviewOrder> getReviewOrder() async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.REVIEW_ORDER;
      var response = await dio.get(url, options: new Options(headers: {
        HttpHeaders.authorizationHeader: BaseAuth
      }));
      printLog("dtdtdtdtdt", response);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        ReviewOrder order = ReviewOrder.fromJson(response.data);

        return order;
      } else {

        return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<CartModel> getApplyCoupons({String coupon_code}) async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      var params = new FormData.fromMap(
          { 'code': coupon_code,
          });
      String url  = "${WebRequestConstants.getWPBaseUrl}${WebRequestConstants.getDomainUrl}${WebRequestConstants.CART_COUPON}?coupon_code=$coupon_code";

      var response = await dio.get(url, options: new Options(headers: {
        HttpHeaders.authorizationHeader: BaseAuth
      }));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        CartModel model = CartModel.fromJson(response.data);
        return model;
      } else {
        return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<CartModel> getRemoveCoupons({String coupon_code}) async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      var params = new FormData.fromMap(
          { 'code': coupon_code,
          });
      String url  = "${WebRequestConstants.getWPBaseUrl}${WebRequestConstants.getDomainUrl}${WebRequestConstants.REMOVE_COUPON}?coupon_code=$coupon_code";

      var response = await dio.get(url, options: new Options(headers: {
        HttpHeaders.authorizationHeader: BaseAuth
      }));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        CartModel model = CartModel.fromJson(response.data);

        return model;
      } else {

        return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<CartModel> getCart() async {
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.CART;
      var response = await dio.get(url, options: new Options(headers: headers));
      printLog("dtdtdtdt", response);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {

        CartModel model =CartModel.fromJson(response.data);

        return model;
      } else {
        return null;
      }} on DioError catch(e){
      return null;
    }
  }

  Future<OrderModel> getNewOrder({int userId, String paymentMethod}) async{

    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      var params = {
        'user_id': userId,
        'payment_method': paymentMethod
        };
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.NEW_ORDER;
      var response = await dio.post(url,queryParameters: params);

      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {

        OrderModel model =OrderModel.fromJson(response.data);
        return model;
      } else {

        return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<bool> getUpdateOrder({String order_id, String status, String transaction_id}) async{
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      var params = { 'order_id': "$order_id",
            'status': "$status",
            'transaction_id':"$transaction_id"
          };
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.UPDATE_ORDER;
      var response = await dio.post(url, options: new Options(headers: headers),data: params);

      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        OrderSummary model =OrderSummary.fromJson(response.data);
        if(model.status==1){
          return true;
        }
        return false;
      } else {
        return false;
      }} on DioError catch(e){

      return false;
    }
  }

  Future<OrderHistory> getOrders({String id, int offset, int limit}) async{
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));

      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl +"$id/"+ WebRequestConstants.ORDERS;
      var response = await dio.get(url, options: new Options(headers: { HttpHeaders.authorizationHeader: BaseAuth}));

      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        OrderHistory model = OrderHistory.fromJson(response.data);
        return model;
      } else {
        return null;
      }} on DioError catch(e){
      return null;
    }
  }

  Future<List<CityModel>> getCountry() async{
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getPlaceUrl + WebRequestConstants.COUNTRIES;
      var response = await dio.get(url, options: new Options(headers: headers));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        Iterable l = response.data;
        List<CityModel> model = List<CityModel>.from(l.map((model)=> CityModel.fromJson(model)));
        return model;
      } else {
        return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<List<CityModel>> getStates({String countryCode}) async{
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getPlaceUrl + WebRequestConstants.STATES+"?filter=$countryCode&type=code";
      var response = await dio.get(url, options: new Options(headers: headers));

      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        Iterable l = response.data;
        List<CityModel> model = List<CityModel>.from(l.map((model)=> CityModel.fromJson(model)));

        return model;
      } else {

        return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<CityModel> getCity({String state}) async{
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      var params = new FormData.fromMap(
          { WebRequestConstants.PLACE_FILTER: state,
          });
      String url  = WebRequestConstants.getPlaceUrl + WebRequestConstants.CITIES;
      var response = await dio.post(url, options: new Options(headers: headers), data: params);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {

        CityModel model =CityModel.fromJson(response.data);

        return model;
      } else {

        return null;
      }} on DioError catch(e){
      return null;
    }
  }

  Future<bool> updateBilling({String user_id, Billing shipping}) async{
    try{
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      var params = { "user_id": "$user_id","billing_first_name":"${shipping.firstName}","billing_last_name":"${shipping.lastName}",
        "billing_company":"${shipping.company}", "billing_email":"${shipping.email}", "billing_phone":"${shipping.phone}", "billing_address_1":"${shipping.address1}",
        "billing_address_2":"${shipping.address2}", "billing_city":"${shipping.city}", "billing_state":"${shipping.state}", "billing_postcode":"${shipping.postcode}",
        "billing_country":"${shipping.country}", "checkbox":true};
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl+WebRequestConstants.UPDATE_BILLING;
      printLog("fgfghfghfgfg", url);
      printLog("ghjghghghj", params);
      var response = await dio.post(url, options: new Options(headers: {
        HttpHeaders.authorizationHeader: BaseAuth
      }), data: json.encode(params));
      printLog("ghjghghghjhjhj", response);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        printLog("ghjghghghj", response);
        // UserModel model= UserModel.fromJson(response.data);
        return true;
      } else {
        return false;
      }} on DioError catch(e){
      printLog("vgfhfghfgfgf", e.message);
      return false;
    }
  }

  Future<List<ColorSizeModel>> getColorSizeList({String id}) async {
    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = "${WebRequestConstants.getWPBaseUrl}${WebRequestConstants.getDomainUrl}${WebRequestConstants.CUSTOM_ATTRIBUTES}"
          "?${WebRequestConstants.SHOW_ALL}=$id";
      printLog("dtdtdtdtt", url);
      var response = await dio.get(url, options: new Options(headers: headers));
      printLog("fyftyffyf", response);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        Iterable l = response.data;
        List<ColorSizeModel> model = List<ColorSizeModel>.from(l.map((model)=> ColorSizeModel.fromJson(model)));
        printLog("fyftyffyf", model.length);
        return model;
      } else {

        return null;
      }} on DioError catch(e){

      return null;
    }
  }

  Future<List<PaymentGateway>> getPaymentGateway() async {
    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl +
          WebRequestConstants.getDomainUrl +
          WebRequestConstants.PAYMENT_GATEWAY;
      var response = await dio.get(url, options: new Options(headers: headers));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        Iterable l = response.data;
        List<PaymentGateway> model = List<PaymentGateway>.from(l.map((model)=> PaymentGateway.fromJson(model)));
        return model;
      } else {
        return null;
      }} on DioError catch(e){
       return null;
    }
  }

  Future<HomeLayout> getHomeLayout()async{
    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl +
          WebRequestConstants.getDomainUrl +
          WebRequestConstants.LAYOUT;
      var response = await dio.get(url, options: new Options(headers: headers));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        printLog("homelayout", response.data);
        HomeLayout model =HomeLayout.fromJson(response.data);
        printLog("fhghhghghg", model.toJson());
        return model;
      } else {
        return null;
      }} on DioError catch(e){
      return null;
    }
  }

  Future<String> getAppPageById({String page_id})async{
    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = "${WebRequestConstants.getWPBaseUrl}${WebRequestConstants.getDomainUrl}"
          "${WebRequestConstants.GET_APP_PAGE_BY_ID}?${WebRequestConstants.PAGE_ID}=$page_id";
      var response = await dio.get(url, options: new Options(headers: headers));
      printLog("getAppPageById", response.data);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        if(response.data['status']=="1"){
          printLog("getAppPageById", response.data['product_id']);
        }
        return null;
      } else {
        return null;
      }} on DioError catch(e){
      return null;
    }
  }

  Future<AppSetting> getAppSetting()async{
    try {
      printLog("bhchddjdjdj", "msg");
      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.APP_SETTING;
      printLog("getAppSetting", url);
      var response = await dio.get(url, options: new Options(headers: headers));
      printLog("getAppSetting", url);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        AppSetting appSetting = AppSetting.fromJson(response.data);
        return appSetting;
      } else {
        return null;
      }} on DioError catch(e){
      printLog("getAppSetting", e.message);
      return null;
    }
  }
}
