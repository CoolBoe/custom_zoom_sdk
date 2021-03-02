import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/screens/cart.dart';
import 'package:wooapp/screens/searchProduct.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/ProgressHUD.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/widget_related_products.dart';

class ProductScreen extends StatefulWidget {
  ProductModel productModel;
  ProductScreen({Key key, this.productModel}) : super(key: key);
  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool isApiCallProcess = false;
  WebApiServices _webApiServices;
  WebResponseModel _webResponseModel;
  int sizeIndex = 0;
  Map<dynamic, dynamic> listIndex;
  Map<dynamic, dynamic> variation;
  int variationId;
  bool isAdded = false;
  bool isPine = false;
  @override
  void initState() {
    BasePrefs.init();
    _webApiServices = new WebApiServices();
    _webResponseModel = new WebResponseModel();
    listIndex = new Map<dynamic, dynamic>();
    variation = new Map<dynamic, dynamic>();
    for (var value in widget.productModel.attributes) {
      listIndex[value.name] = 0;
      variation[value.slug] = null;
    }
    super.initState();
  }

  Widget _cartDone() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          new Timer(Duration(microseconds: 200), () {
            changeScreen(context, CartScreen());
          });
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
                "Done",
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

  Widget _CustomScrollView() {
    String catergory = "";
    if (widget.productModel.categories != null) {
      for (int i = 0; i < widget.productModel.categories.length; i++) {
        catergory += "${widget.productModel.categories[i].name},";
      }
    }
    ;
    List<NetworkImage> imgeLisr = List<NetworkImage>();
    for (int i = 0; i < widget.productModel.images.length; i++) {
      imgeLisr.add(NetworkImage(widget.productModel.images[i].src));
    }
    printLog("veriagee", widget.productModel.toJson());
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 50,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          floating: true,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).accentColor,
              )),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  changeScreen(context, SearchScreen());
                },
                child: GestureDetector(
                  onTap: () {
                    BasePrefs.init();
                    List<ProductModel> wishList = [];
                    if (!isAdded) {
                      if (BasePrefs.getString(WISHLIST) != null &&
                          BasePrefs.getString(WISHLIST) != "") {
                        var value = BasePrefs.getString(WISHLIST);
                        wishList = (json.decode(value) as List<dynamic>)
                            .map<ProductModel>(
                                (item) => ProductModel.fromJson(item))
                            .toList();
                        wishList.add(widget.productModel);
                        var data = json.encode(wishList);
                        BasePrefs.setString(WISHLIST, data);
                        printLog("encodedList", wishList.length);
                        setState(() {
                          isAdded = true;
                        });
                        toast("Item added to WishList");
                      } else {
                        wishList.add(widget.productModel);
                        var data = json.encode(wishList);
                        BasePrefs.setString(WISHLIST, data);
                        setState(() {
                          isAdded = true;
                        });
                        toast("Item added to WishList");
                      }
                    } else {
                      toast("Item Already Added");
                    }
                  },
                  child: Icon(
                    isAdded ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).accentColor,
                    size: 20,
                  ),
                ),
              ),
            )
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 300,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(color: white),
                  child: Carousel(
                      boxFit: BoxFit.fill,
                      autoplay: true,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 1000),
                      dotSize: 2.0,
                      dotIncreaseSize: 6.0,
                      dotBgColor: Colors.transparent,
                      dotColor: grey_50,
                      dotPosition: DotPosition.bottomCenter,
                      showIndicator: true,
                      indicatorBgPadding: 6.0,
                      images: imgeLisr),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Card(
              elevation: 3,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.6,
                            child: Text(widget.productModel.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).accentColor)),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Theme.of(context).accentColor,
                                  size: 15,
                                ),
                                Text(
                                    "{" +
                                        widget.productModel.ratingCount
                                            .toString() +
                                        "}",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).accentColor)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: widget.productModel.description != null &&
                                isValidString(widget.productModel.description)
                            ? Text(
                                parse(widget.productModel.description)
                                    .documentElement
                                    .text,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: dp10,
                                  fontWeight: medium,
                                  color: Theme.of(context).accentColor,
                                ))
                            : SizedBox(
                                height: 0,
                              ),
                      ),
                      Container(
                        child: widget.productModel.attributes != null &&
                                widget.productModel.attributes.length > 0 &&
                                widget.productModel.type != Type.SIMPLE
                            ? varibleProvider(widget.productModel.attributes)
                            : SizedBox(
                                height: 0,
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: widget.productModel.type == Type.VARIABLE
              ? EdgeInsets.only(top: 00.0, left: 30, right: 28, bottom: 10)
              : EdgeInsets.only(top: 0.0, left: 30, right: 28, bottom: 10),
          sliver: SliverToBoxAdapter(
              child: Card(
            elevation: 10,
            color: Theme.of(context).canvasColor,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('Specification',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: catergory != null && catergory != "",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            child: Text('Category :',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Container(
                              width: 170,
                              child: Text(catergory,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Visibility(
                        visible: widget.productModel.totalSales != null &&
                            widget.productModel.totalSales != "",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 70,
                              child: Text('Total Sales :',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                  widget.productModel.totalSales.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10)),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Visibility(
                        visible: widget.productModel.sku != null &&
                            widget.productModel.sku != "",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 70,
                              child: Text('SKU :',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(widget.productModel.sku,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10)),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          )),
        ),
        SliverPadding(
          padding:
              const EdgeInsets.only(top: 10.0, left: 10, right: 8, bottom: 10),
          sliver: SliverToBoxAdapter(
              child: WidgetRelatedProducts(
            labelName: "Related Product",
            products: widget.productModel.relatedIds,
          )),
        ),
      ],
    );
  }

  Widget varibleProvider(List<Attribute> attributeList) {
    return Container(
        child: ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: variableBuilder(
                listIndex[attributeList[index].name], attributeList[index]));
      },
      itemCount: attributeList.length,
    ));
  }

  Widget variableBuilder(int itemIndex, Attribute attribute) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(attribute.name.toString(),
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).accentColor)),
        attribute.options != null &&
                attribute.options.length > 0 &&
                attribute.options[0] is String
            ? Container(
                padding: const EdgeInsets.only(left: 10.0),
                width: 200,
                height: 20,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    variation[attribute.slug] = attribute.options[index];
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            listIndex[attribute.name] = index;
                            variation[attribute.slug] =
                                attribute.options[index];
                          });
                        },
                        child: Container(
                          width: 60,
                          decoration: BoxDecoration(
                              color: itemIndex == index
                                  ? accent_color
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: Center(
                            child: Text(
                              attribute.options[index],
                              style: TextStyle(
                                  color: itemIndex == index
                                      ? Colors.white
                                      : Theme.of(context).accentColor,
                                  fontWeight: medium,
                                  fontSize: 12),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ));
                  },
                  itemCount: attribute.options.length,
                ),
              )
            : Container(
                padding: const EdgeInsets.only(left: 10.0),
                width: 200,
                height: 20,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Iterable l = attribute.options;
                    List<OptionClass> model = List<OptionClass>.from(
                        l.map((model) => OptionClass.fromJson(model)));
                    variation[attribute.slug] = model[itemIndex].slug;
                    variationId = model[itemIndex].termId;
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            listIndex[attribute.name] = index;
                            variation[attribute.slug] =
                                model[itemIndex].taxonomy;
                            variationId = model[index].termId;
                          });
                        },
                        child: Container(
                          width: 60,
                          decoration: BoxDecoration(
                              color: itemIndex == index
                                  ? accent_color
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: Center(
                            child: Text(
                              model[index].name,
                              style: TextStyle(
                                  color: itemIndex == index
                                      ? Colors.white
                                      : Theme.of(context).accentColor,
                                  fontWeight: medium,
                                  fontSize: 12),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ));
                  },
                  itemCount: attribute.options.length,
                ),
              )
      ],
    );
  }

  Widget OptionClassBuilder() {}

  @override
  Widget build(BuildContext context) {
    if (BasePrefs.getString(WISHLIST) != null &&
        BasePrefs.getString(WISHLIST) != "") {
      var value = BasePrefs.getString(WISHLIST);
      List<ProductModel> wishList = (json.decode(value) as List<dynamic>)
          .map<ProductModel>((item) => ProductModel.fromJson(item))
          .toList();
      for (int i = 0; i < wishList.length; i++) {
        if (wishList[i].id == widget.productModel.id) {
          isAdded = true;
        }
      }
    }
    return Scaffold(
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: Center(child: _CustomScrollView()),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(color: Theme.of(context).bottomAppBarColor, boxShadow: [
          BoxShadow(
              color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 6.0)
        ]),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.productModel.inStock
                  ? Row(
                      children: [
                        Visibility(
                            visible: widget.productModel.regularPrice !=
                                    widget.productModel.price &&
                                widget.productModel.regularPrice != "",
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                "₹ " + widget.productModel.regularPrice,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Poppins',
                                    fontSize: 20.0,
                                    fontWeight: semiBold,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 2.85),
                              ),
                            )),
                        Text(
                          "₹ " + widget.productModel.price,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      "Out Of Stock",
                      style: TextStyle(
                        color: grey,
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        fontWeight: semiBold,
                      ),
                    ),
              Visibility(
                  visible: widget.productModel.inStock,
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: accent_color),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              VariableProduct vproduct = VariableProduct(
                                  id: widget.productModel.id,
                                  quantity: 1,
                                  variationId: variationId,
                                  variation: json.encode(variation));

                              printLog("dadtadatd", widget.productModel.type);

                              if (widget.productModel.type != Type.VARIABLE) {
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                _webApiServices
                                    .getAddToCart(widget.productModel.id, "1")
                                    .then((value) {
                                  _webResponseModel = value;
                                  if (_webResponseModel.code == "1") {
                                    cartDialog(_webResponseModel.message);
                                  } else {
                                    toast(_webResponseModel.message);
                                  }
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                });
                              } else {
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                printLog("variableProduct", vproduct.toJson());
                                _webApiServices
                                    .getAddToCartVariationProduct(
                                        variableProduct: vproduct)
                                    .then((value) {
                                  _webResponseModel = value;
                                  if (_webResponseModel.code == "1") {
                                    cartDialog(_webResponseModel.message);
                                  } else {
                                    toast(_webResponseModel.message);
                                  }
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5.0, left: 0, right: 0),
                              child: SvgPicture.asset(
                                ic_shoppingcart,
                                color: accent_color,
                              ),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              VariableProduct vproduct = VariableProduct(
                                  id: widget.productModel.id,
                                  quantity: 1,
                                  variationId: variationId,
                                  variation: json.encode(variation));
                              if (widget.productModel.type != Type.VARIABLE) {
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                _webApiServices
                                    .getAddToCart(widget.productModel.id, "1")
                                    .then((value) {
                                  _webResponseModel = value;
                                  if (_webResponseModel.code == "1") {
                                    changeScreen(context, CartScreen());
                                  } else {
                                    toast(_webResponseModel.message);
                                  }
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                });
                              } else {
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                _webApiServices
                                    .getAddToCartVariationProduct(
                                        variableProduct: vproduct)
                                    .then((value) {
                                  _webResponseModel = value;
                                  if (_webResponseModel.code == "1") {
                                    changeScreen(context, CartScreen());
                                  } else {
                                    toast(_webResponseModel.message);
                                  }
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 7, bottom: 7, right: 15),
                              decoration: BoxDecoration(
                                color: accent_color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void cartDialog(String msg) {
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Theme.of(context).backgroundColor.withOpacity(0.5),
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
                  height: 400,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
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
                                      size: 15,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          new Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).highlightColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0),
                                          blurRadius: 6.0)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).highlightColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0.0, 1.0),
                                              blurRadius: 6.0)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(40.0),
                                      child: SvgPicture.asset(
                                        ic_shoppingcart,
                                        color: Theme.of(context).backgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new Positioned(
                              bottom: 20,
                              right: 0,
                              left: 120,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 15.0,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Success!',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          msg,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20, right: 20, bottom: 20),
                        child: _cartDone(),
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
}

class VariableProduct {
  VariableProduct({this.id, this.quantity, this.variationId, this.variation});

  int id;
  int quantity;
  int variationId;
  String variation;
  factory VariableProduct.fromJson(Map<String, dynamic> json) =>
      VariableProduct(
          id: json["id"],
          quantity: json["quantity"],
          variationId: json["variation_id"],
          variation: json["variation"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "variation_id": variationId,
        "variation": variation
      };
}
