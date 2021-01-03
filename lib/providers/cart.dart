import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/services/cart.dart';
import 'dart:convert';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

class CartProvider with ChangeNotifier {
  WebResponseModel _webResponseModel;
  CartServices cartServices ;
  CartModel _cartModel;
  CartModel get getCart => _cartModel;
  WebApiServices _webApiServices= new WebApiServices();
  CartProvider() {
    resetStreams();
  }
  void resetStreams(){
    _webApiServices = WebApiServices();
   _cartModel = new CartModel();
    _webResponseModel = new WebResponseModel();
  }
    getAddToCart({String id, String quantity})async{
     _webResponseModel=await _webApiServices.getAddToCart(id, quantity);
     notifyListeners();
    }

  getAddToCartVariationProduct({String id, String quantity, String variation, String variation_id}) async{
    _webResponseModel = await _webApiServices.getAddToCartVariationProduct(id, quantity, variation, variation_id);
    notifyListeners();
  }

    getCartData() async{
      _cartModel = await _webApiServices.getCart();
      notifyListeners();
    }
}
