import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:wooapp/rest/woocommerce.dart';
import 'package:wooapp/widgets/loading.dart';

// part 'WebApiServices.chopper.dart';
class WebApiServices {
  static const String BaseAuthId = "ck_182712e047bc83b22974476388360fca763c0005";
  static const String BaseAuthPass = "cs_3351fba7577bb78534600af478007e73f8babd4e";
  String BaseAuth =  'Basic ' + base64Encode(utf8.encode('$BaseAuthId:$BaseAuthPass'));
  // @Post(path: 'login')
  // Future<Response>userLogin(
  //       @Path('email') String email,
  //       @Path('password') String password,
  //       @Path('mobile') String mobile,
  //       @Path('country_code') String country_code,
  //     );
  //
  // @Get(path: 'logout')
  // Future<Response> userLogout(
  // Future<Response> getPost(@Path('user_id') int user_id)
  //     );
  //
  // @Post(path: 'register')
  // Future<Response>userRegister(
  //     @Body()Map<String, dynamic>body,
  //     );
  //
  // @Post(path: 'forget-password')
  // Future<Response> forgotPassword(@Path('user_id') int user_id);
  //
  // @Post(path: 'change-password')
  // Future<Response>  changePassword(@Path('user_id') int user_id);
  //
  // static WebApiServices create(){
  //   final client =ChopperClient(
  //     baseUrl: WebRequestConstants.getBaseUrl,
  //         services: [
  //           _$WebApiServices();
  //       ],
  //   converter: JsonConverter(),
  //   );
  //   return _$WebApiServices(client);
  // }
  //
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
    return http.get(WebRequestConstants.getBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.ALL_CATEGORIES);
  }
  Future<http.Response> getProducts(String sort, String page, String per_page) async {
    printLog('loadProducts', sort+"=="+page+"=="+per_page);
    var response=  await http.get(WebRequestConstants.getWPBaseUrl+WebRequestConstants.getDomainUrl+WebRequestConstants.CUSTOM_PRODUCT
        +"?"+"sort="+sort+"&"+"page="+page+"&"+"per_page="+per_page
    );
    return response;
  }
}
