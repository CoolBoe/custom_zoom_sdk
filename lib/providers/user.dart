import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

enum Status { Unauthorized, Authorized }

class UserProvider with ChangeNotifier {
  Status _status = Status.Unauthorized;
  String errorMessage;
  WebApiServices _webApiServices = WebApiServices();
  bool login_Status = false;
  bool loading = false;
  UserModel userModel;
  Details userDetails;
  Details get getuserDetails=>userDetails;
  UserModel get userInfo=>userModel;
  String userId;
  Status get status => _status;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController countryCode = TextEditingController();

  UserProvider() {
    userModel = new UserModel();
    _webApiServices = new WebApiServices();
    _onStateChanged();
  }

  Future<Details> logIn(email, password) async {
    userDetails = await WebApiServices().userLogin(email, password);
    return userDetails;
  }

  Future<bool> social_login({String mode, String name, String firstName, String lastName, String email}) async {
    printLog(
        "APISocialLogin:- ", "$mode + $name + $firstName+ $lastName+ $email");
     login_Status= await _webApiServices
        .socialLogin(mode: mode, name: name, firstName: firstName, lastName: lastName, email: email);
     if(login_Status){
       BasePrefs.init();
       BasePrefs.setString(USER_EMAIL, email);
       BasePrefs.setString(SOCIAL_LOGIN_MODE, mode);
       BasePrefs.setString(USER_NAME, name);
     }
    return login_Status;
  }

  Future<bool> registerUser(name, email, password) async {
    login_Status =await _webApiServices.userRegister(name, email, password);
    return login_Status;
  }

  Future<bool> forget_password(email) async {
    return await WebApiServices().forgetPassword(email);
  }

  Future<bool> change_password(userId) async {
   return await WebApiServices().changePassword(userId);
  }

  Future<void> _onStateChanged() async {
    await BasePrefs.init();
    if (BasePrefs.getString(USER_MODEL) == null) {
      _status = Status.Unauthorized;
    } else {
      _status = Status.Authorized;
    }
    notifyListeners();
  }
  Future<bool> signOut() async {
    userId = "";
    _status = Status.Unauthorized;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  bool isUser() {
    return userId != null ? true : false;
  }

  Future<Details> getUserInfo() async{
    userDetails = await _webApiServices.getUserInfo();
    printLog("_webApiServices", userModel.toJson().toString());
    notifyListeners();
  }

  Future<UserModel>getBillingpdate({String billing_email, String billing_phone, String billing_address_1, String billing_address_2,
    String billing_city, bool checkbox, String user_id, String billing_first_name, String billing_last_name, String billing_company,
    String billing_state, String billing_postcode, String billing_country}) async{
      userModel = await _webApiServices.updateBilling(billing_email: billing_email, billing_phone: billing_phone, billing_address_1:billing_address_1,
          billing_address_2:billing_address_2, billing_city:billing_city, checkbox:checkbox, user_id:user_id, billing_first_name:billing_first_name,
          billing_last_name:billing_last_name, billing_company:billing_company, billing_state:billing_state, billing_postcode:billing_postcode,
          billing_country:billing_country
      );
      notifyListeners();
      }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
    countryCode.text = "";
    mobile.text = "";
  }
}
