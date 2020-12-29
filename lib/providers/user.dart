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
  bool loading = false;
  UserModel userModel;
  String userId;
  bool social_login_status = false;
  bool apiResponse = false;
  Status get status => _status;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController countryCode = TextEditingController();

  UserProvider.initialize() {
    _onStateChanged();
  }

  Future<bool> logIn(email, password) async {
    bool ret = false;
    await WebApiServices().userLogin(email, password).then((data) {
      if (data.statusCode == HTTP_CODE_200 ||
          data.statusCode == HTTP_CODE_201) {
        printLog("API LoginUser(200):- ", data.data);
        Map<String, dynamic> result = json.decode(data.data);
        if (result['status'] == '1') {
          _status = Status.Authorized;
          toast(result['message']);
          ret = true;
        } else {
          _status = Status.Unauthorized;
          toast(result['message']);
          ret = false;
        }
      } else {
        ret = false;
        setMessage(NETWORK_ERROR);
      }
    });
    return ret;
  }

  Future<bool> social_login(mode, name, firstName, lastName, email) async {
    printLog(
        "APISocialLogin:- ", "$mode + $name + $firstName+ $lastName+ $email");
    bool ret = false;
    await WebApiServices()
        .socialLogin(mode, name, firstName, lastName, email)
        .then((data) {
      ret = false;
      if (data.statusCode == HTTP_CODE_200 ||
          data.statusCode == HTTP_CODE_201) {
        printLog("API SocialLogin(200):- ", data.body);
        Map<String, dynamic> result = json.decode(data.body);
        if (result['code'] == '1') {
          _status = Status.Authorized;
          social_login_status = true;
          ret = true;
        } else {
          _status = Status.Unauthorized;
          social_login_status = false;
          ret = false;
        }
      } else {
        ret = false;
        setMessage(NETWORK_ERROR);
      }
    });
    return ret;
  }

  Future<bool> registerUser(name, email, password) async {
    await WebApiServices().userRegister(name, email, password).then((data) {
      BasePrefs.init();
      if (data.statusCode == HTTP_CODE_200) {
        WebResponseModel webResponseModel = new WebResponseModel();
        printLog("API RegisterUser(200):- ", data);
        Map<String, dynamic> result = data.data;
        if (result['status'] == '1') {
          printLog("API RegisterUser(200):- ", "true");
          BasePrefs.setString(USER_FIRST_NAME, name);
          BasePrefs.setString(USER_EMAIL, email);
          BasePrefs.setString(USER_ID, result['user_id'].toString());
          apiResponse = true;
        } else {
          printLog("API RegisterUser(200):- ", "false");
          apiResponse = false;
        }
      } else {
        apiResponse = false;
      }
    });
    return apiResponse;
  }

  Future<bool> forget_password(email) async {
    await WebApiServices().forgetPassword(email).then((data) {
      setLoading(false);
      if (data.statusCode == HTTP_CODE_200) {
        printLog("API ForgetPass(200):- ", data.body);
        Map<String, dynamic> result = json.decode(data.body);
        if (result['code'] == '1') {
          toast(result['message']);
        } else {
          toast(EMAIL_NOT_FOUND);
        }
      } else {
        setMessage(NETWORK_ERROR);
      }
    });
    return isUser();
  }

  Future<bool> change_password(userId) async {
    setLoading(true);
    await WebApiServices().changePassword(userId).then((data) {
      setLoading(false);
      if (data.statusCode == HTTP_CODE_200) {
        printLog("API ChangePass(200):- ", data.body);
        Map<String, dynamic> result = json.decode(data.body);
        if (result['code'] == '1') {
          toast(result['message']);
        } else {
          toast(EMAIL_NOT_FOUND);
        }
      } else {
        setMessage(NETWORK_ERROR);
      }
    });
    return isUser();
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

  void setLoading(value) {
    loading = value;
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

  bool isLoading() {
    return loading;
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }

  void setUser(value) {
    print(value.toString());
    userModel = value;
    notifyListeners();
  }

  UserModel getUser() {
    _status = Status.Authorized;
    return userModel;
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
