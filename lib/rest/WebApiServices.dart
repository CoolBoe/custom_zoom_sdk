import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/app.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/models/coupons.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:wooapp/rest/woocommerce.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:wooapp/widgets/loading.dart';

// part 'WebApiServices.chopper.dart';
class WebApiServices {
  var dio = Dio();
  Response response;
  String BaseAuth =
      'Basic ' + base64Encode(utf8.encode('${WebRequestConstants.BaseAuthId}:${WebRequestConstants.BaseAuthPass}'));
  Map<String, String> cookies = {};
  Map<String, String> headers =<String, String> {
    HttpHeaders.contentTypeHeader: "application/json",
  };
  Future<bool> userLogin(String email, String password) async {
    try{
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getBaseUrl +
          WebRequestConstants.getDomainUrl +
          WebRequestConstants.LOGIN;
      var response = await dio.get(url, options: new Options(headers: headers));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        Map<String, dynamic> result = json.decode(response.data);
        if (result['code'] == '1') return true;
         else {
          return false;
        }
      } else {
        printLog("API login Errorr Massage", response.data);
        return false;
      }
    }on DioError catch(e){
      printLog("API login Errorr Massage", e.response);
      return false;
    }
  }

  Future<bool> userRegister(String name, String email, String password) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      CookieJar cookies = new PersistCookieJar(
          dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(cookies));
      var params = new FormData.fromMap(
          {'fname': name, 'email': email, 'password': password});
      response = await dio.post(
        WebRequestConstants.getWPBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.REGISTER,
        options: new Options(headers: headers),
        data: params,
      );
    } on DioError catch(e){
      printLog("registerError=>", e.response);
      return false;
    }

  }

  Future<bool> forgetPassword(String email) async{
    try{
      Directory tempDir = await getTemporaryDirectory();
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
        printLog("API forgetPass Errorr Massage", response.data);
        return false;
      }
    }on DioError catch(e){
      printLog("forgetPassError=>", e.response);
      return false;
    }
  }

  Future<bool> changePassword(String user_id) async{
    try{
      Directory tempDir = await getTemporaryDirectory();
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
        printLog("API changePass Errorr Massage", response.data);
        return false;
      }
    }on DioError catch(e){
      printLog("changePassError=>", e.response);
      return false;
    }
  }

  Future<bool> socialLogin(String mode, String name, String email, String firstName, String lastName) async{
    try{
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
    dio.interceptors.add(CookieManager(sj));
    String url  = WebRequestConstants.getBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.SOCIAL_LOGIN;
    var params = new FormData.fromMap(
        { 'mode': mode,
          'name': name,
          'email': email,
          'first_name': firstName,
          'last_name': lastName});
    var response = await dio.post(url, options: new Options(headers: headers), data: params);
    if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
      Map<String, dynamic> result = json.decode(response.data);
      if (result['code'] == '1') {
        return true;
      } else {
        return false;
      }
    } else {
      printLog("API social Errorr Massage", response.data);
      return false;
    }
    }on DioError catch(e){
    printLog("socialError=>", e.response);
    return false;
  }
  }

  Future<List<CategoryModel>> getCategories()async {
     List<CategoryModel> list =[];
     try{
       Directory tempDir = await getTemporaryDirectory();
       String tempPath = tempDir.path;
       CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
       dio.interceptors.add(CookieManager(sj));
       String url  = WebRequestConstants.getBaseUrl +
           WebRequestConstants.getDomainUrl +
           WebRequestConstants.ALL_CATEGORIES;
       var response = await dio.get(url, options: new Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}));
       if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
         printLog("API getCategory =>", response.toString());
         list = (response.data as List).map((i) => CategoryModel.fromJson(i)).toList();
         return list;
       } else {
         printLog("API getProduct Errorr Massage", response.data);
       }
     }on DioError catch(e){
       printLog("getCategoryError=>", e.response);
     }
  }

  Future<List<ProductModel>> getProducts(
      {String sort, String page, String per_page, String category_id, String str_search, String brand, String max_price, String min_price, String on_sale, bool featured, List<int> productIDs}) async {
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
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
        dio.interceptors.add(CookieManager(sj));
        String url  = WebRequestConstants.getWPBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.CUSTOM_PRODUCT+parameter;
        printLog("API getProduct200 =>", url);
        var response = await dio.get(url, options: new Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}));
        if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
          printLog("API getProduct200 =>", response.toString());
         list = (response.data as List).map((i) => ProductModel.fromJson(i)).toList();
         return list;
        } else {
          printLog("API getProduct Errorr Massage", response.data);
        }
    }on DioError catch(e){
      printLog('getProduct', e.response);
    }
  }

  Future<PriceRangeModel> getPriceRange() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
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
        printLog("API getPriceRange Errorr Massage", response.data);
      return null;
      }} on DioError catch(e){
      printLog("getPriceRange", e.response);
      return null;
    }
  }

  Future<ProductModel> getProductById(String id) async {
    try{
      Directory tempDir = await getTemporaryDirectory();
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
        printLog("API getProductById Errorr Massage", response.data);
        return null;
      }} on DioError catch(e){
      printLog("getProductById", e.response);
      return null;
    }
    }

  Future<WebResponseModel> getAddToCart(int id, String quantity) async {
  try{
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
    dio.interceptors.add(CookieManager(sj));
    var params = { 'id': id,
          'quantity':quantity};
    String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.ADD_CART;
  await  printLog("getAddToCarturl", "$url====>$params");
    var response = await dio.post(url, options: new Options(headers: headers), data: params);
    if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
      printLog("getAddToCart", response);
      WebResponseModel model = WebResponseModel.fromJson(response.data);
      return model;
    } else {
      printLog("API getAddToCart Errorr Massage", response.data);
      return null;
    }} on DioError catch(e){
    printLog("getAddToCart", e.response);
    return null;
  }
  }

  Future<WebResponseModel> getAddToCartVariationProduct(String id, String quantity, String variation, String variation_id) async {
    try{
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      var params = new FormData.fromMap(
          { 'id': id,
            'quantity':quantity,
            WebRequestConstants.VARIATION: variation,
            WebRequestConstants.VARIATION_ID:variation_id});
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.ADD_CART;
      var response = await dio.post(url, options: new Options(headers: headers), data: params);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        WebResponseModel model = WebResponseModel.fromJson(response.data);
        return model;
      } else {
        printLog("API CartVariation Errorr Massage", response.data);
        return null;
      }} on DioError catch(e){
      printLog("CartVariation", e.response);
      return null;
    }
  }

  Future<CartModel> getUpdateToCart(String cartItemKey, int quantity) async {
    try{
      Directory tempDir = await getTemporaryDirectory();
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
      printLog("API getUpdateToCart Massage", response.data);
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        CartModel model =CartModel.fromJson(response.data);
        return model;
      } else {
        printLog("API getUpdateToCart Errorr Massage", response.data);
        return null;
      }} on DioError catch(e){
      printLog("getUpdateToCart", e.response);
      return null;
    }
  }

  Future<CartModel> getRemoveToCart(String cartItemKey) async {
    try{
      Directory tempDir = await getTemporaryDirectory();
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
        printLog("API getRemoveToCart Errorr Massage", response.data);
        return null;
      }} on DioError catch(e){
      printLog("getRemoveToCart", e.response);
      return null;
    }
  }

  Future<WebResponseModel> getClearToCart() async {
    try{
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.CART_CLEAR;
      var response = await dio.get(url, options: new Options(headers: headers));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        WebResponseModel model = WebResponseModel.fromJson(response.data);
        return model;
      } else {
        printLog("API getClearToCart Errorr Massage", response.data);
        return null;
      }} on DioError catch(e){
      printLog("getClearToCart", e.response);
      return null;
    }
  }

  Future<int> getCartItemCount() async {
    try{
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.CART_ITEM_COUNT;
      var response = await dio.get(url, options: new Options(headers: headers));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {
        int itemCount = response.data;
        return itemCount;
      } else {
        printLog("API getCartItemCount Errorr Massage", response.data);
        return null;
      }} on DioError catch(e){
      printLog("getCartItemCount", e.response);
      return null;
    }
  }

  Future<List<Coupons>> getCoupons() async {
    try{
      Directory tempDir = await getTemporaryDirectory();
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
       printLog("coupons", Cupons);
       return Cupons;

      } else {
        printLog("API getCoupons Errorr Massage", response.data);
        return null;
      }} on DioError catch(e){
      printLog("getCoupons", e.response);
      return null;
    }
  }

  Future<CartModel> getCart() async {
    try{
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      CookieJar sj = new PersistCookieJar(dir: tempPath, persistSession: true);
      dio.interceptors.add(CookieManager(sj));
      String url  = WebRequestConstants.getWPBaseUrl + WebRequestConstants.getDomainUrl + WebRequestConstants.CART;
      var response = await dio.get(url, options: new Options(headers: headers));
      if (response.statusCode == HTTP_CODE_200||response.statusCode == HTTP_CODE_201) {

        CartModel model =CartModel.fromJson(response.data);
        printLog("API getCart Data", model.cartData[0].quantity);
        return model;
      } else {
        printLog("API getCart Errorr Massage", response.data);
        return null;
      }} on DioError catch(e){
      printLog("getCart", e.response);
      return null;
    }
  }
}
