
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

enum Status{Unauthorized, Authorized}
class UserProvider with ChangeNotifier{
  Status _status = Status.Unauthorized;
  String errorMessage;
  bool loading = false;
  UserModel userModel;
  String userId;
  bool social_login_status=false;

  Status get status => _status;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController countryCode = TextEditingController();

  UserProvider.initialize(){
   _onStateChanged();
  }

  Future<bool>logIn(email, password) async{
    setLoading(true);
    await WebApiServices().userLogin(email, password).then((data){
    setLoading(false);
      if(data.statusCode==HTTP_CODE_200){
        printLog("API LoginUser(200):- ",data.body);
        Map<String, dynamic> result = json.decode(data.body);
        if(result['status']=='1'){
          _status =Status.Authorized;
          toast(result['message']);
        }else{
          _status =Status.Unauthorized;
          toast(result['message']);
          return false;
        }
      }else{
        setMessage(NETWORK_ERROR);
      }
    });
    return isUser();
  }
  Future<bool>social_login(mode, name, firstName, lastName, email)async{
    setLoading(true);
    await WebApiServices().socialLogin(mode, name, firstName, lastName,email).then((data){
      setLoading(false);
      if(data.statusCode==HTTP_CODE_200){
        printLog("API SocialLogin(200):- ",data.body);
        Map<String, dynamic> result = json.decode(data.body);
        if(result['code']=='1'){
          _status=Status.Authorized;
          social_login_status= true;
        }else{
          _status=Status.Unauthorized;
          social_login_status= false;
        }
      }else{
        setMessage(NETWORK_ERROR);
      }
    });
    return social_login_status;
  }

  Future<bool>registerUser(name, email, password) async{
    setLoading(true);
    await WebApiServices().userRegister(name, email, password).then((data){
      setLoading(false);
      if(data.statusCode==HTTP_CODE_200){
        printLog("API RegisterUser(200):- ",data.body);
        Map<String, dynamic> result = json.decode(data.body);
        printLog("API RegisterUser(200):- ",result);
        if(result['status']==1){
          toast(result['message'].toString());
        }else{
          toast(result['error'].toString());
        }
      }else{
        setMessage(NETWORK_ERROR);
      }
    });
    return isUser();
  }

  Future<bool>forget_password(email) async{
    setLoading(true);
    await WebApiServices().forgetPassword(email).then((data){
      setLoading(false);
      if(data.statusCode==HTTP_CODE_200){
        printLog("API ForgetPass(200):- ",data.body);
        Map<String, dynamic> result = json.decode(data.body);
        if(result['code']=='1'){
          toast(result['message']);
        }else{
          toast(EMAIL_NOT_FOUND);
        }
      }else{
        setMessage(NETWORK_ERROR);
      }
    });
    return isUser();
  }

  Future<bool>change_password(userId) async{
    setLoading(true);
    await WebApiServices().changePassword(userId).then((data){
      setLoading(false);
      if(data.statusCode==HTTP_CODE_200){
        printLog("API ChangePass(200):- ",data.body);
        Map<String, dynamic> result = json.decode(data.body);
        if(result['code']=='1'){
          toast(result['message']);
        }else{
          toast(EMAIL_NOT_FOUND);
        }
      }else{
        setMessage(NETWORK_ERROR);
      }
    });
    return isUser();
  }

  Future<void> _onStateChanged() async{
    await BasePrefs.init();
    if(BasePrefs.getString(USER_NAME) == null){
      _status = Status.Unauthorized;
    }else{
      _status = Status.Authorized;
     }
    notifyListeners();
  }

  void setLoading(value) {
    loading=value;
    notifyListeners();
  }
  Future<bool> signOut()async{
      userId  = "";
      _status=Status.Unauthorized;
      SharedPreferences preferences= await SharedPreferences.getInstance();
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
  UserModel getUser(){
    _status= Status.Authorized;
    return userModel;
  }
  bool isUser() {
    return userId != null ? true : false;
  }
  void clearController(){
    name.text = "";
    password.text = "";
    email.text = "";
    countryCode.text="";
    mobile.text= "";
  }
}