import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/screens/category.dart';
import 'package:wooapp/screens/productBuilder.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/product.dart';

class MokeHomeLayout extends StatefulWidget {
  @override
  _MokeHomeLayoutState createState() => _MokeHomeLayoutState();
}

class _MokeHomeLayoutState extends State<MokeHomeLayout> {
  WebApiServices webApiServices;
  int currentTab = 0;
  int _page =1;
  int categoryId= 15;
  String tagName ="Uncategorized";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var categoryList=Provider.of<CategoriesProvider>(context, listen: false);
    categoryList.fetchCategories();
    var productList = Provider.of<ProductsProvider>(context, listen: false);
    productList.fetchProducts(_page);
    productList.fetchProductByFeatured(_page, featured: true);
    productList.fetchProductBySale(_page, sale: true);

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            bannerSlider(),
            Container(
              padding: const EdgeInsets.only(top:dp10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      child: Text("All Categories",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
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
            _categoriesList(),
            Container(
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
            ),
            _featuredProduct(),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Top Sale",
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
            ),
            _saleProduct(),
          ],
        ),
      ),
    );
  }
  Widget _categoriesList(){
    return new Consumer<CategoriesProvider>(builder: (context, category, child){
      if(category.categories!=null &&
          category.categories.length>0
      ){
        return _buildCategoryList(category.categories);
      }else{
        return ShimmerList(listType: "Category",);
      }
    });
  }

  Widget _buildCategoryList(List<CategoryModel> items) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height / 1.32 - kToolbarHeight ) / 3.9;
    final double itemWidth = size.width / 2;
    return Container(
       margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(1),
        child:GridView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: (itemWidth / 200),
          ),
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.only(top:2, left: 1, right: 1),
              child: GestureDetector(
                onTap: () {
                  changeScreen(context, ShopView(categoryId: items[index].id.toString(),));
                },
                child:Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 1,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height:60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight: Radius.circular(10)),
                              image: DecorationImage(
                                  image: NetworkImage(items[index].image!=null ? items[index].image.src : CategoryThumbnailUrl, ), fit: BoxFit.contain
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Center(
                            child: Text(items[index].name,
                                maxLines: 1,
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins')),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount:4,
        )
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
          child: Container(),
        );
      }
      }
    });
  }
  Widget _featureProductBuilder(List<ProductModel> productList){
    return Container(
      height: 290,
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
      height: 290,
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
  bannerSlider(){
    return  Container(
      padding: const EdgeInsets.all(0.0),
      height: 200,
      child:  Center(
        child: Carousel(
          boxFit: BoxFit.contain,
          autoplay: true,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          dotSize: 0.0,
          dotIncreaseSize: 6.0,
          dotBgColor: transparent,
          dotColor: grey,
          dotPosition: DotPosition.bottomCenter,
          showIndicator: true,
          indicatorBgPadding: 6.0,
          images: [
            NetworkImage(
                BannerThumbnailUrl),
          ],
        ),
      ),
    );
  }
}
