import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:wooapp/screens/category.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:wooapp/services/product.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/product.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class WidgetCategories extends StatefulWidget{
  @override
  _WidgetCategoriesState createState()=>_WidgetCategoriesState();
}
class _WidgetCategoriesState extends State<WidgetCategories>{
  WebApiServices webApiServices;
  int currentTab = 0;
  int _page =1;
  int categoryId= 15;
  String tagName ="Uncategorized";
  ScrollController _scrollController = new ScrollController();
  double offset = 0.0 ;
  @override
  void initState() {
    var categoryList=Provider.of<CategoriesProvider>(context, listen: false);
    categoryList.fetchCategories();
    var productList = Provider.of<ProductsProvider>(context, listen: false);
    productList.fetchProducts(_page);
    productList.fetchProductByFeatured(_page, featured: true);

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:dp10, left: dp30, right: dp30),
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
                              fontWeight: FontWeight.w500,
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
            Container(
              height: 40,
              child:_categoriesList(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          child: Text(tagName,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: black))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "See More",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
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
              ),
            ),
            Container(
                height: 270,
                child: _productsByCategory()),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                            child: Text("Featured",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
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
                                  fontWeight: FontWeight.w500,
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
                ),
            ),
            Container(
                height: 270,
                child: _productByFeatured(),
            )
          ],
        ),
      ),
    );
  }
  Widget _categoriesList(){
    return new Consumer<CategoriesProvider>(builder: (context, categoryModel, child){
      if(categoryModel.allCategories!=null &&
      categoryModel.allCategories.length>0
      ){
        return _buildCategoryList(categoryModel.allCategories);
      }else{
        return progressBar(context, orange);
      }
    });
  }
  Widget _buildCategoryList(List<CategoryModel> items) {
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
                  setState(() {
                    tagName = items[index].name;
                    currentTab = index;
                    _page = 1;
                    categoryId = items[index].id;
                  });
                  var productList = Provider.of<ProductsProvider>(context, listen: false);
                  productList.resetStreams();
                  productList.setLoadingState(LoadMoreStatus.INITIAL);
                  productList.fetchProducts(_page, category_id: categoryId.toString());

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
                          Image.network(items[index].image !=null ?items[index].image.src : "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9f5962a5-6eb6-46d4-b538-130e70618576/downshifter-10-running-shoe-CrpbbD.jpg",),
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
          itemCount: 4,
        )
    );
  }

  Widget _productsByCategory(){
    return new Consumer<ProductsProvider>(builder: (context, productModel, child){
      if(productModel.allProducts!=null &&
          productModel.allProducts.length>0){
        return _productsByCategoryBuilder(productModel.allProducts);
      }else{
        return progressBar(context, orange);
      }
    });
  }
  Widget _productsByCategoryBuilder(List<ProductModel> productList) {
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

  Widget _productByFeatured(){
    return new Consumer<ProductsProvider>(builder: (context, productModel, child){
      if(productModel.allProductsByFeature!=null &&
          productModel.allProductsByFeature.length>0){
        return _productByFeaturedBuilder(productModel.allProductsByFeature);
      }else{
        return progressBar(context, orange);
      }
    });
  }
  Widget _productByFeaturedBuilder(List<ProductModel> productList){
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
}