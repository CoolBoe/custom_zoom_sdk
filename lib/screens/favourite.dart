import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/product.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/sortBy_Dialog.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key key}) : super(key: key);
  @override
  FavouriteScreenState createState() => FavouriteScreenState();
}

class FavouriteScreenState extends State<FavouriteScreen> {
  int currentTab = 0;
  int sortByIndex = 0;
  ProductsProvider productList;
  int _page =1;
  List<ProductModel> wishList = [];
  @override
  void initState() {
    BasePrefs.init();
    wishListProvider();
    super.initState();
  }

  wishListProvider(){
    // BasePrefs.setString(WISHLIST, "");
    if(BasePrefs.getString(WISHLIST)!=null && BasePrefs.getString(WISHLIST)!=""){
      var value = BasePrefs.getString(WISHLIST);
      wishList= (json.decode(value) as List<dynamic>)
          .map<ProductModel>((item) => ProductModel.fromJson(item))
          .toList();
       }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: BaseAppBar(context, "Wishlist", prefixIcon: Container(), suffixIcon: Container()),
      body: Container(
        color: Theme.of(context).backgroundColor,
          child:  _CustomScrollView()),
    );
  }

  Widget _CustomScrollView() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height / 1.32 - kToolbarHeight - 34) / 2;
    final double itemWidth = size.width / 2;
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverToBoxAdapter(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 9, right: 9),
                      child: Text(
                        wishList!=null && wishList.length>0 ? '${wishList.length} items available' : "",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600),
                      )),
                ],
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.only(top:10, left:15.0, right: 15),
          sliver: SliverToBoxAdapter(
            child: _productList(),),
        )
      ],
    );
  }

  Widget _productList(){
    if(wishList!=null && wishList.length>0){
      return _buildProductList(wishList);
    }else{
      return Container(
        margin: EdgeInsets.symmetric(vertical: 100),
        child: dataNotFound(),
      );
    }
  }

  Widget _buildProductList(List<ProductModel> productList) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height / 1.32 - kToolbarHeight - 15) / 2;
    final double itemWidth = size.width / 2;
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      padding: EdgeInsets.zero,
      childAspectRatio: (itemWidth / 300),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      physics: ClampingScrollPhysics(),
      children:productList.map((ProductModel model){
        return GestureDetector(
            onTap: () {
              changeScreen(
                  context, ProductScreen(productModel: model));
            },
            child: ProductWidget(
              productModel: model,

            ),
            onLongPress: (){
              itemDeleteDialog(model);
              },
          onDoubleTap: (){
            itemDeleteDialog(model);
          },
        );
      }).toList(),
    );
  }
  void itemDeleteDialog(ProductModel model) {
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
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Theme.of(context).bottomAppBarColor,
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
                              child: Text("Sure to delete this Item",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                  )),
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
                                      color: Theme.of(context).accentColor,
                                      size: 25,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            GestureDetector(onTap: (){
                              if(model!=null && wishList.length>0){
                                for(int i=0; i<wishList.length; i++){
                                  if(wishList[i].id==model.id){
                                    wishList.removeAt(i);
                                  }
                                }
                                var data = json.encode(wishList);
                                BasePrefs.setString(WISHLIST, data);
                                var value = BasePrefs.getString(WISHLIST);
                                toast("Item Removed to WishList");
                                setState(() {
                                  wishList = wishList;
                                });
                                Navigator.pop(context);
                              }
                              else{
                                toast("Some thing Went Wrong");
                              }

                            },child:  Padding(
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 35.0,
                                          right: 35,
                                          top: 5,
                                          bottom: 5),
                                      child: Center(
                                        child: Text('Yes',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12)),
                                      ),
                                    ),
                                  ),
                                ))),),
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
                                        color: Theme.of(context).accentColor,
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
                                          child: Text('Not Really',
                                              style: TextStyle(
                                                  color: Theme.of(context).backgroundColor,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ],
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
                   customButton(title: "APPLY",onPressed: (){
                     Navigator.pop(context);
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
