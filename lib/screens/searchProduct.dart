import 'dart:async';
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
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/product.dart';

class SearchScreen extends BasePage {
  SearchScreen({Key key}) : super(key: key);
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends BasePageState<SearchScreen> {

  TextEditingController _searchQuary = new TextEditingController();
  Timer _debounce;
  bool loader = false;
  WebApiServices webApiServices;
  ProductsProvider productList;
  int sortByIndex = 0;
  int _page = 1;
  var minValue, maxValue, selectedItemId;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    productList = Provider.of<ProductsProvider>(context, listen: false);
    productList.fetchProducts(_page);

    _searchQuary.addListener(_onSearchChange);
    super.initState();
  }

  _onSearchChange() {
    setState(() {
      loader= true;
    });
    var productList = Provider.of<ProductsProvider>(context, listen: false);
    printLog("datdatdtd", "msg");
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      productList.resetStreams();
      productList.fetchProducts(_page, str_search: _searchQuary.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(100, 100),
        child: searchProvider(),
      ),
      body: Container(
          child: _CustomScrollView(context)),
    );
  }

  Widget _CustomScrollView(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(top: 10, left: 15.0, right: 15),
            child: Column(
              children: [
                _productList(),
              ],
            )
        )
    );
  }

  Widget _productList() {
    return new Consumer<ProductsProvider>(
        builder: (context, productModel, child) {
          if (productModel.allProducts != null &&
              productModel.allProducts.length > 0
          ) {
            return _buildProductList(productModel.allProducts);
          } else {
            if (productModel.loader) {
              return ShimmerList(listType: "Grid",);
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: dataNotFound(),
                ),
              );
            }
          }
        });
  }

  Widget _buildProductList(List<ProductModel> productList) {
    var size = MediaQuery
        .of(context)
        .size;
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
      children: productList.map((ProductModel model) {
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    // This also removes the _printLatestValue listener
    _searchQuary.dispose();
    super.dispose();
  }

  Widget searchProvider() {
    return SafeArea(
      child: Container(
        height:40,
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius:
            BorderRadius.all(Radius.circular(5.0))),
        child: new TextFormField(
          controller: _searchQuary,
          decoration: InputDecoration(
              suffixIcon: Container(
                width: 100,
                  padding: EdgeInsets.all(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Theme(data: ThemeData(

                      ), child: Visibility(
                          visible: loader,
                          child: Padding(padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                              height: 5,
                              width: 5,
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                                backgroundColor: accent_color,),
                            ),)),),
                      SizedBox(width: 10,),
                      SvgPicture.asset('assets/icons/ic_search.svg',
                        height: 10, width: 10,),
                      SizedBox(width: 30,),
                    ],)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: accent_color),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: accent_color),
              ),
              hintText: "search here",
              hintStyle: styleProvider(
                  fontWeight: regular, size: 12, color: Colors.black)
          ),
          keyboardType: TextInputType.emailAddress,
          style: new TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: black),
        ),

      ),);
  }
}
