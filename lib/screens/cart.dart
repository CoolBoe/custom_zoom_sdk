import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/mockdata/item_model.dart';
import 'package:wooapp/screens/mainpage.dart';

class CartScreen extends StatefulWidget {

  const CartScreen({Key key}) : super(key: key);
  @override
  CartScreenState createState()=>CartScreenState();

}

class CartScreenState extends State<CartScreen>{
  List<Item> itemList = [
    Item(
        "https://app.tutiixx.com/wp-content/uploads/2019/01/T_6_front.jpg",
        "Women Black top",
        "₹ 450.00",
        "4.5",
        true,
        "21"),
    Item(
        "https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_6_front-600x600.jpg",
        "Women White Top",
        "₹ 250.00",
        "4.5",
        true,
        "0"),
  ];
  Widget _promocode(){
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0,
          left: 30,
          right: 30
      ),
      child: GestureDetector(onTap: (){
        changeScreenReplacement(context, CartScreen());
      },
        child:  Card(
          elevation: 2,
          color: Colors.transparent,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: SvgPicture.asset('assets/icons/ic_coupon.svg', color: Colors.white,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Text("Apply Promo Code/Voucher",
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(right:20.0),
                  child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,size: 20,),
                )
            ]),
          ),
        ),),);
  }
  Widget _CustomScrollView(){

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 50,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Cart",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            centerTitle: true,
          ),
          floating: true,
          leading: GestureDetector(
              onTap: (){
                changeScreenReplacement(context, MainPageScreen());
              },
              child: Icon(
                Icons.arrow_back, color: Colors.black,
              )
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset('assets/icons/ic_search.svg'),
            )
          ],
        ),
        SliverList(delegate: SliverChildListDelegate(
          List.generate(itemList.length, (index) => _itemBuilder(context, index)
          )
        )),
        SliverToBoxAdapter(
          child: _promocode(),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top:0.0, left: 30, right:28, bottom: 10),
          sliver: SliverToBoxAdapter(
              child:Card(
                elevation: 5,
                color: Colors.white,
                child:  SizedBox(
                  width: MediaQuery.of(context).size.width/1.2,
                  child: Padding(
                    padding: const EdgeInsets.only(left:30.0, top: 8, right: 30, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shipping Methods', style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 14)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 70,
                                child: Text('Flat rate :', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:5.0),
                                      child: Text('₹ 50.00', style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Radio(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: 1,
                                        activeColor: Colors.black,
                                        groupValue: 1,
                                        onChanged: (val){
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(

                                child: Text('Free shipping :', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:5.0),
                                      child: Text('₹ 0.00', style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Radio(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: 0,
                                        activeColor: Colors.black,
                                        groupValue: 1,
                                        onChanged: (val){
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0, right:30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Calculate Shipping', style: TextStyle(
                                  color: Colors.orange,
                                  fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top:0.0, left: 30, right:28, bottom: 10),
          sliver: SliverToBoxAdapter(
              child:Card(
                elevation: 10,
                color: Color(0xFFFEDBD0),
                child:  SizedBox(
                  width: MediaQuery.of(context).size.width/1.2,
                  child: Padding(
                    padding: const EdgeInsets.only(left:30.0, top: 8, right: 30, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order Summary', style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 14)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(

                                child: Text('Subtotal :', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text('₹ 1150.00', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text('Shipping Charges :', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text('₹ 50.00', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text('Tax :', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text('₹ 0.00', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text('Total Discount :', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text('₹ 0.00', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5.0,
                              bottom: 5.0
                          ),
                          child: Container(
                            height: 0.9,
                            color: Colors.orange,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 70,
                                child: Text('Total :', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 12)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text('₹ 1200.00', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 12)),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              )
          ),
        ),
        
      ],
    );
  }
  Widget _itemBuilder(BuildContext context, int index ){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.topLeft,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(top:0.0, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 0),
                  child: Image.network(itemList[index].item_image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Container(
                  width: 230,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:5, left: 8, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(itemList[index].item_name, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),),
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
                        padding: const EdgeInsets.only(top:5.0, left: 8, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(itemList[index].price, style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:5.0, left: 8, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 10.0,
                              backgroundColor: Colors.orange[400],
                              child: Icon(
                                Icons.remove,color: Colors.red,
                                size: 10,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0, right:8.0),
                              child: Text('1', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),),
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: RefreshIndicator(
            onRefresh: () async {
              await Future.value({});
            },
            child:  Center(child: _CustomScrollView())),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color:  Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 6.0
                )
              ]
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:10.0, left: 20, bottom: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('₹ 700.00', style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 24)),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:15.0),
                      child: GestureDetector(onTap: (){
                        changeScreenReplacement(context, CartScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left:15.0, top: 5, bottom: 5, right: 15),
                            child:  Text('CHECKOUT', style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 12)),
                          ),
                        ),),
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



}