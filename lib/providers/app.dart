import 'package:flutter/cupertino.dart';

enum ProductBy{Default, Category, Price, Attribute}
class AppProvider with ChangeNotifier{
  bool isLoading = true;
  ProductBy product = ProductBy.Default;
  String filterBy = "Default";
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;
  int productBy;


  void changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }
  void changeProductBy({ProductBy newProductBy}){
    product = newProductBy;
    switch(newProductBy.toString()){
      case 'Category':
        filterBy = "Category";
        break;
      case 'Price':
        filterBy ='Price';
        break;
      case 'Attribute':
        filterBy ='Attribute';
        break;
      default :
        filterBy ='Default';
        break;
    }
    notifyListeners();
  }
}