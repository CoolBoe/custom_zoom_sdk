import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/coupons.dart';
import 'package:wooapp/models/order.dart';
import 'package:wooapp/models/revieworder.dart';
import 'dart:convert';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

class CartProvider with ChangeNotifier {
  WebResponseModel _webResponseModel;
  CartModel _cartModel;
  List<Coupons> _coupons;
  int _cartItemCount;
  ReviewOrder _reviewOrder;
  OrderModel _orderModel;
  List<OrderModel> _orderList;
  List<OrderModel> get orderList=>_orderList;
  OrderModel get getOrderModel => _orderModel;
  CartModel get getCart => _cartModel;
  int get totalCartItem=>_cartItemCount;
  ReviewOrder get reviewOrder => _reviewOrder;
  List<Coupons> get getCoupons => _coupons;
  WebApiServices _webApiServices= new WebApiServices();
  CartProvider() {
    getCartItemCount();
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
    _webResponseModel = await _webApiServices.getAddToCartVariationProduct();
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
  getOrderList() async{
    _orderList = await _webApiServices.getOrders();
    notifyListeners();
  }
  Future getApplyCoupons({String coupon_code, Function onCallBack})async{
    _cartModel = await _webApiServices.getApplyCoupons(coupon_code: coupon_code);
    resetStreams();
    onCallBack(_cartModel);
    notifyListeners();
  }
  Future getNewOrder({int userId, String paymentMethod})async{
    _orderModel = await _webApiServices.getNewOrder(userId: userId, paymentMethod: paymentMethod);
    return _orderModel;
  }
  Future getReviewOrder()async{
    _reviewOrder = await _webApiServices.getReviewOrder();
    notifyListeners();
  }
  Future getUpdateOrder({String order_id, String status, String transaction_id})async{
    return  await _webApiServices.getUpdateOrder(order_id: order_id, status: status, transaction_id: transaction_id);
  }
}
