import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/user.dart';
import 'dart:convert' as JSON;
import 'package:wooapp/screens/splesh.dart' as splesh;

import 'package:wooapp/widgets/loading.dart';

class FBLogin {
  final fbLogin = FacebookLogin();
  var profileData;
  bool isLoggedIn = false;

  Future<bool> signInFB() async {
    final FacebookLoginResult result = await fbLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.error:
        printLog('FacebookLoginResult(error):- ', result.errorMessage);
        isLoggedIn = false;
        break;
      case FacebookLoginStatus.cancelledByUser:
        printLog('FacebookLoginResult(cancelByUser):- ', result.errorMessage);
        isLoggedIn = false;
        break;
      case FacebookLoginStatus.loggedIn:
        printLog('FacebookLoginResult', result.errorMessage);
        final String token = result.accessToken.token;
        final response = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = JSON.jsonDecode(response.body);
        if (profile != null) {
          BasePrefs.saveData(USER_NAME, profile['name']);
          BasePrefs.saveData(USER_LAST_NAME, profile['last_name']);
          BasePrefs.saveData(USER_EMAIL, profile['email']);
          BasePrefs.saveData(USER_FB_ID, profile['id']);
          BasePrefs.saveData(SOCIAL_LOGIN_MODE, 'facebook');
          isLoggedIn = true;
        } else {
          isLoggedIn = false;
        }
        break;
    }
    return isLoggedIn;
  }

  Future signOutFB(BuildContext context) async {
    await fbLogin.logOut();
    changeScreenReplacement(context, splesh.SpleshScreen());
  }

  void onLoginStatusChanged(bool isLoggedIn) {
    if (isLoggedIn) {
      toast(LOGIN_STATUS_TRUE);
    } else {
      toast(LOGIN_STATUS_FALSE);
    }
  }
}
