import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/coupons.dart';
import 'package:wooapp/models/order.dart';
import 'package:wooapp/models/revieworder.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

class CartProvider with ChangeNotifier {
  late CartModel _cartModel;
  late List<Coupons> _coupons;
  late bool _response;
  late int _cartItemCount;
  late bool loader;
  late ReviewOrder _reviewOrder;
  late OrderModel _orderModel;
  late OrderHistory _orderSummary;
  OrderHistory get orderSummary=> _orderSummary;
  OrderModel get getOrderModel => _orderModel;
  CartModel get getCart => _cartModel;
  int get totalCartItem=>_cartItemCount;
  ReviewOrder get reviewOrder => _reviewOrder;
  List<Coupons> get getCoupons => _coupons;
  late WebApiServices _webApiServices;

  CartProvider.initialize() {
    _webApiServices= new WebApiServices();
    _response = false;
    loader= false;
    getCartData();
    getCartItemCount();
  }
  void resetStreams(){
    _cartItemCount= 0;
    _webApiServices = WebApiServices();
   _cartModel = new CartModel();
  }

  Future getUpdateToCart(String cartItemKey, int quantity, Function onCallBack)async{
    _cartModel=await _webApiServices.getUpdateToCart(cartItemKey, quantity);
    onCallBack(_cartModel);
    notifyListeners();
  }
  Future getRemoveToCart({required String cartItemKey, required Function onCallBack})async{
    _cartModel=await _webApiServices.getRemoveToCart(cartItemKey);
    resetStreams();
    onCallBack(_cartModel);
    notifyListeners();
  }
  getClearToCart()async{
    return await _webApiServices.getClearToCart();
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
  getOrderList({required String id}) async{
    loader= true;
    _orderSummary= await _webApiServices.getOrders(id: id, offset: 5, limit: 5);
    loader= false;
    notifyListeners();
  }
  Future getApplyCoupons({required String couponCode, required Function onCallBack})async{
    _cartModel = await _webApiServices.getApplyCoupons(coupon_code: couponCode);
    resetStreams();
    onCallBack(_cartModel);
    notifyListeners();
  }
  Future getNewOrder({required int userId, required String paymentMethod})async{
    _orderModel = await _webApiServices.getNewOrder(userId: userId, paymentMethod: paymentMethod);
    return _orderModel;
  }
  Future getRemoveCoupons({required String couponCode, required Function onCallBack})async{
    _cartModel = await _webApiServices.getRemoveCoupons(coupon_code: couponCode);
    onCallBack(_cartModel);
    notifyListeners();
  }
  Future getReviewOrder()async{
    _reviewOrder = await _webApiServices.getReviewOrder();
    notifyListeners();
  }
  Future getUpdateOrder({required String orderId, required String status, required String transactionId})async{

   await _webApiServices.getUpdateOrder(order_id: orderId, status: status, transaction_id: transactionId).then((value) {
      if(value){
       _webApiServices.getClearToCart().then((value){
         printLog("cartClear",value);
         _response = value;
       });
      }
    });
   return _response;
  }
}
