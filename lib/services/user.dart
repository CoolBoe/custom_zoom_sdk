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

class UserServices {
  String userName = "filledstacks";

  Future<bool> logIn(email, password) async {
    bool ret = false;
    await WebApiServices().userLogin(email, password).then((data) {
      if (data.statusCode == HTTP_CODE_200 ||
          data.statusCode == HTTP_CODE_201) {
        printLog("API LoginUser(200):- ", data.data);
        Map<String, dynamic> result = json.decode(data.data);
        if (result['status'] == '1') {
          toast(result['message']);
          ret = true;
        } else {
          toast(result['message']);
          ret = false;
        }
      } else {
        ret = false;
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
          ret = true;
        } else {
          ret = false;
        }
      } else {
        ret = false;
      }
    });
    return ret;
  }

  Future<bool> registerUser(name, email, password) async {
    bool ret = false;
    await WebApiServices().userRegister(name, email, password).then((data) {
      ret = false;
      if (data.statusCode == HTTP_CODE_200) {
        printLog("API RegisterUser(200):- ", data.data);
        Map<String, dynamic> result = json.decode(data.data);
        printLog("API RegisterUser(200):- ", result);
        if (result['status'] == 1) {
          toast(result['message'].toString());
          ret = true;
        } else {
          ret = false;
          toast(result['error'].toString());
        }
      } else {
        ret = false;
      }
    });
    return ret;
  }

  Future<bool> forget_password(email) async {
    await WebApiServices().forgetPassword(email).then((data) {
      if (data.statusCode == HTTP_CODE_200) {
        printLog("API ForgetPass(200):- ", data.body);
        Map<String, dynamic> result = json.decode(data.body);
        if (result['code'] == '1') {
          toast(result['message']);
        } else {
          toast(EMAIL_NOT_FOUND);
        }
      } else {}
    });
    return true;
  }

  Future<bool> change_password(userId) async {
    await WebApiServices().changePassword(userId).then((data) {
      if (data.statusCode == HTTP_CODE_200) {
        printLog("API ChangePass(200):- ", data.body);
        Map<String, dynamic> result = json.decode(data.body);
        if (result['code'] == '1') {
          toast(result['message']);
        } else {
          toast(EMAIL_NOT_FOUND);
        }
      } else {}
    });
    return true;
  }
}
