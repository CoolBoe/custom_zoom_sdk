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


  Future<SocialLogin> signInFB() async {
    final FacebookLoginResult result = await fbLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.error:
        printLog('FacebookLoginResult(error):- ', result.errorMessage);
        return null;
        break;
      case FacebookLoginStatus.cancelledByUser:
        printLog('FacebookLoginResult(cancelByUser):- ', result.errorMessage);
        return null;
        break;
      case FacebookLoginStatus.loggedIn:
        printLog('FacebookLoginResult', result.errorMessage);
        final String token = result.accessToken.token;
        final response = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = JSON.jsonDecode(response.body);
        if (profile != null) {
          SocialLogin socialLogin = new SocialLogin();
          socialLogin.id = profile['id'];
          socialLogin.name= profile['name'];
          socialLogin.last_name = profile['last_name'];
          socialLogin.mode= 'facebook';
          socialLogin.email= profile['email'];
          return socialLogin;
        }return null;
        break;
    }return null;
  }

  Future signOutFB(BuildContext context) async {
    await fbLogin.logOut();
    changeScreenReplacement(context, splesh.SpleshScreen());
  }

}
