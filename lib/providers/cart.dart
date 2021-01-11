import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/coupons.dart';
import 'package:wooapp/models/revieworder.dart';
import 'package:wooapp/services/cart.dart';
import 'dart:convert';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

class CartProvider with ChangeNotifier {
  WebResponseModel _webResponseModel;
  CartServices cartServices ;
  CartModel _cartModel;
  List<Coupons> _coupons;
  int _cartItemCount;
  ReviewOrder _reviewOrder;
  CartModel get getCart => _cartModel;
  ReviewOrder get reviewOrder => _reviewOrder;
  List<Coupons> get getCoupons => _coupons;
  WebApiServices _webApiServices= new WebApiServices();
  CartProvider() {
    resetStreams();
  }
  void resetStreams(){
    _webApiServices = WebApiServices();
   _cartModel = new CartModel();
    _webResponseModel = new WebResponseModel();
  }
    getAddToCart({int id, String quantity})async{
     _webResponseModel=await _webApiServices.getAddToCart(id, quantity);
     notifyListeners();
    }

  getAddToCartVariationProduct({String id, String quantity, String variation, String variation_id}) async{
    _webResponseModel = await _webApiServices.getAddToCartVariationProduct(id, quantity, variation, variation_id);
    notifyListeners();
  }

  Future getUpdateToCart(String cartItemKey, int quantity, Function onCallBack)async{
    _cartModel=await _webApiServices.getUpdateToCart(cartItemKey, quantity);

    onCallBack(_cartModel);
    notifyListeners();
  }
  Future getRemoveToCart({String cartItemKey, Function onCallBack})async{
    _cartModel=await _webApiServices.getRemoveToCart(cartItemKey);
    resetStreams();
    onCallBack(_cartModel);
    notifyListeners();
  }
  getClearToCart()async{
    _webResponseModel=await _webApiServices.getClearToCart();
    notifyListeners();
  }
  getCartItemCount()async{
    _cartItemCount=await _webApiServices.getCartItemCount();
    notifyListeners();
  }
  getCartData() async{
      _cartModel = await _webApiServices.getCart();
      notifyListeners();
  }
  getOfferData() async{
    _coupons = await _webApiServices.getCoupons();
    notifyListeners();
  }
  Future getApplyCoupons({String coupon_code, Function onCallBack})async{
    _cartModel = await _webApiServices.getApplyCoupons(coupon_code: coupon_code);
    resetStreams();
    onCallBack(_cartModel);
    notifyListeners();
  }
  Future getReviewOrder()async{
    _reviewOrder = await _webApiServices.getReviewOrder();
    notifyListeners();
  }
}
