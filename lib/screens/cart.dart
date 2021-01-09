import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:html/parser.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/checkout.dart';
import 'package:wooapp/screens/offer.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/ProgressHUD.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/widget_Shipping_Method.dart';
import 'package:wooapp/models/mockdata/item_model.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/cart.dart';

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
      body: Column(
        children: <Widget>[
          cartData.cartData!=null && cartData.cartData.length>0 ? cartList(cartData.cartData) : Container(),
          _promocode(),
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
                          cartData.shippingMethod!=null ? ShippingCart(cartData.shippingMethod) : Container(),
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
                                  child: Text("₹ "+totalPrice(),
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
        ],
      ),
      bottomNavigationBar: Padding(
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
                Text("₹ "+totalPrice(),
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
                        onTap: () {
                          changeScreen(context, CheckOutScreen(totalAmount: total));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
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
          shipping_Flat= cartData.shippingMethod!=null && cartData.shippingMethod.length>0 ? getValidString(cartData.shippingMethod[0].shippingMethodPrice) : "00.00";
          shipping_Free= cartData.shippingMethod!=null && cartData.shippingMethod.length>1 ? getValidString(cartData.shippingMethod[1].shippingMethodPrice) : "00.00";
         return  pageBuilder();
        } else {
          return progressBar(context, orange);
        }
      }),
    );
  }
  Widget _promocode() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
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
                color: Colors.black,
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
                          "Apply Promo Code/Voucher",
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
                      Icons.arrow_forward_ios_rounded,
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
                                    backgroundColor: Colors.orange[400],
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
                                      cartData[index].quantity,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 10.0,
                                    backgroundColor: Colors.orange[400],
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

  Widget ShippingCart(List<ShippingMethod> shippingMethod){
    return ListView.builder(
        itemCount: shippingMethod.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70,
                  child: Text(shippingMethod[index].shippingMethodName,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 10)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                            parse(shippingMethod[index].shippingMethodPrice)
                                .documentElement
                                .text,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 10)),
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Radio(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          value: index,
                          activeColor: Colors.black,
                          groupValue: value,
                          onChanged: (val) {
                            printLog("onChanged", val);
                            setState(() {
                              value = val;
                            });
                            printLog("onSetChanged", val);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
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
            itemBuilder: (BuildContext context, int index) {
              return WidgetCartItem(cartItem: cartItem[index],);
            }),
      );
  }

  String totalPrice(){
    printLog("getshipp", getShippingPrice());
    double price = getValidDecimalInDouble(discount_total)+getValidDecimalInDouble(taxes)+getValidDecimalInDouble(cart_subtotal)+getValidDecimalInDouble(getShippingPrice());
    return getValidDecimalFormat(price);
  }

}
