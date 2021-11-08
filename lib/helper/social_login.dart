import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/screens/splesh.dart';

class FBLogin {
  var profileData;
  SocialLogin? socialLogin;


  Future<SocialLogin?> signInFB() async {

    final LoginResult result = await FacebookAuth.instance.login();
    switch (result.status) {
    case LoginStatus.success:
        final String token = result.accessToken!=null ? result.accessToken!.token : "";
        final response = await http.get(Uri.parse("https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token"));
        final profile = jsonDecode(response.body);
        if (profile != null) {
          SocialLogin socialLogin = new SocialLogin();
          socialLogin.id = profile['id'];
          socialLogin.name= profile['name'];
          socialLogin.lastName = profile['last_name'];
          socialLogin.mode= 'facebook';
          socialLogin.email= profile['email'];
        }
        break;
      case LoginStatus.cancelled:
        socialLogin = null;
        break;
      case LoginStatus.operationInProgress:
        break;
      case LoginStatus.failed:
        socialLogin = null;
        break;
    }
    return socialLogin;
  }

  Future signOutFB(BuildContext context) async {
    await FacebookAuth.instance.logOut();
    changeScreenReplacement(context, SpleshScreen());
  }

}
