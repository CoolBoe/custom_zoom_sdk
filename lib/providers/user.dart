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
  String userId;
  Status get status => _status;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController countryCode = TextEditingController();

  UserProvider() {
    _onStateChanged();
  }

  Future<bool> logIn(email, password) async {
    login_Status = await WebApiServices().userLogin(email, password);
    if(login_Status){
      BasePrefs.setString(USER_EMAIL, email);
    }
    return login_Status;
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
    if(login_Status){
      BasePrefs.init();
      BasePrefs.setString(USER_EMAIL, email);
      BasePrefs.setString(USER_NAME, name);
    }
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
    if (BasePrefs.getString(USER_NAME) == null) {
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

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
    countryCode.text = "";
    mobile.text = "";
  }
}
