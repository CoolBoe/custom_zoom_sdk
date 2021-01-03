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
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/product.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/sortBy_ColorPicker.dart';
import 'package:wooapp/widgets/sortBy_Dialog.dart';
import 'package:wooapp/widgets/sortBy_DropMenu.dart';
import 'package:wooapp/widgets/sortBy_SizeBuilder.dart';

class ShopView extends BasePage {
  ShopView({Key key}) : super(key: key);
  @override
  ShopState createState() => ShopState();
}

class ShopState extends BasePageState<ShopView> {

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
     categoryList=Provider.of<CategoriesProvider>(context, listen: false);
     categoryList.fetchCategories();
     app =Provider.of<AppProvider>(context, listen: false);
     app.fetchPriceRange();
     productList = Provider.of<ProductsProvider>(context, listen: false);
     productList.fetchProducts(_page);
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
      body: Container(
          decoration: BoxDecoration(color: Colors.white),
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
    return CustomScrollView(
      slivers: <Widget>[
        _appBar(),
        filterOptions(),
        SliverPadding(
          padding: const EdgeInsets.only(top:10, left:15.0, right: 15),
          sliver: SliverToBoxAdapter(
            child: _productList(),),
        )
      ],
    );
  }
  Widget filterOptions(){
    return SliverPadding(
      padding: EdgeInsets.all(10),
      sliver: SliverToBoxAdapter(
        child: Container(
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
                      filterByDialog();
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
                                "assets/icons/ic_filter.svg",
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
        ),
      ),
    );
  }
  Widget _appBar(){
    return SliverAppBar(
      pinned: true,
      backgroundColor: white,
      expandedHeight: dp50,
      flexibleSpace: FlexibleSpaceBar(
        title: Text("Products",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: medium,
                color: black)),
        centerTitle: true,
      ),
      floating: true,
      leading: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(routes.MainPage_Route);
          },
          child: Icon(
            Icons.arrow_back,
            color: black,
          )),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(ic_search),
        )
      ],
    );
  }
  Widget _productList(){
    return new Consumer<ProductsProvider>(builder: (context, productModel, child){
      if(productModel.allProducts!=null &&
          productModel.allProducts.length>0
      ){
        return _buildProductList(productModel.allProducts);
      }else{
        return progressBar(context, orange);
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
          childAspectRatio: (itemWidth / itemHeight),
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
                    _sortingbutton()
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
  void filterByDialog() {
    var model = app.priceRange;

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
                height: 450,
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
                              child: Text("Filter",
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
                    Padding(
                      padding: EdgeInsets.only(left: 30, top: 10, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Price Range",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                      child: FlutterSlider(
                        values: [model.min.toDouble(), model.max.toDouble()],
                        handlerHeight: 19,
                        rangeSlider: true,
                        min: model.min.toDouble(),
                        max: model.max.toDouble(),
                        step: FlutterSliderStep(step: 1),
                        hatchMark: FlutterSliderHatchMark(
                            labelsDistanceFromTrackBar: -30,
                            labels: [
                              FlutterSliderHatchMarkLabel(
                                  percent: 0,
                                  label: Text(
                                    'min',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400),
                                  )),
                              FlutterSliderHatchMarkLabel(
                                  percent: 100,
                                  label: Text(
                                    'max',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  )),
                            ]),
                        trackBar: FlutterSliderTrackBar(
                          inactiveTrackBarHeight: 5,
                          inactiveTrackBar: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                  width: 1, color: Colors.grey[300])),
                          activeTrackBarHeight: 5,
                          activeDisabledTrackBarColor: const Color(0xFFEAA4A4),
                          activeTrackBar: BoxDecoration(color: Colors.orange),
                        ),
                        handler: FlutterSliderHandler(
                          decoration: BoxDecoration(),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(5),
                            child: Container(
                              height: 10,
                              width: 10,
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                        rightHandler: FlutterSliderHandler(
                          decoration: BoxDecoration(),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(5),
                            child: Container(
                              height: 10,
                              width: 10,
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                        onDragging: (handlerIndex, lowerValue, upperValue) {
                          minValue = lowerValue.toString();
                          maxValue = upperValue.toString();
                          printLog("maxvalue", maxValue);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: sortByDropMenu(
                          hint: CHOOSE_CATEGORY,
                          categoryList: categoryList.allCategories,
                          onChanged: (CategoryModel) {
                            selectedItemId = CategoryModel.id;
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, top: 8, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Colors",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    sortByColorPicker(),
                    Padding(
                      padding: EdgeInsets.only(left: 30, top: 8, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Sizes",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    sortBySizeBuilder(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
                      child: GestureDetector(
                        onTap: () {
                          productList.resetStreams();
                          productList.setLoadingState(LoadMoreStatus.INITIAL);
                          productList.fetchProducts(_page, category_id:selectedItemId.toString(),min_price: minValue, max_price: maxValue );
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
                                "APPLY FILTER",
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
                    )
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
