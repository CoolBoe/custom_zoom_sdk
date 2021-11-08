import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/loader_provider.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

enum Status { Unauthorized, Authorized, Guest }

class UserProvider with ChangeNotifier {
  late Status _status;
  late bool updateBilling;
  late String errorMessage;
  late WebApiServices _webApiServices;
  late bool loginStatus;
  late bool loading;
  late UserModel userModel;
  late Details userDetails;
  Details get getUserDetails=>userDetails;
  UserModel get userInfo=>userModel;
  late String userId;
  Status get status => _status;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController name;
  late TextEditingController mobile;
  late TextEditingController countryCode;

  UserProvider.initialize() {
    userModel = new UserModel();
    loading = false;
    loginStatus = false;
    updateBilling = false;
    _status = Status.Unauthorized;
    _webApiServices = new WebApiServices();
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    mobile = TextEditingController();
    countryCode = TextEditingController();
    _onStateChanged();
  }

  Future<Details> logIn(email, password) async {
    userDetails = await WebApiServices().userLogin(email, password);
    notifyListeners();
    return userDetails;
  }

  Future<Details?> socialLogin({required BuildContext context}) async {
    var loader = Provider.of<LoaderProvider>(context, listen: false);
    final LoginResult result = await FacebookAuth.instance.login();
    switch (result.status) {
      case LoginStatus.success:
        final String token = result.accessToken!.token;

        final response = await http.get(Uri.parse("https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture.height(200),email&access_token=$token"));
        final profile = JSON.jsonDecode(response.body);
        if (profile != null) {
          String data=  profile['picture']['data']['url'];
          printLog("Datadt", data);
          BasePrefs.setString(AVTAR_URL, data);
          toast("logging via facebook");
          loader.setLoadingStatus(true);
          userDetails= await _webApiServices
              .socialLogin(mode: 'facebook', name: profile['name'], firstName: profile['first_name'], lastName: profile['last_name'], email: profile['email']);
          loader.setLoadingStatus(false);
          notifyListeners();
          return userDetails;
        }return null;
      case LoginStatus.cancelled:
        return null;
      case LoginStatus.failed:
        return null;
      case LoginStatus.operationInProgress:
        return null;
    }
  }


  Future<Details?> googleLogin({required BuildContext context})async{
    await Firebase.initializeApp();
    var loader = Provider.of<LoaderProvider>(context, listen: false);
    loader.setLoadingStatus(false);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount= await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication= await googleSignInAccount!.authentication;

    final AuthCredential credential= GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    if(user!=null){
      loader.setLoadingStatus(true);
      assert(!user.isAnonymous);
      final User? currentUser = _auth.currentUser;
      assert(user.uid==currentUser!.uid);
      BasePrefs.setString(AVTAR_URL, currentUser!.photoURL);
      userDetails= await _webApiServices
          .socialLogin(mode: 'google', name: currentUser.displayName!, firstName: currentUser.displayName!, lastName: "", email: currentUser.email!);
      loader.setLoadingStatus(false);
      notifyListeners();
      return userDetails;
    }else{
      return null;
    }
}

  Future<bool> registerUser(name, email, password) async {
    loginStatus =await _webApiServices.userRegister(name, email, password);
    notifyListeners();
    return loginStatus;
  }

  Future<bool> forgetPassword(email) async {
    return await WebApiServices().forgetPassword(email);
  }

  Future<bool> changePassword(userId) async {
   return await WebApiServices().changePassword(userId);
  }

  Future<void> _onStateChanged() async {

    if (await BasePrefs.getString(USER_MODEL) == null) {
      _status = Status.Guest;
    } else {
      _status = Status.Authorized;
    }
    notifyListeners();
  }


  Future<String> getProfileImage()async{
    if(await BasePrefs.getString(AVTAR_URL)!=null){
      return await BasePrefs.getString(AVTAR_URL);
    }else{
      return Thumbnail_User;
    }
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
    countryCode.text = "";
    mobile.text = "";
  }
}
