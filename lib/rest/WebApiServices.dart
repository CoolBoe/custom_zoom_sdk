import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/rest/WebRequestConstants.dart' ;
import 'package:wooapp/rest/woocommerce.dart';
import 'package:wooapp/widgets/loading.dart';

// part 'WebApiServices.chopper.dart';
class WebApiServices {

  static const String BaseAuthId = "ck_182712e047bc83b22974476388360fca763c0005";
  static const String BaseAuthPass = "cs_3351fba7577bb78534600af478007e73f8babd4e";
  String BaseAuth =  'Basic ' + base64Encode(utf8.encode('$BaseAuthId:$BaseAuthPass'));

  Future<http.Response> userLogin(String email, String password){
    return http.post(WebRequestConstants.getBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.LOGIN, body:  {
      'email': email,
      'password':password
    });
  }
  Future<http.Response> userRegister(String name, String email, String password){
    return http.post(WebRequestConstants.getBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.REGISTER, body:  {
      'fname': name,
      'email': email,
      'password':password
    });
  }
  Future<http.Response> forgetPassword(String email){
    return http.post(WebRequestConstants.getBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.FORGOT_PASSWORD, body:  {
      'email': email,
    });
  }
  Future<http.Response> changePassword(String user_id){
    return http.post(WebRequestConstants.getBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CHANGE_PASSWORD, body:  {
      'user_id': user_id,
    });
  }
  Future<http.Response> socialLogin(String mode, String name,String email, String firstName, String lastName ){
    return http.post(WebRequestConstants.getBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.SOCIAL_LOGIN, body:  {
      'mode': mode,
      'name':name,
      'email':email,
      'first_name':firstName,
      'last_name':lastName
    });
  }
  Future<http.Response> getCategories() {
    printLog("imageURLL", WebRequestConstants.getBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.ALL_CATEGORIES);
    return http.get(WebRequestConstants.getBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.ALL_CATEGORIES);
  }
  Future<http.Response> getProducts(String sort, String page, String per_page) async {
    printLog('loadProducts', WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CUSTOM_PRODUCT+'?'+WebRequestConstants.SORT
        +'='+sort+'&'+WebRequestConstants.PAGE+'='+page+'&'+WebRequestConstants.PER_PAGE+'='+per_page);

    var response=  await http.get(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CUSTOM_PRODUCT+'?'+WebRequestConstants.SORT
        +'='+sort+'&'+WebRequestConstants.PAGE+'='+page+'&'+WebRequestConstants.PER_PAGE+'='+per_page
    );
    printLog('responseProducts',response.body.toString());

    return response;
  }
  Future<http.Response> getPriceRange() async {
    var response=  await http.get(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.PRICE_RANGE);
    return response;
  }

  Future<http.Response> getProductByCategory(String sort, String page, String per_page, String category) async {
       var response=  await http.post(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CUSTOM_PRODUCT+'?'+WebRequestConstants.SORT
           +'='+sort+'&'+WebRequestConstants.PAGE+'='+page+'&'+WebRequestConstants.PER_PAGE+'='+per_page+'&'+WebRequestConstants.CATEGORY+'='+category
    );
    return response;
  }

  Future<http.Response> getProductByPrice(String sort, String page, String per_page, String min_price, String max_price) async {
    var response=  await http.post(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CUSTOM_PRODUCT+'?'+WebRequestConstants.SORT
        +'='+sort+'&'+WebRequestConstants.PAGE+'='+page+'&'+WebRequestConstants.PER_PAGE+'='+per_page+'&'+WebRequestConstants.MIN_PRICE+'='+min_price+'&'+
        WebRequestConstants.MAX_PRICE+'='+max_price
    );
    return response;
  }
  Future<http.Response> getProductByBrand(String sort, String page, String per_page, String brand) async {
    var response=  await http.post(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CUSTOM_PRODUCT+'?'+WebRequestConstants.SORT
        +'='+sort+'&'+WebRequestConstants.PAGE+'='+page+'&'+WebRequestConstants.PER_PAGE+'='+per_page+'&'+WebRequestConstants.BRAND+'='+brand
    );
    return response;
  }
  Future<http.Response> getProductByFeatured(String sort, String page, String per_page, String featured) async {
    var response=  await http.post(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CUSTOM_PRODUCT+'?'+WebRequestConstants.SORT
        +'='+sort+'&'+WebRequestConstants.PAGE+'='+page+'&'+WebRequestConstants.PER_PAGE+'='+per_page+'&'+WebRequestConstants.FEATURED+'='+featured
    );
    return response;
  }
  Future<http.Response> getProductByOnSale(String sort, String page, String per_page, String on_sale) async {
    var response=  await http.post(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CUSTOM_PRODUCT+'?'+WebRequestConstants.SORT
        +'='+sort+'&'+WebRequestConstants.PAGE+'='+page+'&'+WebRequestConstants.PER_PAGE+'='+per_page+'&'+WebRequestConstants.ON_SALE+'='+on_sale
    );
    return response;
  }
  Future<http.Response> getProductBySearch(String sort, String page, String per_page, String search) async {
    var response=  await http.post(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CUSTOM_PRODUCT+'?'+WebRequestConstants.SORT
        +'='+sort+'&'+WebRequestConstants.PAGE+'='+page+'&'+WebRequestConstants.PER_PAGE+'='+per_page+'&'+WebRequestConstants.ON_SALE+'='+search
    );
    return response;
  }
  Future<http.Response> getProductById(String id) async {
    var response=  await http.post(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.PRODUCT_BY_ID+'?'+WebRequestConstants.PRODUCT_ID+'='+id
    );
    return response;
  }

  Future<http.Response> getAddToCart(String id, String quantity) async {
    // printLog("getAddToCart", WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.ADD_CART+'?'+WebRequestConstants.PRODUCT_ID
    //     +'='+id+'&'+WebRequestConstants.QUANTITY+'='+quantity);
    var response=  await http.post(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.ADD_CART,
      body: jsonEncode(<String, String>{
        'id': id,
        'quantity':quantity
      }),
    );
    return response;
  }
  Future<http.Response> getAddToCartVariationProduct(String id, String quantity, String variation, String variation_id) async {
    printLog("getAddToCart", WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.ADD_CART+'?'+WebRequestConstants.PRODUCT_ID
        +'='+id+'&'+WebRequestConstants.QUANTITY+'='+quantity+'&'+WebRequestConstants.VARIATION+'='+variation+'&'+WebRequestConstants.VARIATION_ID+'='+variation_id);
    var response=  await http.post(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.ADD_CART+'?'+WebRequestConstants.PRODUCT_ID
        +'='+id+'&'+WebRequestConstants.QUANTITY+'='+quantity+'&'+WebRequestConstants.VARIATION+'='+variation+'&'+WebRequestConstants.VARIATION_ID+'='+variation_id
    );
    return response;
  }
  Future<http.Response> getUpdateToCart(String cartItemKey,String quantity, ) async {
    var response=  await http.post(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CART_UPDATE+'?'+WebRequestConstants.CART_ITEM_KEY
        +'='+cartItemKey+'&'+WebRequestConstants.QUANTITY+'='+quantity
    );
    return response;
  }
  Future<http.Response> getRemoveToCart(String cartItemKey ) async {
    var response=  await http.post(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CART_REMOVE+'?'+WebRequestConstants.CART_ITEM_KEY
        +'='+cartItemKey
    );
    return response;
  }
  Future<http.Response> getClearToCart() async {
    var response=  await http.get(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CART_REMOVE
    );
    return response;
  }
}
