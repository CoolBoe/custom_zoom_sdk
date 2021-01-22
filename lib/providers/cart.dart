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
  bool _response = false;
  int _cartItemCount;
  bool loader= false;
  ReviewOrder _reviewOrder;
  OrderModel _orderModel;
  OrderHistory _orderSummary;
  OrderHistory get orderSummary=> _orderSummary;

  OrderModel get getOrderModel => _orderModel;
  CartModel get getCart => _cartModel;
  int get totalCartItem=>_cartItemCount;
  ReviewOrder get reviewOrder => _reviewOrder;
  List<Coupons> get getCoupons => _coupons;
  WebApiServices _webApiServices= new WebApiServices();


  CartProvider.initialize() {
    _webApiServices= new WebApiServices();
    getCartData();
    getCartItemCount();
  }
  void resetStreams(){
    _cartItemCount= 0;
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
    return await _webApiServices.getClearToCart();
    notifyListeners();
  }
  getCartItemCount()async{
    _cartItemCount=await _webApiServices.getCartItemCount();
    notifyListeners();
  }
  getCartData() async{
    loader= true;
      _cartModel = await _webApiServices.getCart();
    loader= false;
      notifyListeners();
  }
  getOfferData() async{
    loader= true;
    _coupons = await _webApiServices.getCoupons();
    loader= false;
    notifyListeners();
  }
  getOrderList({String id}) async{
    loader= true;
    _orderSummary= await _webApiServices.getOrders(id: id, offset: 5, limit: 5);
    loader= false;
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
  Future getRemoveCoupons({String coupon_code, Function onCallBack})async{
    _cartModel = await _webApiServices.getRemoveCoupons(coupon_code: coupon_code);
    onCallBack(_cartModel);
    notifyListeners();
  }
  Future getReviewOrder()async{
    _reviewOrder = await _webApiServices.getReviewOrder();
    notifyListeners();
  }
  Future getUpdateOrder({String order_id, String status, String transaction_id})async{

   await _webApiServices.getUpdateOrder(order_id: order_id, status: status, transaction_id: transaction_id).then((value) {
      if(value){
       _webApiServices.getClearToCart().then((value){
         printLog("cartClear",value);
         _response = value;
       });
      }
    });
   printLog("datdatdtd", _response);
   return _response;
  }
}
