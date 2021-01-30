import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/homeLayout.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/screens/category.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/productBuilder.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/product.dart';
import 'package:wooapp/widgets/progress_bar.dart';
enum ProductBy { CATEGORY, FEATURED, SELLER, SALE, RATED }
class WidgetCategories extends StatefulWidget{
  HomeLayout homeLayout;
  WidgetCategories({Key key, this.homeLayout}) : super(key: key);
  @override
  _WidgetCategoriesState createState()=>_WidgetCategoriesState();
}
class _WidgetCategoriesState extends State<WidgetCategories>{
  WebApiServices webApiServices;
  int currentTab = 0;
  HomeLayout homeLayout;
  int _page =1;
  int categoryId= 15;
  Timer _time;
  String tagName ="Uncategorized";
  ScrollController _scrollController = new ScrollController();
  double offset = 0.0 ;
  @override
  void initState() {
    super.initState();
    homeLayout = widget.homeLayout;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: pageUi(),
    );
  }

  Widget _categoriesList(){
    return new Consumer<AppProvider>(builder: (context, app, child){
      if(app.getHomeLayout.categories!=null &&
          app.getHomeLayout.categories.length>0
      ){
        return _buildCategoryList(app.getHomeLayout.categories);
      }else{
        return ShimmerList(listType: "Category",);
      }
    });
  }

  Widget _buildCategoryList(List<HomeLayoutCategory> items) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height / 1.32 - kToolbarHeight - 34) / 10;
    final double itemWidth = size.width / 2;
    return Padding(
        padding: EdgeInsets.all(1),
        child:GridView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: (itemWidth / itemHeight),
          ),
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.only(top:2, left: 9, right: 9),
              child: GestureDetector(
                onTap: () {
                  changeScreen(context, ShopView(categoryId: items[index].id,));
                },
                child:Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: currentTab == index ? orange : white,
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(items[index].image !=null ?items[index].image : "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9f5962a5-6eb6-46d4-b538-130e70618576/downshifter-10-running-shoe-CrpbbD.jpg",),
                          Padding(
                            padding: const EdgeInsets.only(left:2.0),
                            child: Text(
                              items[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:
                                  currentTab == index ? white : black,
                                  fontSize: 8),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            );
          },
          itemCount: items.length,
        )
    );
  }

  Widget _topSaleProducts(){
    return new Consumer<AppProvider>(builder: (context, app, child){
      if(app.getHomeLayout.topSeller!=null &&
          app.getHomeLayout.topSeller.length>0){
        return Container(
          child: _topSaleProductBuilder(app.getHomeLayout.topSeller),
        );
      }else{
        return Padding(
          padding: const EdgeInsets.only(top:40.0),
          child: somethingWentWrong(),
        );
      }
      });
  }
  Widget _topSaleProductBuilder(List<ProductModel> productList) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
                onTap: () {
                  changeScreen(
                      context, ProductScreen(productModel: productList[index]));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productModel: productList[index],
                    width: 150,
                  ),
                ));
          }
      ),
    );
  }

  Widget _featuredProduct(){
    return new Consumer<ProductsProvider>(builder: (context, productModel, child){
      if(productModel.allProductsByFeature!=null &&
          productModel.allProductsByFeature.length>0){
        return _featureProductBuilder(productModel.allProductsByFeature);
      }else{if(productModel.loader){
        return ShimmerList(listType: "List",);
      }else{
        return Padding(
          padding: const EdgeInsets.only(top:40.0),
          child: somethingWentWrong(),
        );
      }
      }
    });
  }
  Widget _featureProductBuilder(List<ProductModel> productList){
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
                onTap: () {
                  changeScreen(
                      context, ProductScreen(productModel: productList[index]));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productModel: productList[index],
                      width: 150,
                  ),
                ));
          }
      ),
    );
  }

  Widget _saleProduct(){
    return new Consumer<AppProvider>(builder: (context, app, child){
      if(app.getHomeLayout.saleProducts!=null &&
          app.getHomeLayout.saleProducts.length>0){
        return _saleProductBuilder(app.getHomeLayout.saleProducts);
      }else{
        return Padding(
          padding: const EdgeInsets.only(top:40.0),
          child: somethingWentWrong(),
        );
      }
    });
  }
  Widget _saleProductBuilder(List<ProductModel> productList){
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
                onTap: () {
                  changeScreen(
                      context, ProductScreen(productModel: productList[index]));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productModel: productList[index],
                    width: 150,
                  ),
                ));
          }
      ),
    );
  }

  Widget _topRatedProduct(){
    return new Consumer<AppProvider>(builder: (context, app, child){
      if(app.getHomeLayout.topRatedProducts!=null &&
          app.getHomeLayout.topRatedProducts.length>0){
        return __topRatedProductBuilder(app.getHomeLayout.topRatedProducts);
      }else{
        return Padding(
          padding: const EdgeInsets.only(top:40.0),
          child: somethingWentWrong(),
        );
      }
    });
  }
  Widget __topRatedProductBuilder(List<ProductModel> productList){
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
                onTap: () {
                  changeScreen(
                      context, ProductScreen(productModel: productList[index]));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productModel: productList[index],
                    width: 150,
                  ),
                ));
          }
      ),
    );
  }

  Widget pageUi() {
    return Container(
      color: white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:dp10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    child: Text("All Categories",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                            fontWeight: semiBold,
                            color: black))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        changeScreen(context, CategoriesScreen());
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.0,
                            fontWeight: regular,
                            color: black),
                      ),
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      color: black,
                      size: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
          Visibility(visible: homeLayout.categories!=null,child: Container(
            height: 40,
            child: _buildCategoryList(homeLayout.categories),
          ),),
          Visibility(visible: homeLayout.topSeller!=null,child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      child: Text("Top Sellers",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                              fontWeight: semiBold,
                              color: black))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "See More",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.0,
                            fontWeight: regular,
                            color: black),
                      ),
                      Icon(
                        Icons.arrow_right_alt_rounded,
                        color: black,
                        size: 20,
                      )
                    ],
                  )
                ]),
          ),),
          homeLayout.topSeller!=null && homeLayout.topSeller.length>0 ? Container(
              height: 270,
              child: _topSaleProductBuilder(homeLayout.topSeller)): Container(),

          Visibility(visible: homeLayout.featuredProducts !=null,child:Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Featured",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          fontWeight: semiBold,
                          color: black)),
                  GestureDetector(
                    onTap: (){
                      changeScreen(context, ShopView());
                    },
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "See More",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.0,
                              fontWeight: regular,
                              color: black),
                        ),
                        Icon(
                          Icons.arrow_right_alt_rounded,
                          color: black,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ]),
          ),),
          Visibility(visible: homeLayout.featuredProducts !=null ,child: Container(
            height: 270,
            child: _featureProductBuilder(homeLayout.featuredProducts),
          )),

          Visibility(visible: homeLayout.saleProducts !=null,child:Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      child: Text("Top Sales",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                              fontWeight: semiBold,
                              color: black))),
                  GestureDetector(onTap: (){
                    changeScreen(context, ShopView());
                  },
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "See More",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.0,
                              fontWeight: regular,
                              color: black),
                        ),
                        Icon(
                          Icons.arrow_right_alt_rounded,
                          color: black,
                          size: 20,
                        )
                      ],
                    ),)
                ]),
          ),),
          Visibility(visible: homeLayout.saleProducts !=null ,child: Container(
            height: 270,
            child: _saleProduct(),
          )),

          Visibility(visible: homeLayout.topRatedProducts !=null,child:Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Top Rated",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          fontWeight: semiBold,
                          color: black)),
                  GestureDetector(onTap: (){
                    changeScreen(context, ShopView());
                  },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "See More",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.0,
                              fontWeight: regular,
                              color: black),
                        ),
                        Icon(
                          Icons.arrow_right_alt_rounded,
                          color: black,
                          size: 20,
                        )
                      ],
                    ),)
                ]),
          ),),
          Visibility(visible: homeLayout.topRatedProducts !=null ,child: Container(
            height: 270,
            child: __topRatedProductBuilder(homeLayout.topRatedProducts),
          )),
        ],
      ),
    );
  }
}