import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/order.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/orderInfo.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/sortBy_Dialog.dart';
import 'package:wooapp/widgets/widgetOrderItem.dart';

class OrderHistory extends BasePage{
  OrderHistory({Key key}) : super(key: key);
  @override
  OrderHistoryState createState() => OrderHistoryState();
}
class OrderHistoryState extends BasePageState<OrderHistory>{
  int sortByIndex = 0;
  @override
  void initState() {
      BasePrefs.init();
      if(BasePrefs.getString(USER_MODEL)!=null){
        var value= BasePrefs.getString(USER_MODEL);
        Details  model = Details.fromJson(jsonDecode(value));
        var order =Provider.of<CartProvider>(context, listen: false);
        order.getOrderList(id: model.id.toString());
      }

    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
        appBar: BaseAppBar(context, "My Order", suffixIcon: Container()),
        body:Container(
          color: Theme.of(context).backgroundColor,
          height: MediaQuery.of(context).size.height,
          child: pageBuilder(),
        )
    );
  }

  Widget pageBuilder(){
    return SingleChildScrollView(
      child: Container(

        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: orderList())
          ],
        ),
      ),
    );
  }

  Widget orderList(){
    return new Consumer<CartProvider>(builder: (context, order, child){
      if(order.orderSummary!=null && order.orderSummary.data.length>0) {
        printLog("datdatdt",order.orderSummary.data);
        return buildOrderList(order.orderSummary.data);
      }else if (order.loader){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
            height: 1000,child: ShimmerList(listType: "Order",));
      }else{
        return Container(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: dataNotFound());
      }
    });
  }

  Widget buildOrderList(List<OrderModel> orderList) {
    printLog("changeScreen", orderList);
    return ListView.builder(
        itemCount: orderList.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(onTap: (){
            changeScreen(context, OrderScreen(orderModel: orderList[index]));
          },
          child: widgetOrderItem(orderItem: orderList[index],));
        });
  }

  void SortByDialog() {
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
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
                          Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: Text("Sort By",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {});},
                              child: Container(
                                  height: 35,
                                  margin: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.refresh,
                                    color: Colors.black,
                                    size: 25,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      child: sortByDialog(sortByIndex),
                    ),
                    customButton(onPressed: (){

                    })
                  ],
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