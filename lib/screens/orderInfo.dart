import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/order.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/sortBy_Dialog.dart';
import 'package:wooapp/widgets/widgetLineItem.dart';
import 'package:wooapp/widgets/widgetOrderItem.dart';
import 'package:wooapp/widgets/widgetOrderSummary.dart';

class OrderScreen extends StatefulWidget{
  OrderModel orderModel;

   OrderScreen({Key key, this.orderModel}) : super(key: key);
  @override
  OrderScreenState createState() => OrderScreenState();
}
class OrderScreenState extends State<OrderScreen>{
  final int ticks = 1;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(context, "Delivery Information", suffixIcon: Container()),
        body:pageBuilder()
    );
  }

  Widget pageBuilder(){
    printLog("changeScreen", widget.orderModel.shipping.toJson().toString());
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: pink_10,
                  borderRadius:
                  BorderRadius.all(Radius.circular(3))
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(color: accent_color,
                          borderRadius:
                          BorderRadius.all(Radius.circular(5))
                      ),
                      child: Icon(Icons.location_on_outlined, color: white, size: 20,),
                    ),
                    Expanded(child: Text("${widget.orderModel.billing.address1} ${widget.orderModel.billing.address2} ${widget.orderModel.billing.state} (${widget.orderModel.billing.postcode})",
                      style: TextStyle(
                          color: Colors.black, fontSize: 10),))
                  ],
                ),
              ),
            ),
            lineItemBuilder(widget.orderModel.lineItems),
            timeLineTile(),
            widgetOrderSummary(context, subtotal: widget.orderModel.total.toString(), shippingCharge: widget.orderModel.shippingTotal,
            tax: widget.orderModel.totalTax, totalDiscount: widget.orderModel.discountTotal, totalPrice:widget.orderModel.total ),
            bottomBar()
          ],
        ),
      ),
    );
  }

  Widget lineItemBuilder(List<LineItems> lineItems) {
    return ListView.builder(
        itemCount: lineItems.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return widgetLineItem(lineItems: lineItems[index]);
        });
  }

  Widget timeLineTile(){
    String date;
    if(widget.orderModel.dateCreated!=null){
      DateTime tempDate =  DateTime.parse(widget.orderModel.dateCreated);
      date = DateFormat("dd/MM/yyyy").format(tempDate);
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  tick(true),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: line(true),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text('Ordered',style: styleProvider(fontWeight: medium, size: 12, color: black),),
                    new Text(date,style: styleProvider(fontWeight: medium, size: 12, color: Colors.grey),),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.orderModel.orderStatus=="completed" ? tick(true) : tick(false),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:   widget.orderModel.orderStatus=="completed" ? line(true) : line(false),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text('Packed',style: styleProvider(fontWeight: medium, size: 12, color: black),),
                    // new Text(widget.orderModel.dateCreated,style: styleProvider(fontWeight: medium, size: 12, color: Colors.grey),),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.orderModel.orderStatus=="completed" ? tick(true) : tick(false),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:  widget.orderModel.orderStatus=="completed" ? line(true) : line(false),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text('Shipped',style: styleProvider(fontWeight: medium, size: 12, color: black),),
                    // new Text(widget.orderModel.dateCreated,style: styleProvider(fontWeight: medium, size: 12, color: Colors.grey),),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.orderModel.orderStatus=="completed" ? tick(true) : tick(false),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text('Delivery',style: styleProvider(fontWeight: medium, size: 12, color: black),),
                    // new Text(widget.orderModel.dateCreated,style: styleProvider(fontWeight: medium, size: 12, color: Colors.grey),),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding:
                  EdgeInsets.only(left: 00, top: 10, right: 00),
                  child: Container(
                      width: 150,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20,
                                top: 5,
                                bottom: 5),
                            child: Center(
                              child: Text('CANCEL',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12)),
                            ),
                          ),
                        ),
                      ))
              ),
              Padding(
                  padding:
                  EdgeInsets.only(left: 00, top: 10, right: 00),
                  child: Container(
                      width: 150,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: accent_color,
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text('NEED HELP?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                          ),
                        ),
                      ))),
            ],
          )
        ],
      ),
    );
  }

  Widget tick(bool isChecked){
    return isChecked?Icon(Icons.circle,color: accent_color,):Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.grey,);
  }
  Widget line(bool isChecked){
    return isChecked?Container(
      color: accent_color,
      height: 50.0,
      width: 2.0,
    ):Container(
      color: Colors.grey,
      height: 50.0,
      width: 2.0,
    );
  }

  Widget bottomBar(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(ic_money,color: Colors.grey,height: 13, width: 15,),
                    SizedBox(width: 1,),
                    Text("Cash", style: styleProvider(fontWeight: medium, size: 10, color: Colors.grey),)
                  ],
                ),
                Text("₹ ${widget.orderModel.total}", style: styleProvider(fontWeight: medium, size: 10, color: accent_color),)
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(ic_promocode_png,color: Colors.grey,height: 13, width: 15,),
                    SizedBox(width: 1,),
                    Text("Promocode", style: styleProvider(fontWeight: medium, size: 10, color: Colors.grey),)
                  ],
                ),
                Text(widget.orderModel.couponLines !=null && widget.orderModel.couponLines.length>0?
                  widget.orderModel.couponLines[0].code : "No Code Applied",
                  style: styleProvider(fontWeight: medium, size: 10, color: accent_color),)
              ],
            ),
          ),
          GestureDetector(onTap: (){
            moreDialog();
          },
          child: Container(
            child: Column(
              children: [
                Image.asset(ic_more_png,color: Colors.grey,height: 13, width: 35,),
                Text("More", style: styleProvider(fontWeight: medium, size: 10, color: accent_color),)
              ],
            ),
          ),)
        ],
      ),
    );
  }
  void moreDialog() {
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
                              child: Text("More",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.only(right: 30),
                                  height: 35,
                                  margin: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 25,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(onTap: (){

                      },
                        child: Container(
                          padding:
                          EdgeInsets.only(left: 20, top: 10, right: 20),
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: accent_color,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text('SHARE',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14)),
                              ),
                            ),
                          )),),
                      Container(
                          padding: EdgeInsets.only(left: 20, top: 0, right: 20),
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text('MANAGE ORDER',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14)),
                              ),
                            ),
                          )),
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
}