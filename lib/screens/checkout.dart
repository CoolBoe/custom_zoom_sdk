import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/order.dart';
import 'package:wooapp/models/paymentGateway.dart';
import 'package:wooapp/models/revieworder.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/cart.dart';
import 'package:wooapp/screens/delivery.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/offer.dart';
import 'package:wooapp/services/razorpay.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/widgetShippingCart.dart';
import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/loading.dart';

class CheckOutScreen extends BasePage {
  String total;
  CheckOutScreen({Key key, this.total}) : super(key: key);
  @override
  _CheckOutScreenrState createState() => _CheckOutScreenrState();
}

class _CheckOutScreenrState extends BasePageState<CheckOutScreen> {
  int value = 0;
  String discount_total;
  String cart_subtotal;
  String taxes;
  String paymentMethod = '';
  String shippingMethod = '';
  int checkedIndex ;
  bool checked = false;
  bool razorchecked = false;
  String total;
  String totalAmount;
  ReviewOrder order;
  UserProvider user;
  CartProvider cart;
  Details model;
  Razorpay _razorpay;
  LoaderProvider loader;
  var userData;
  String shipping_Flat;
  String shipping_Free;
  @override
  void initState() {
    order = ReviewOrder();
    model = Details();
    cart = Provider.of<CartProvider>(context, listen: false);
     cart.getReviewOrder();
     user = Provider.of<UserProvider>(context, listen: false);
    user.getUserInfo();
    loader = Provider.of<LoaderProvider>(context, listen: false);
    _razorpay = new Razorpay();

    super.initState();
  }

  @override
  Widget pageUi(){
    return Scaffold(
      appBar: BaseAppBar(context, "Check Out"),
      body: UiBuilder(),
      bottomNavigationBar: bottomBar(),
    );
  }


