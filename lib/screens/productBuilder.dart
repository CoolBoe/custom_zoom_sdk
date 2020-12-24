import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/productList.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/app.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/mockdata/item_model.dart';
import 'package:wooapp/models/mockdata/item_sortby.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:wooapp/screens/category.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/sortBy_ColorPicker.dart';
import 'package:wooapp/widgets/sortBy_Dialog.dart';
import 'package:wooapp/widgets/sortBy_DropMenu.dart';
import 'package:wooapp/widgets/sortBy_SizeBuilder.dart';
class ShopView extends StatefulWidget {

  ShopView({Key key}) : super(key: key);
  @override
  ShopState createState()=>ShopState();

}
class ShopState extends State<ShopView>{

  AppProvider appProvider;
  CategoriesProvider categoriesProvider;
  ProductsProvider productsProvider;
  Map<String, dynamic> priceRange;
  int sortByIndex = 0;

  List<SortBy> sortBy = [
    SortBy('Popularity', 0),
    SortBy('Average Rating', 1),
    SortBy("What's New", 2),
    SortBy("Price: Low to High", 3),
    SortBy("Price: high to low", 4)

  ];
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentTab = 0;
  @override
  void initState() {
  BasePrefs.init();
  AppProvider.initialize();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body:
      Container(
          decoration: BoxDecoration(color: Colors.white),
          child: RefreshIndicator(
              onRefresh: () async {
                await Future.value({});
              },
              child: _CustomScrollView(context))),
    );
  }
  Widget _filterbutton({String category,String sort, String min_price, String max_price, String featured, String on_sale, String brand, String per_page, String page}) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0,
        left: 30,
        right: 30
      ),
      child: GestureDetector(onTap: (){
        final productProvider =  Provider.of<ProductsProvider>(context, listen: false);
        if(sort!=null){
          printLog("sortcheck", sort.toString());
          productProvider.loadProductsBySorting(sort: sort, page: page, per_page: per_page);};
        if(min_price!=null||max_price!=null){
          printLog("pricecheck", min_price.toString());
          productProvider.loadProductsByPrice(sort: sort, page: page, per_page: per_page, min_price: min_price, max_price: max_price);}
        if(on_sale!=null){
          printLog("salecheck", on_sale.toString());
          productProvider.loadProductsByOnSale(sort: sort, page: page, per_page: per_page, on_sale: on_sale);}
        if(brand!=null){
          printLog("brandcheck", brand.toString());
          productProvider.loadProductsByBrand(sort: sort, page: page, per_page: per_page, brand: brand);}
        if(featured!=null){
          printLog("featuredcheck", featured.toString());
          productProvider.loadProductsByFeatured(sort: sort, page: page, per_page: per_page, featured: featured);}
        Navigator.pop(context);
      },
        child:  Container(
          height: 40.0,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            child: new Center(
                child: new Text("APPLY FILTER",
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,),
            ),
          ),
        ),),);
  }
  Widget _sortingbutton(){
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0,
          left: 30,
          right: 30
      ),
      child: GestureDetector(onTap: (){
        BasePrefs.setString(PRODUCT_BY, PRICE);
        productList(context);
        Navigator.pop(context);
      },
        child:  Container(
          height: 40.0,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            child: new Center(
              child: new Text("APPLY",
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,),
            ),
          ),
        ),),);
  }
  Widget _CustomScrollView(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 50,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Products",
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
              // Navigator.of(context).pushNamed(routes.MainPage_Route);
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
        SliverPadding(padding: EdgeInsets.all(10),
          sliver: SliverToBoxAdapter(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 9, right: 9),
                    child:  GestureDetector(
                      onTap: (){setState(() {
                        currentTab=0;
                        changeScreen(context, CategoriesScreen());
                      });},
                      child: Container(
                        height: 35,
                        margin: EdgeInsets.zero,
                        child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10)),
                            color: currentTab == 0
                                ? Colors.orange
                                : Colors.white,
                            elevation: 2,
                            child: Padding(padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    "assets/icons/ic_categories.svg",
                                    color: currentTab == 0
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 5),
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
                              ),)
                        ),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 9, right: 9),
                    child:  GestureDetector(
                      onTap: (){setState(() {
                        currentTab=1;
                        SortByDialog();
                      });},
                      child: Container(
                        height: 35,
                        margin: EdgeInsets.zero,
                        child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10)),
                            color: currentTab == 1
                                ? Colors.orange
                                : Colors.white,
                            elevation: 2,
                            child: Padding(padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    "assets/icons/ic_sortby.svg",
                                    color: currentTab == 1
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 5),
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
                              ),)
                        ),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 9, right: 9),
                    child:  GestureDetector(
                      onTap: (){setState(() {
                        currentTab=2;
                        filterByDialog();
                      });},
                      child: Container(
                        height: 35,
                        margin: EdgeInsets.zero,
                        child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10)),
                            color: currentTab == 2
                                ? Colors.orange
                                : Colors.white,
                            elevation: 2,
                            child: Padding(padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    "assets/icons/ic_filter.svg",
                                    color: currentTab == 2
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 5),
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
                              ),)
                        ),),
                    ),
                  ),
                ],),
            ),
          ),
        ),
        SliverDataBuilder()
      ],
    );
  }
  Widget SliverDataBuilder(){
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height/1.32 - kToolbarHeight - 34) / 2;
    final double itemWidth = size.width / 2;
    SliverGrid grid= new SliverGrid(  delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index){
              return
                GestureDetector(onTap: () async{

                  changeScreen(context, ProductScreen(productModel: productList(context)[index]));
                }, child: Container(
                  height: 200,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 180,
                            child: FadeInImage(
                              placeholder: AssetImage('assets/images/bg_lock.png'),
                              image: NetworkImage(productList(context).length >= 0 ? productList(context)[index].images[0].src : 'assets/images/bg_lock.png'),
                            ),
                          ),
                          new Align(alignment: Alignment.topRight,
                            child:
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset('assets/icons/ic_heart.svg', color: Colors.red,),
                            ),),
                          new Align(alignment: Alignment.topLeft,
                            child:
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:3.0, left: 5, bottom: 3, right: 5),
                                    child: Text(productList(context).length > 0 ?productList(context)[index].ratingCount.toString(): "5",
                                      style: TextStyle( color: Colors.white,  fontFamily: 'Poppins', fontSize: 8.0,
                                        fontWeight: FontWeight.w600,),),
                                  ),
                                )
                            ),)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(productList(context).length >= 0 ? productList(context)[index].name : "Woo App",
                          style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 12.0,
                            fontWeight: FontWeight.w600,),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new RichText(
                            text: new TextSpan(
                              text: '',
                              children: <TextSpan>[
                                new TextSpan(
                                  text:productList(context).length >= 0 ?"₹ "+productList(context)[index].price+"   ": "₹ 200 ",
                                  style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 12.0,
                                    fontWeight: FontWeight.w600,),),
                                new TextSpan(
                                  text:  productList(context).length >= 0 ? "₹"+ productList(context)[index].regularPrice: "₹ 250",
                                  style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 12.0, decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w300,),),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget>[
                          RatingBar(
                              itemSize: 20,
                              initialRating:double.parse(productList(context).length >= 0 ?productList(context)[index].ratingCount.toString(): "5"),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 0),
                              ratingWidget: RatingWidget(
                                  full: new Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  half: new Icon(
                                    Icons.star_half,
                                    color: Colors.amber,
                                  ),
                                  empty: new Icon(
                                    Icons.star_border,
                                    color: Colors.amber,
                                  )
                              ),
                              onRatingUpdate: (rating){
                                print(rating);
                              }
                          ),
                          Text(productList(context).length >= 0 ? " {"+productList(context)[index].averageRating+"}" : "5",
                            style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 12.0,
                              fontWeight: FontWeight.w600,),),
                        ],
                      )
                    ],
                  ),
                ),);
        },childCount: productList(context).length
    ), gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200.0,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: (itemWidth/itemHeight),
    ));
     if(productList(context).length!=null){
       return  SliverPadding(padding: EdgeInsets.all(8),
           sliver:   grid
       );
    }else{
       return SliverToBoxAdapter(
         child: progressBar(context, orange),
       );
     }
  }
  void SortByDialog(){
    printLog('SortByDialog', 'SortByDialog');
  showGeneralDialog(
      barrierLabel: "label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder:(context, anim1, anim2){
        return Material(
          type: MaterialType.transparency,
          child:Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child:  GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 35,
                                margin: EdgeInsets.zero,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black ,
                                  size: 25,
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 9, right: 9),
                          child:  GestureDetector(
                            onTap: (){setState(() {
                            });},
                            child:Text("Sort By",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only( right: 30),
                          child:  GestureDetector(
                            onTap: (){setState(() {
                            });},
                            child: Container(
                                height: 35,
                                margin: EdgeInsets.zero,
                                child: Icon(
                                  Icons.refresh,
                                  color: Colors.black ,
                                  size: 25,
                                )),
                          ),
                        ),
                      ],),
                  ),
                  Container(
                    height: 200,
                    child: Expanded(
                        child: sortByDialog(sortByIndex)
                    ),
                  ),
                  _sortingbutton()
                ],
              ),
            ),
          ) ,
        );
      },
  transitionBuilder: (context, anim1, anim2, child){
        return SlideTransition(position: Tween(begin: Offset(0,1), end: Offset(0,0)).animate(anim1),child: child,);
  });
  }
  void filterByDialog(){
    final app = Provider.of<AppProvider>(context, listen: false);
    final category = Provider.of<CategoriesProvider>(context, listen: false);
   priceRange = app.priceRangeModel;
   PriceRangeModel model= PriceRangeModel.fromJson(priceRange);
   var minValue, maxValue, selectedItemId;
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder:(context, anim1, anim2){
          return Material(
            type: MaterialType.transparency,
            child:Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 450,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child:  GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: 35,
                                  margin: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black ,
                                    size: 25,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child:  GestureDetector(
                              onTap: (){setState(() {
                              });},
                              child:Text("Filter",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only( right: 30),
                            child:  GestureDetector(
                              onTap: (){setState(() {
                              });},
                              child: Container(
                                  height: 35,
                                  margin: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.refresh,
                                    color: Colors.black ,
                                    size: 25,
                                  )),
                            ),
                          ),
                        ],),
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
                      ],),),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0, right: 20, top: 10),
                      child: FlutterSlider(
                          values: [model.min.toDouble(), model.max.toDouble()],
                          handlerHeight: 19,
                          rangeSlider: true,
                          min: model.min.toDouble(),
                          max: model.max.toDouble(),
                          step: FlutterSliderStep(step: 1),
                          hatchMark: FlutterSliderHatchMark(
                            labelsDistanceFromTrackBar: -30,
                            labels:[
                              FlutterSliderHatchMarkLabel(percent: 0, label: Text('min',style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400
                              ),)),
                              FlutterSliderHatchMarkLabel(percent: 100, label: Text('max', style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black
                              ),)),
                            ]
                          ),
                          trackBar: FlutterSliderTrackBar(
                            inactiveTrackBarHeight: 5,
                            inactiveTrackBar: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(width: 1, color: Colors.grey[300])
                            ),
                            activeTrackBarHeight: 5,
                            activeDisabledTrackBarColor: const Color(0xFFEAA4A4),
                            activeTrackBar: BoxDecoration(color: Colors.orange),
                          ),
                          handler: FlutterSliderHandler(
                            decoration: BoxDecoration(),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 1, color: Colors.grey[300]),
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
                                  border: Border.all(width: 1, color: Colors.grey[300]),
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
                            minValue=lowerValue.toString();
                            maxValue = upperValue.toString();
                          },
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: sortByDropMenu(hint: CHOOSE_CATEGORY, categoryList: category.categories,  onChanged: (CategoryModel){
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
                        ],),),
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
                        ],),),
                    sortBySizeBuilder(),
                    _filterbutton(min_price: minValue, max_price: maxValue, category: selectedItemId)
                  ],
                ),
              ),
            ) ,
          );
        },
        transitionBuilder: (context, anim1, anim2, child){
          return SlideTransition(position: Tween(begin: Offset(0,1), end: Offset(0,0)).animate(anim1),child: child,);
        });
  }
}


