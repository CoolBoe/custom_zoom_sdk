import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:html/parser.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/checkout.dart';
import 'package:wooapp/screens/login.dart';
import 'package:wooapp/screens/offer.dart';
import 'package:wooapp/screens/registration.dart';
import 'package:wooapp/screens/splesh.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/ProgressHUD.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/widgetOrderSummary.dart';
import 'package:wooapp/widgets/widgetShippingCart.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/cart.dart';
import 'package:wooapp/widgets/widget_oops.dart';

class CartScreen extends BasePage {
  CartScreen({Key key}) : super(key: key);
  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends BasePageState<CartScreen> {
  CartModel cartData = CartModel();
  int value = 0;
  String discount_total;
  String cart_subtotal;
  String taxes;
  String total;
  String totalAmount;
  String shipping_Flat;
  Timer _timer;
  String shipping_Free;
  @override
  void initState() {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.getCartData();
    super.initState();
  }

  @override
  Widget pageUi() {
    return CartProducts();
  }
  Widget pageBuilder(){

    return Scaffold(
      appBar:BaseAppBar(context, "Cart"),
      body: Container(
        color: Theme.of(context).backgroundColor,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              cartData.cartData!=null && cartData.cartData.length>0 ? cartList(cartData.cartData) : Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                    padding: EdgeInsets.all(0),
                    child: popupBuilder(ic_oops_png, "Cart is Empty")),
              ),
              _promocode(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 30, right: 28, bottom: 10),
                child: Container(
                    child: Card(
                      elevation: 5,
                      color: Theme.of(context).backgroundColor,
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
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                              cartData.shippingMethod!=null ? widgetShippingCart(shippingMethod: cartData.shippingMethod, choosenMethod: cartData.chosenShippingMethod) : Container(),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
              Container(
                  padding: const EdgeInsets.only(
                      top: 0.0, left: 30, right: 28, bottom: 10),
                  child: widgetOrderSummary(context, subtotal:cart_subtotal!=null ? cart_subtotal.toString() : "0.00",
                      shippingCharge: getShippingPrice()!=null ? getShippingPrice():"0.00",
                      tax: taxes.toString()!=null ? taxes.toString():"0.00",
                      totalDiscount: discount_total.toString()!=null?discount_total.toString():"0.00",
                      totalPrice: total!=null ? total: "₹ 0.00"
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Container(
        color: Theme.of(context).backgroundColor,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: Theme.of(context).bottomAppBarColor,
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
                Text(total!=null ? "$total": "₹ 0.00",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 24)),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Visibility(visible:cartData.cartData!=null && cartData.cartData.length>0,
                        child: GestureDetector(
                          onTap: () {
                            BasePrefs.init();
                            if(BasePrefs.getString(USER_MODEL)!=null){
                              changeScreen(context, CheckOutScreen(total: total));
                            }else{
                              changeScreen(context, SpleshScreen());
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: accent_color,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 5, bottom: 5, right: 15),
                              child: Text('CHECKOUT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                            ),
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
      ),
    );
  }

  Widget CartProducts() {
    return Container(decoration: BoxDecoration(color: Colors.white),
      child: new Consumer<CartProvider>(builder: (context, cartModel, child) {
        if (cartModel.getCart != null) {
          cartData = cartModel.getCart;
          discount_total = getValidString(cartData.discountTotal);
          cart_subtotal = getValidString(cartData.cartSubtotal);
          taxes  = getValidString(cartData.taxes);
          total = getValidString(cartData.total);
          printLog("jhkjhjkhkj", total);
          shipping_Flat= cartData.shippingMethod!=null && cartData.shippingMethod.length>0 ? getValidString(cartData.shippingMethod[0].shippingMethodPrice) : "00.00";
          shipping_Free= cartData.shippingMethod!=null && cartData.shippingMethod.length>1 ? getValidString(cartData.shippingMethod[1].shippingMethodPrice) : "00.00";
         return  pageBuilder();
        } else {
          return progressBar(context, accent_color);
        }
      }),
    );
  }
  Widget _promocode() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
      child: GestureDetector(
        onTap: () {
          changeScreenReplacement(context, OfferScreen(list: cartData.coupon,));

        },
        child: Card(
          elevation: 2,
          color: Colors.transparent,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: cartData.coupon!=null && cartData.coupon.length>0 ? green : black,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: SvgPicture.asset(
                          ic_coupon,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          cartData.coupon!=null && cartData.coupon.length>0 ? "Coupon Applied" : "Apply Promo Code/Voucher",
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
                     cartData.coupon!=null && cartData.coupon.length>0 ?  Icons.check_circle : Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Widget CartList(List<CartDatum> cartData) {
    return ListView.builder(
        itemCount: cartData.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(color: grey_50),
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 0),
                        child: Image.network(cartData[index].image),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: 180,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 8, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    cartData[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins'),
                                  ),
                                  CircleAvatar(
                                    radius: 10.0,
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, left: 8, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    parse(cartData[index].price)
                                        .documentElement
                                        .text,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, left: 8, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 10.0,
                                    backgroundColor: accent_color,
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.red,
                                      size: 10,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text(
                                      cartData[index].quantity.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 10.0,
                                    backgroundColor: accent_color,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.red,
                                      size: 10,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void calculateShippingDialog(){
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text("Calculate Shipping",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                    height: 35,
                                    margin: EdgeInsets.zero,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 25,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  const EdgeInsets.only(top: 20),
                        child: Container(
                          height: 40,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[50]
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
            child: child,
          );
        });
  }

  String getShippingPrice() {
    return value==0 ? shipping_Flat.toString():shipping_Free.toString();
  }
  Widget cartList(List<CartDatum> cartItem) {
      return Container(
        child: ListView.builder(
            itemCount: cartItem.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return WidgetCartItem(cartItem: cartItem[index],);
            }),
      );
  }

}