  Widget bottomBar(){
   return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, left: 20, bottom: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("₹ ${widget.total}",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 24)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                      onTap: () async{
                        var loader = Provider.of<LoaderProvider>(context, listen: false);
                        loader.setLoadingStatus(true);
                        BasePrefs.init();
                        Details model;
                        if( BasePrefs.getString(USER_MODEL)!=null){
                          var value= BasePrefs.getString(USER_MODEL);
                          printLog("datdatd",value.toString());
                          model = Details.fromJson(jsonDecode(value));
                        }
                        WebApiServices().updateBilling(user_id:model.id.toString(),shipping: model.billing).then((value){
                          if(value.status==1){
                            Details details = value.details;
                            printLog("dtdtdtdt", details.toJson());
                            BasePrefs.setString(USER_MODEL, json.encode(details));
                            changeScreen(context, CheckOutScreen(total:widget.total));
                            printLog("datafat", details.toJson().toString());
                          }
                          // _saveForNextUse(title, model);
                          loader.setLoadingStatus(false);
                          createOrder(userId: model.id, paymentMethod: paymentMethod);
                        });

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 5, bottom: 5, right: 15),
                          child: Text('PLACE ORDER',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget UiBuilder() {
    return Container(
      child:  new Consumer<CartProvider>(builder: (context, cartModel, child){

        if(cartModel.reviewOrder!=null){
          return reviewOrder(cartModel.reviewOrder);
        }else{
          return progressBar(context, orange);
        }
      })
    );
  }
  Widget reviewOrder(ReviewOrder order){
    BasePrefs.init();
    discount_total = getValidString(order.discountTotal);
    cart_subtotal = getValidString(order.cartSubtotal);
    taxes  =order.cartTaxTotal!=null ? getValidString(order.cartTaxTotal.s12IGST) : "";
    total = getValidString(order.cartOrderTotal);
    shipping_Flat= order.shippingMethod!=null && order.shippingMethod.length>0 ? getValidString(order.shippingMethod[0].shippingMethodPrice) : "00.00";
    shipping_Free= order.shippingMethod!=null && order.shippingMethod.length>1 ? getValidString(order.shippingMethod[1].shippingMethodPrice) : "00.00";

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            addressBuilder(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 30, right: 28, bottom: 10),
              child: Container(
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, top: 8, right: 30, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Shipping Methods',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                            order.shippingMethod!=null ? widgetShippingCart(shippingMethod: order.shippingMethod, choosenMethod: order.chosenShippingMethod) : Container(),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 30, right: 28, bottom: 10),
              child: Container(
                  child: Card(
                    elevation: 10,
                    color: Color(0xFFFEDBD0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, top: 8, right: 30, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Order Summary',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text('Subtotal :',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(cart_subtotal.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text('Shipping Charges :',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(getShippingPrice() ,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text('Tax :',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(taxes.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text('Total Discount :',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(discount_total.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Container(
                                height: 0.9,
                                color: Colors.orange,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 70,
                                    child: Text('Total :',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text("₹ $total",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 30, right: 30),
              child: GestureDetector(
                onTap: () {
                  changeScreenReplacement(context, OfferScreen());
                },
                child: Card(
                  elevation: 2,
                  color: Colors.transparent,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: order.cartDiscountCoupon!=null && order.cartDiscountCoupon.length>0 ? green : black,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: SvgPicture.asset(
                                  'assets/icons/ic_coupon.svg',
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  order.cartDiscountCoupon!=null && order.cartDiscountCoupon.length>0 ? "Coupon Applied" : "Apply Promo Code/Voucher",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(
                              order.cartDiscountCoupon!=null && order.cartDiscountCoupon.length>0 ?  Icons.check_circle : Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ),
            paymentGatwayBuilder(order.paymentGateway)
          ],
        ),
      ),
    );
  }
  String getShippingPrice() {
    return value==0 ? shipping_Flat.toString():shipping_Free.toString();
  }

  Widget addressBuilder(){
    BasePrefs.init();
    userData= BasePrefs.getString(USER_MODEL);
    model = userData !=null ? Details.fromJson(jsonDecode(userData)) : new Details();
    return Padding(
      padding: const EdgeInsets.only( top:10, bottom: 10),
      child: GestureDetector(
        onTap: (){
          changeScreen(context, DeliveryScreen(total: widget.total,));
        },
        child:  Container(
          height: 100,
          decoration: BoxDecoration(
            color: grey_200,
            borderRadius: BorderRadius.all(
                Radius.circular(4)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: Card(
                    elevation: 10,
                    shape: CircleBorder(side: BorderSide.none),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: model.avatarUrl !=null ? NetworkImage(
                            model.avatarUrl) : Image.asset(ic_bg_lock) ,
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: RichText(
                    text: TextSpan(
                        text: model.firstName!=null && model.billing.firstName!="" ?
                        model.firstName!=null && model.firstName!=""?
                        "Dear ${model.firstName.toUpperCase()}\n" : "Dear ${model.billing.firstName.toUpperCase()}\n" :
                            "Hi User\n",
                        style: TextStyle(
                            color: Colors.black, fontSize: 18, fontFamily: fontName, fontWeight: medium),
                        children: <TextSpan>[
                          TextSpan(text: "Shipping Address:- ", style: TextStyle(
                                color: Colors.black38, fontSize: 10),),
                          TextSpan(text: model.billing.postcode!=null && model.billing.postcode!="" ?
                          "${model.billing.address1} ${model.billing.address2} ${model.billing.state} (${model.billing.postcode})" :"Address Not Found",
                            style: TextStyle(
                                color: Colors.black38, fontSize: 10),)
                        ]
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:20.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentGatwayBuilder(List<PaymentGateway> gateway){
    return Container(
      padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Methods',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14)),
          ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: gateway.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                checked = index == checkedIndex;
                return GestureDetector(onTap: (){
                  setState(() {
                    razorchecked= false;
                    checkedIndex = index;
                    paymentMethod = gateway[index].gatewayId;
                  });

                },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: orange_50,
                        border:Border.all(color: checked ? orange : orange_50),
                        boxShadow: [
                          BoxShadow(color: checked ? orange : orange_50, spreadRadius: 1)
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              child: Image.asset(ic_money)),
                          Text(gateway[index].gatewayTitle, style: styleProvider(fontWeight: medium, size: 13, color: black),)
                        ],
                      ),
                    ),
                  ),);
              }),
          GestureDetector(
            onTap: (){
              setState(() {
                checked = false;
                checkedIndex = 10;
                razorchecked = true;
                paymentMethod = "razor";
              });
            },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: orange_50,
                    border:Border.all(color: razorchecked ? orange : orange_50),
                    boxShadow: [
                      BoxShadow(color: razorchecked ? orange : orange_50, spreadRadius: 1)
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                          width: 60,
                          child: Image.asset(ic_money)),
                      Text("Razor Pay", style: styleProvider(fontWeight: medium, size: 13, color: black),)
                    ],
                  ),
                ),
              ),
          )
        ],
      ),
    );
  }
  String totalPrice(){
    printLog("getshipp", getShippingPrice());
    double price = getValidDecimalInDouble(discount_total)+getValidDecimalInDouble(taxes)+getValidDecimalInDouble(cart_subtotal)+getValidDecimalInDouble(getShippingPrice());
    return getValidDecimalFormat(price);
  }

  void createOrder({int userId, String paymentMethod, String shippingMethod}) {
    var cart = Provider.of<CartProvider>(context, listen: false);
    if(paymentMethod!=null && paymentMethod!=""){
      cart.getNewOrder(userId: userId, paymentMethod: paymentMethod).then((value){
        OrderModel orderModel =value;
        switch(paymentMethod){
          case "bacs":
            cart.getUpdateOrder(order_id: orderModel.id.toString(), status: "on-hold").then((value){
              if(value){
                thankyouDialog("For Your Orders");
              }else{
                toast("Order Placed");
              }
            });
            break;
          case "cheque":
            cart.getUpdateOrder(order_id: orderModel.id.toString(), status: "processing").then((value){
              if(value){
                toast("Order Placed");
                thankyouDialog("For Your Orders");
              }else{
                toast("Order Placed");
              }
            });
            break;
          case "cod":
            cart.getUpdateOrder(order_id: orderModel.id.toString(), status: "processing").then((value){
              if(value){
                toast("Order ");
                thankyouDialog("For Your Orders");
              }else{
                toast("Order Placed");
              }
            });
            break;
          case "paypal":
            toast(NETWORK_ERROR);
            break;
          case "razor":
            RazorPaymentService razorPaymentService = new RazorPaymentService();
            razorPaymentService.initPaymentGatway(context, orderModel.id.toString());
            printLog("ddsakabj", orderModel.id.toString());
            razorPaymentService.getPayment(context: context, amount: widget.total, name: model.billing.firstName,
                email: model.billing.email,
                mobile: model.billing.phone,
                orderId: orderModel.orderKey);
            break;
          case "paytm":
            toast(NETWORK_ERROR);
            break;
        }
      });
    }else{
      toast(PAY_METHOD_NOT_FOUND);
    }
  }
  void thankyouDialog(String msg){
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder:(context, anim1, anim2){
          return Material(
            type: MaterialType.transparency,
            child:Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 30),
                              child:  GestureDetector(
                                onTap: (){setState(() {
                                  Navigator.pop(context);
                                });},
                                child: Container(
                                    height: 35,
                                    margin: EdgeInsets.zero,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black ,
                                      size: 15,
                                    )),
                              ),
                            ),
                          ],),
                      ),
                      Stack(
                        children: <Widget>[
                          new Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(100)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0),
                                          blurRadius: 6.0
                                      )
                                    ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0.0, 1.0),
                                              blurRadius: 6.0
                                          )
                                        ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(40.0),
                                      child: SvgPicture.asset(ic_likee, color: Colors.white,),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Positioned(
                              bottom: 20,
                              right: 0,
                              left: 120,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:  CircleAvatar(
                                    radius: 15.0,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )
                              ))

                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Text('Thank You', style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 20),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Text(msg, style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 12),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0, left: 20, right:20, bottom: 20),
                        child: customButton(title :"Continue Shopping", onPressed: (){
                         changeScreen(context, MainPageScreen(currentTab: 0,));
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ) ,
          );
        },
        transitionBuilder: (context, anim1, anim2, child){
          return SlideTransition(position: Tween(begin: Offset(0,1), end: Offset(0,0)).animate(anim1),child: child,);
        });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
