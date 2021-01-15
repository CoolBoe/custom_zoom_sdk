import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/order.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/widgets/loading.dart';

class RazorPaymentService{
Razorpay _razorpay;
BuildContext _buildContext;
String orderId;
  initPaymentGatway(BuildContext context, String OrderId){
    this._buildContext = context;
    this.orderId = OrderId;
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
  }
  void externalWallet(ExternalWalletResponse response){
    printLog("EVENT_EXTERNAL_WALLET", response.walletName);
  }
  void paymentSuccess(PaymentSuccessResponse response){
    printLog("EVENT_PAYMENT_SUCCESS", response.toString());
    var cart  = Provider.of<CartProvider>(_buildContext, listen: false);
    printLog("dtadta", "orderID = ${orderId}, transaction_id=> ${response.paymentId}");
    cart.getUpdateOrder(status: "processing", order_id: orderId, transaction_id: response.paymentId).then((value) {
     if(value){
       toast("Order Placed");
     }else{
       toast(NETWORK_ERROR);
     }
    }
    );
    // changeToNewScreen(_buildContext, OrderSummary(), "/OrderSummery");
  }
  void paymentError(PaymentFailureResponse response){
    printLog("EVENT_PAYMENT_ERROR", response.message.toString()+"-"+response.code.toString());
  }
  getPayment({BuildContext context, String amount, String mobile, String email, String name, String orderId}){
    int netValue = int.parse(amount.replaceAll('.', ''));
    printLog("orderId", email);

    var options = {
      'id':orderId,
      'key':'rzp_test_2akds9ynth1XSc',
      'amount': netValue,
      'name': "Woo App",
      'description': "Payment For Woo App",
      'merchant_order_id':orderId,
      'prefill':{
        'contact':mobile,
        'email':email,
      },
      'theme': {
        "color": "#FFA500"
      }
    };
    try{
      _razorpay.open(options);
    }catch(e){
      printLog("_razorpaypaymenterror", e);
    }
  }

}