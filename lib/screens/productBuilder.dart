import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/app.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/mockdata/item_model.dart';
import 'package:wooapp/models/mockdata/item_sortby.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/models/sort_by.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/category.dart';
import 'package:wooapp/screens/filter.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/product.dart';
import 'package:wooapp/widgets/sortBy_Dialog.dart';
import 'package:wooapp/widgets/sortBy_DropMenu.dart';
import 'package:wooapp/widgets/sortBy_SizeBuilder.dart';

enum ProductBy { CATEGORY, FEATURED, SELLER, SALE, RATED }
class ShopView extends StatefulWidget {

  String categoryId;
  String productIds;
  ShopView({Key key, this.categoryId, this.productIds}) : super(key: key);
  @override
  ShopState createState() => ShopState();
}

class ShopState extends State<ShopView> {

  WebApiServices webApiServices;
  CategoriesProvider categoryList;
  ProductsProvider productList;
  AppProvider app;
  int categoryId= 15;
  Map<String, dynamic> priceRange;
  ScrollController _scrollController = new ScrollController();
  int sortByIndex = 0;
  int _page =1;
  var minValue, maxValue, selectedItemId;
  double offset = 0.0 ;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentTab = 0;
  @override
  void initState() {
    printLog("",ShopView().categoryId);
     categoryList=Provider.of<CategoriesProvider>(context, listen: false);
     categoryList.fetchCategories();
     app =Provider.of<AppProvider>(context, listen: false);
     app.fetchPriceRange();
     productList = Provider.of<ProductsProvider>(context, listen: false);
      if(widget.categoryId!=null){
        productList.resetStreams();
        productList.fetchProducts(_page, category_id: widget.categoryId);
      }else if(widget.productIds!=null){
        productList.resetStreams();
      }else{
        productList.fetchProducts(_page);
      }

     _scrollController.addListener(() {
      setState(() {
        //<-----------------------------
        offset = _scrollController.offset;
        // force a refresh so the app bar can be updated
      });
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        productList.setLoadingState(LoadMoreStatus.LOADING);
        productList.fetchProducts(++_page);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: BaseAppBar(context, "Products", prefixIcon: Container(),),
      body: Container(
         child: _CustomScrollView(context)),
    );
  }

  Widget _sortingbutton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 40.0,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: new Center(
              child: new Text(
                "APPLY",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _CustomScrollView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children:<Widget>[
            filterOptions(),
            Padding(
              padding: const EdgeInsets.only(top:10, left:15.0, right: 15),
              child: _productList()),
          ],
        ),
      )
    );
  }

  Widget filterOptions(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 9, right: 9),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentTab = 0;
                  CategoryDialog();
                });
              },
              child: Container(
                height: 35,
                margin: EdgeInsets.zero,
                child: Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color:
                    currentTab == 0 ? Colors.orange : Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            ic_categories,
                            color: currentTab == 0
                                ? Colors.white
                                : Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Categories",
                              style: TextStyle(
                                  color: currentTab == 0
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 8),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9, right: 9),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentTab = 1;
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
                    color:
                    currentTab == 1 ? Colors.orange : Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            ic_sortby,
                            color: currentTab == 1
                                ? Colors.white
                                : Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Sort By",
                              style: TextStyle(
                                  color: currentTab == 1
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 8),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9, right: 9),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentTab = 2;
                  filterScreenByDialog();
                });
              },
              child: Container(
                height: 35,
                margin: EdgeInsets.zero,
                child: Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color:
                    currentTab == 2 ? Colors.orange : Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            ic_filter,
                            color: currentTab == 2
                                ? Colors.white
                                : Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Filter",
                              style: TextStyle(
                                  color: currentTab == 2
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 8),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _productList(){
    return new Consumer<ProductsProvider>(builder: (context, productModel, child){
      if(productModel.allProducts!=null &&
          productModel.allProducts.length>0
      ){
        return _buildProductList(productModel.allProducts);
      }else{if(productModel.loader){
        return ShimmerList(listType: "Grid",);
      }else{
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top:40.0),
            child: somethingWentWrong(),
          ),
        );
      }
      }
    });
  }

  Widget _buildProductList(List<ProductModel> productList) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height / 1.32 - kToolbarHeight - 15) / 2;
    final double itemWidth = size.width / 2;
      return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          padding: EdgeInsets.zero,
          childAspectRatio: 3 / 4.5,
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

                ));
      }).toList(),
      );
  }

  void CategoryDialog() {
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Container(child: CategoriesScreen());
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
                height: 300,
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
                      padding: EdgeInsets.symmetric(vertical: 10),
                      height: 200,
                      child: sortByDialog(sortByIndex),
                    ),
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

  void filterScreenByDialog() {
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Container(child: FilterScreen());
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
