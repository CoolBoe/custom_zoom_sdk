import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

enum Status { Unauthorized, Authorized, Guest }

class UserProvider with ChangeNotifier {
  Status _status = Status.Unauthorized;
  bool updateBilling = false;
  String errorMessage;
  WebApiServices _webApiServices = WebApiServices();
  bool login_Status = false;
  bool loading = false;
  UserModel userModel;
  Details userDetails;
  final fbLogin = FacebookLogin();

  Details get getuserDetails=>userDetails;
  UserModel get userInfo=>userModel;
  String userId;
  Status get status => _status;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController countryCode = TextEditingController();

  UserProvider.initialize() {
    userModel = new UserModel();
    _webApiServices = new WebApiServices();
    _onStateChanged();
  }

  Future<Details> logIn(email, password) async {
    userDetails = await WebApiServices().userLogin(email, password);
    notifyListeners();
    return userDetails;
  }

  Future<Details> social_login({BuildContext context}) async {
    var loader = Provider.of<LoaderProvider>(context, listen: false);
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
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture.height(200),email&access_token=${token}');
        final profile = JSON.jsonDecode(response.body);
        if (profile != null) {
          BasePrefs.init();

          String Data=  profile['picture']['data']['url'];
          printLog("Datadt", Data);
          BasePrefs.setString(AVTAR_URL, Data);
          toast("logging via facebook");
          loader.setLoadingStatus(true);
          userDetails= await _webApiServices
              .socialLogin(mode: 'facebook', name: profile['name'], firstName: profile['first_name'], lastName: profile['last_name'], email: profile['email']);
         loader.setLoadingStatus(false);
          notifyListeners();
          return userDetails;
        }return null;
        break;
    }return null;
  }


  Future<Details> google_login({BuildContext context})async{
    await Firebase.initializeApp();
    var loader = Provider.of<LoaderProvider>(context, listen: false);
    loader.setLoadingStatus(false);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount= await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication= await googleSignInAccount.authentication;

    final AuthCredential credential= GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if(user!=null){
      BasePrefs.init();
      loader.setLoadingStatus(true);
      assert(!user.isAnonymous);
      assert(await user.getIdToken()!=null);
      final User currentUser = _auth.currentUser;
      assert(user.uid==currentUser.uid);
      BasePrefs.setString(AVTAR_URL, currentUser.photoURL);
      userDetails= await _webApiServices
          .socialLogin(mode: 'google', name: currentUser.displayName, firstName: currentUser.displayName, lastName: "", email: currentUser.email);
      loader.setLoadingStatus(false);
      notifyListeners();
      return userDetails;
    }else{

      return null;
    }

}

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

  Future<bool> registerUser(name, email, password) async {
    login_Status =await _webApiServices.userRegister(name, email, password);
    notifyListeners();
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
      _status = Status.Guest;
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

  String getProfileImage(){
    BasePrefs.init();
    if(BasePrefs.getString(AVTAR_URL)!=null){
      return BasePrefs.getString(AVTAR_URL);
    }else{
      return Thumbnail_User;
    }
  }

  // Future<UserModel>getBillingpdate({String billing_email, String billing_phone, String billing_address_1, String billing_address_2,
  //   String billing_city, bool checkbox, String user_id, String billing_first_name, String billing_last_name, String billing_company,
  //   String billing_state, String billing_postcode, String billing_country}) async{
  //     userModel = await _webApiServices.updateBilling(billing_email: billing_email, billing_phone: billing_phone, billing_address_1:billing_address_1,
  //         billing_address_2:billing_address_2, billing_city:billing_city, checkbox:checkbox, user_id:user_id, billing_first_name:billing_first_name,
  //         billing_last_name:billing_last_name, billing_company:billing_company, billing_state:billing_state, billing_postcode:billing_postcode,
  //         billing_country:billing_country
  //     );
  //     notifyListeners();
  //     }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
    countryCode.text = "";
    mobile.text = "";
  }
}
