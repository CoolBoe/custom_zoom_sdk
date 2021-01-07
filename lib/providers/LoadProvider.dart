import 'package:flutter/cupertino.dart';
import 'package:wooapp/widgets/loading.dart';

class LoaderProvider with ChangeNotifier{
  bool _isApiCallProcess = false;
  bool get isApiCallProcess=>_isApiCallProcess;

  setLoadingStatus(bool status){
    printLog("setLoadingStatus", status);
    _isApiCallProcess = status;
    notifyListeners();
  }

}