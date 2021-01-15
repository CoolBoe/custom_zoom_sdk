import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/order.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/sortBy_Dialog.dart';
import 'package:wooapp/widgets/widgetOrderItem.dart';

class OrderScreen extends BasePage{
  OrderScreen({Key key}) : super(key: key);
  @override
  OrderScreenState createState() => OrderScreenState();
}
class OrderScreenState extends BasePageState<OrderScreen>{
  int sortByIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
        appBar: BaseAppBar(context, "My Order", suffixIcon: Container()),
        body:pageBuilder()
    );
  }

  Widget pageBuilder(){
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(
                        color: grey_400, width: 1.0),
                    borderRadius:
                    BorderRadius.all(Radius.circular(dp10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        ic_search,
                        color: grey_400,
                      ),
                      SizedBox(width: 10),
                      Expanded(child:Padding(
                        padding: const EdgeInsets.only(top:5.0),
                        child: TextFormField(
                          cursorColor: orange,
                          decoration: InputDecoration(
                              hintText: "Search For Orders here",
                              hintStyle:styleProvider(fontWeight: regular, size: dp10, color: grey_400) ,
                              border: InputBorder.none),
                          textAlignVertical: TextAlignVertical.bottom,
                          style: styleProvider(fontWeight: regular, size: dp15, color: black),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9, right: 9),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      SortByDialog();
                    });
                  },
                  child: Container(
                    height: 35,
                    margin: EdgeInsets.zero,
                    child: Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: grey_200,
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left:25, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                ic_filter,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Filter",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              )
            ],
          ),
          OrderItem()
        ],
      ),
    );
  }

  Widget orderList(){
    return new Consumer<CartProvider>(builder: (context, order, child){
      if(order.orderList!=null &&
          order.orderList.length>0
      ){
        return OrderItem();
      }else{
        return progressBar(context, orange);
      }
    });
  }

  Widget buildOrderList(List<OrderModel> cartList) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height / 1.32 - kToolbarHeight - 15) / 2;
    final double itemWidth = size.width / 2;
    return ListView.builder(
        itemCount: cartList.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container();
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
                                setState(() {});
                              },
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