import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:wooapp/rest/woocommerce.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:wooapp/widgets/loading.dart';

// part 'WebApiServices.chopper.dart';
class WebApiServices {
  var CookiesJar = CookieJar();
  var dio = Dio();
  Response response;
  Map<String, String> cookies = {};
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json"
  };

  Future<Response> userLogin(String email, String password) async {
    dio.interceptors.add(CookieManager(CookiesJar));
    response = await dio.post(
        WebRequestConstants.getBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.LOGIN,
        data: {"email": email, "password": password},
        options: new Options(headers: headers));
    return response;
  }

  Future<Response> userRegister(
      String name, String email, String password) async {
    var params = new FormData.fromMap(
        {'fname': name, 'email': email, 'password': password});
    printLog(
        'userRegister',
        WebRequestConstants.getWPBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.REGISTER +
            " name:- $name,"
                "email:- $email, password:-$password");
    response = await dio.post(
      WebRequestConstants.getWPBaseUrl +
          WebRequestConstants.getDomainUrl +
          WebRequestConstants.REGISTER,
      options: new Options(headers: headers),
      data: params,
    );
    printLog("userRegister", response);
    return response;
  }

  Future<http.Response> forgetPassword(String email) {
    return http.post(
        WebRequestConstants.getBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.FORGOT_PASSWORD,
        body: {
          'email': email,
        });
  }

  Future<http.Response> changePassword(String user_id) {
    return http.post(
        WebRequestConstants.getBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.CHANGE_PASSWORD,
        body: {
          'user_id': user_id,
        });
  }

  Future<http.Response> socialLogin(String mode, String name, String email,
      String firstName, String lastName) {
    return http.post(
        WebRequestConstants.getBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.SOCIAL_LOGIN,
        body: {
          'mode': mode,
          'name': name,
          'email': email,
          'first_name': firstName,
          'last_name': lastName
        });
  }

  Future<http.Response> getCategories() {
    printLog(
        "imageURLL",
        WebRequestConstants.getBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.ALL_CATEGORIES);
    return http.get(WebRequestConstants.getBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.ALL_CATEGORIES);
  }

  Future<http.Response> getProducts(
      String sort, String page, String per_page) async {
    printLog(
        'loadProducts',
        WebRequestConstants.getWPBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.CUSTOM_PRODUCT +
            '?' +
            WebRequestConstants.SORT +
            '=' +
            sort +
            '&' +
            WebRequestConstants.PAGE +
            '=' +
            page +
            '&' +
            WebRequestConstants.PER_PAGE +
            '=' +
            per_page);

    var response = await http.get(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.CUSTOM_PRODUCT +
        '?' +
        WebRequestConstants.SORT +
        '=' +
        sort +
        '&' +
        WebRequestConstants.PAGE +
        '=' +
        page +
        '&' +
        WebRequestConstants.PER_PAGE +
        '=' +
        per_page);
    printLog('responseProducts', response.body.toString());

    return response;
  }

  Future<http.Response> getPriceRange() async {
    var response = await http.get(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.PRICE_RANGE);
    return response;
  }

  Future<http.Response> getProductByCategory(
      String sort, String page, String per_page, String category) async {
    var response = await http.post(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.CUSTOM_PRODUCT +
        '?' +
        WebRequestConstants.SORT +
        '=' +
        sort +
        '&' +
        WebRequestConstants.PAGE +
        '=' +
        page +
        '&' +
        WebRequestConstants.PER_PAGE +
        '=' +
        per_page +
        '&' +
        WebRequestConstants.CATEGORY +
        '=' +
        category);
    return response;
  }

  Future<http.Response> getProductByPrice(String sort, String page,
      String per_page, String min_price, String max_price) async {
    var response = await http.post(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.CUSTOM_PRODUCT +
        '?' +
        WebRequestConstants.SORT +
        '=' +
        sort +
        '&' +
        WebRequestConstants.PAGE +
        '=' +
        page +
        '&' +
        WebRequestConstants.PER_PAGE +
        '=' +
        per_page +
        '&' +
        WebRequestConstants.MIN_PRICE +
        '=' +
        min_price +
        '&' +
        WebRequestConstants.MAX_PRICE +
        '=' +
        max_price);
    return response;
  }

  Future<http.Response> getProductByBrand(
      String sort, String page, String per_page, String brand) async {
    var response = await http.post(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.CUSTOM_PRODUCT +
        '?' +
        WebRequestConstants.SORT +
        '=' +
        sort +
        '&' +
        WebRequestConstants.PAGE +
        '=' +
        page +
        '&' +
        WebRequestConstants.PER_PAGE +
        '=' +
        per_page +
        '&' +
        WebRequestConstants.BRAND +
        '=' +
        brand);
    return response;
  }

  Future<http.Response> getProductByFeatured(
      String sort, String page, String per_page, String featured) async {
    var response = await http.post(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.CUSTOM_PRODUCT +
        '?' +
        WebRequestConstants.SORT +
        '=' +
        sort +
        '&' +
        WebRequestConstants.PAGE +
        '=' +
        page +
        '&' +
        WebRequestConstants.PER_PAGE +
        '=' +
        per_page +
        '&' +
        WebRequestConstants.FEATURED +
        '=' +
        featured);
    return response;
  }

  Future<http.Response> getProductByOnSale(
      String sort, String page, String per_page, String on_sale) async {
    var response = await http.post(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.CUSTOM_PRODUCT +
        '?' +
        WebRequestConstants.SORT +
        '=' +
        sort +
        '&' +
        WebRequestConstants.PAGE +
        '=' +
        page +
        '&' +
        WebRequestConstants.PER_PAGE +
        '=' +
        per_page +
        '&' +
        WebRequestConstants.ON_SALE +
        '=' +
        on_sale);
    return response;
  }

  Future<http.Response> getProductBySearch(
      String sort, String page, String per_page, String search) async {
    var response = await http.post(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.CUSTOM_PRODUCT +
        '?' +
        WebRequestConstants.SORT +
        '=' +
        sort +
        '&' +
        WebRequestConstants.PAGE +
        '=' +
        page +
        '&' +
        WebRequestConstants.PER_PAGE +
        '=' +
        per_page +
        '&' +
        WebRequestConstants.ON_SALE +
        '=' +
        search);
    return response;
  }

  Future<http.Response> getProductById(String id) async {
    var response = await http.post(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.PRODUCT_BY_ID +
        '?' +
        WebRequestConstants.PRODUCT_ID +
        '=' +
        id);
    return response;
  }

  Future<Response> getAddToCart(String id, String quantity) async {
    dio.interceptors.add(CookieManager(CookiesJar));
    Response response = await dio.post(
        WebRequestConstants.getWPBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.ADD_CART,
        data: {"id": id, "quantity": quantity});

    printLog("getAddToCart", response);
    return response;
  }

  Future<http.Response> getAddToCartVariationProduct(
      String id, String quantity, String variation, String variation_id) async {
    printLog(
        "getAddToCart",
        WebRequestConstants.getWPBaseUrl +
            WebRequestConstants.getDomainUrl +
            WebRequestConstants.ADD_CART +
            '?' +
            WebRequestConstants.PRODUCT_ID +
            '=' +
            id +
            '&' +
            WebRequestConstants.QUANTITY +
            '=' +
            quantity +
            '&' +
            WebRequestConstants.VARIATION +
            '=' +
            variation +
            '&' +
            WebRequestConstants.VARIATION_ID +
            '=' +
            variation_id);
    var response = await http.post(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.ADD_CART +
        '?' +
        WebRequestConstants.PRODUCT_ID +
        '=' +
        id +
        '&' +
        WebRequestConstants.QUANTITY +
        '=' +
        quantity +
        '&' +
        WebRequestConstants.VARIATION +
        '=' +
        variation +
        '&' +
        WebRequestConstants.VARIATION_ID +
        '=' +
        variation_id);
    return response;
  }

  Future<http.Response> getUpdateToCart(
    String cartItemKey,
    String quantity,
  ) async {
    var response = await http.post(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.CART_UPDATE +
        '?' +
        WebRequestConstants.CART_ITEM_KEY +
        '=' +
        cartItemKey +
        '&' +
        WebRequestConstants.QUANTITY +
        '=' +
        quantity);
    return response;
  }

  Future<http.Response> getRemoveToCart(String cartItemKey) async {
    var response = await http.post(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.CART_REMOVE +
        '?' +
        WebRequestConstants.CART_ITEM_KEY +
        '=' +
        cartItemKey);
    return response;
  }

  Future<http.Response> getClearToCart() async {
    var response = await http.get(WebRequestConstants.getWPBaseUrl +
        WebRequestConstants.getDomainUrl +
        WebRequestConstants.CART_REMOVE);
    return response;
  }

  Future<Response> getCart() async {
    dio.interceptors.add(CookieManager(CookiesJar));
    await printLog("CookiesJar", CookiesJar.toString());
    Response response = await dio.get(
      WebRequestConstants.getWPBaseUrl +
          WebRequestConstants.getDomainUrl +
          WebRequestConstants.CART,
    );
    printLog("getAddToCart", response);
    return response;
  }

  void updateCookie(http.Response response) {
    String allSetCookie = response.headers['set-cookie'];
    printLog("allCookies", allSetCookie);
    if (allSetCookie != null) {
      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }
      printLog("allSetCookie", allSetCookie);
      headers['cookie'] = _generateCookieHeader();
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.length > 0) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];
        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires') return;
        this.cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.length > 0) cookie += ";";
      cookie += key + "=" + cookies[key];
    }
    printLog("_generateCookieHeader", cookie);
    return cookie;
  }
}
