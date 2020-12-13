import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier{
  bool isLoading = true;
  String filterBy = "Products";
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;

  void changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

}