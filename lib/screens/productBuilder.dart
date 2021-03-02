import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
import 'package:wooapp/screens/searchProduct.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/product.dart';
import 'package:wooapp/widgets/progress_bar.dart';
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
  ScrollController _scrollController;
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
      if(widget.categoryId!=null){
        productList.resetStreams();
        printLog("categoryyy", widget.categoryId);
        productList.fetchProducts(_page, category_id: widget.categoryId);
      }else if(widget.productIds!=null){
      }else{
        productList.allProducts.length>0 && productList.allProducts.length!=null ?
       // ignore: unnecessary_statements
       null: productList.fetchProducts(_page);
      }
    super.initState();
     _scrollController = new ScrollController();
     _scrollController.addListener(() {
       printLog("bhkhhjjkh", "msg");
       setState(() {

         //<-----------------------------
         offset = _scrollController.offset;
         // force a refresh so the app bar can be updated
       });
       if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
         productList.setLoadingStatus(LoadMoreStatus.LOADING);
         printLog("pageNumber", "+++");
         productList.fetchProducts(++_page);
       }
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).backgroundColor,
        child: _CustomScrollView(context),
      ),
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
                color: accent_color,
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
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).accentColor,
                )),
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Products",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).accentColor)),
              centerTitle: true,
            ),
            snap: true,
            floating: true,
            pinned: true,
            actions: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(onTap: (){
                    changeScreen(context, SearchScreen());
                  },
                    child: SvgPicture.asset(ic_search, color: Theme.of(context).accentColor,),
                  )
              )
            ]
        ),
        SliverPersistentHeader(
          delegate: MySliverAppBar(expandedHeight: 60, context: context),
          pinned: true,
          floating: false,
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Column(
              children:<Widget>[
                Padding(
                    padding: const EdgeInsets.only(left:15.0, right: 15),
                    child: _productList()),
              ],
            ),
          ),
        )
      ],
    );
  }


  Widget _productList(){
    return new Consumer<ProductsProvider>(builder: (context, productModel, child){
      if(productModel.allProducts!=null &&
          productModel.allProducts.length>0
      ){
        return _buildProductList(productModel.allProducts, productModel.getLoadMoreStatus == LoadMoreStatus.LOADING);
      }else{if(productModel.loader){
        return ShimmerList(listType: "Grid",);
      }else{
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top:40.0),
            child: dataNotFound(),
          ),
        );
      }
      }
    });
  }

  Widget _buildProductList(List<ProductModel> productList, bool isLoadMore) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
      return Container(
        height: MediaQuery.of(context).size.height-220,
        child:  Stack(
          children: [
            Container(
                child: GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              physics: ClampingScrollPhysics(),
              controller: _scrollController,
              childAspectRatio: (itemWidth / 300),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
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
            )),
           new Align(
              alignment: Alignment.center,
               child: Visibility(
               visible: isLoadMore,
               child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                  padding: EdgeInsets.all(10),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.grey[200]
                  ),
                  child:CircularProgressIndicator(
                  strokeWidth: 2,
                  ),

               )))
          ],
        ),
      );
  }


}
class MySliverAppBar  extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  int sortByIndex = 0;
  int currentTab = 0;
  BuildContext context;
  MySliverAppBar ({this.expandedHeight, this.context});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: grey_50,
        height: 60,
        child: filterOptions(),
    );
  }

  /*
   kToolbarHeight = 56.0, you override the max and min extent with the height of a
   normal toolBar plus the height of the tabBar.preferredSize
   so you can fit your row and your tabBar, you give them the same value so it
   shouldn't shrink when scrolling
  */
  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;

  Widget filterOptions(){
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 9, right: 9),
            child: GestureDetector(
              onTap: () {
              CategoryDialog(context);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.zero,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      ic_categories,
                      color:Theme.of(context).accentColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            color:Theme.of(context).accentColor,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9, right: 9),
            child: GestureDetector(
              onTap: () {
                SortByDialog(context);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      ic_sortby,
                      color:Theme.of(context).accentColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "Sort By",
                        style: TextStyle(
                            color:Theme.of(context).accentColor,
                            fontSize: 14),
                      ),
                    )
                  ],
                )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 9, right: 9),
            child: GestureDetector(
              onTap: () {
                filterScreenByDialog(context);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      ic_filter,
                      color:Theme.of(context).accentColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "Filter",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void CategoryDialog(BuildContext context) {
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
  void SortByDialog(BuildContext context) {
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
                    color: Theme.of(context).backgroundColor,
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
                                    color: Theme.of(context).accentColor,
                                    size: 25,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: GestureDetector(
                              onTap: () {

                              },
                              child: Text("Sort By",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: GestureDetector(
                              onTap: () {
                              },
                              child: Container(
                                  height: 35,
                                  margin: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.refresh,
                                    color:Theme.of(context).accentColor,
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

  void filterScreenByDialog(BuildContext context) {
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
