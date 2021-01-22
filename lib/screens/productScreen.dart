import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/models/mockdata/item_colorpicker.dart';
import 'package:wooapp/models/mockdata/item_sortby.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/models/sort_by.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:wooapp/screens/cart.dart';
import 'package:wooapp/screens/searchProduct.dart';
import 'package:wooapp/widgets/ProgressHUD.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/widgetVariableProduct.dart';
import 'package:wooapp/widgets/widget_related_products.dart';

class ProductScreen extends StatefulWidget {

  ProductModel productModel;
  ProductScreen({Key key, this.productModel}) : super(key: key);
  @override
  ProductScreenState createState()=>ProductScreenState();

}

class ProductScreenState extends State<ProductScreen>{
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool isApiCallProcess = false;
  WebApiServices _webApiServices;
  WebResponseModel _webResponseModel;
  int colorIndex = 0;
  int sizeIndex = 0;
  int logoIndex = 0;
  int variationId ;
  Variation variation;
  bool isAdded = false;
  @override
  void initState() {
    BasePrefs.init();
   _webApiServices = new WebApiServices();
   _webResponseModel = new WebResponseModel();
   variation = new Variation();

    super.initState();
  }
  Widget _cartDone(){
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0,
          left: 30,
          right: 30
      ),
      child: GestureDetector(onTap: (){
        Navigator.pop(context);
       new Timer(Duration(microseconds: 200), (){
         changeScreen(context, CartScreen());
       });
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
              child: new Text("Done",
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,),
            ),
          ),
        ),),);
  }
  Widget _CustomScrollView(){
    String catergory = "Uncategorized";
    String colorType = "";
    if(widget.productModel.categories!=null){
      catergory= widget.productModel.categories[0].name;
    };
    List<NetworkImage> imgeLisr  = List<NetworkImage>();
    for(int i=0; i<widget.productModel.images.length; i++){
      imgeLisr.add(NetworkImage(widget.productModel.images[i].src));
    }
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 50,
          backgroundColor: grey_200,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.productModel.name,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),

          ),
          floating: true,
          leading: GestureDetector(
              onTap: (){
              Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back, color: Colors.black,
              )
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(onTap: (){
                changeScreen(context, SearchScreen());
              },
              child: SvgPicture.asset(ic_search),),
            )
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 400,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  height: 300,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey[200]
                    ),
                    child:Carousel(
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
                        images:imgeLisr
                    ),
                  ),
                ),
                Positioned(
                   top: 240,
                    left: MediaQuery.of(context).size.width/13,
                    child: Card(
                      elevation: 3,
                      child:  SizedBox(
                        height:widget.productModel.type == Type.VARIABLE  ? 170: 145,
                        width: MediaQuery.of(context).size.width/1.2,
                        child: Padding(
                          padding: const EdgeInsets.only(left:30.0, top: 8, right: 8, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(onTap: (){
                                    printLog("ftyftftf", "bjbug");
                                  },
                                    child: Text(widget.productModel.name,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),),
                                  Padding(
                                    padding: EdgeInsets.only(right: 30),
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        GestureDetector(onTap: (){
                                          BasePrefs.init();
                                          List<ProductModel> wishList = [];
                                          if(!isAdded){
                                            if(BasePrefs.getString(WISHLIST)!=null && BasePrefs.getString(WISHLIST)!=""){
                                              var value = BasePrefs.getString(WISHLIST);
                                              wishList= (json.decode(value) as List<dynamic>)
                                                  .map<ProductModel>((item) => ProductModel.fromJson(item))
                                                  .toList();
                                              wishList.add(widget.productModel);
                                              var data = json.encode(wishList);
                                              BasePrefs.setString(WISHLIST, data);
                                              printLog("encodedList", wishList.length);
                                              setState(() {
                                                isAdded = true;
                                              });
                                              toast("Item added to WishList");
                                            }
                                            else{
                                              wishList.add(widget.productModel);
                                              var data = json.encode(wishList);
                                              BasePrefs.setString(WISHLIST, data);
                                              setState(() {
                                                isAdded = true;
                                              });
                                              toast("Item added to WishList");
                                            }
                                          }else{
                                            toast("Item Already Added");
                                          }
                                        },
                                        child: Icon( isAdded ? Icons.favorite: Icons.favorite_border,
                                          color: Colors.orange,size: 20,),),
                                        Icon( Icons.star, color: Colors.orange,size: 20,),
                                        Text("{"+ widget.productModel.ratingCount.toString()+ "}",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ],),
                              SizedBox(
                                height: widget.productModel.type == Type.VARIABLE  ? 10: 20,
                              ),
                              Text(parse(widget.productModel.description).documentElement.text,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: dp10,
                                    fontWeight: medium,
                                    color: black,
                                  )),
                              GestureDetector(
                                onTap: (){

                                  printLog("ftyftftf", "bjbug");
                                },
                                child: varibleProvider(widget.productModel.attributes),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: widget.productModel.type == Type.VARIABLE  ? EdgeInsets.only(top:20.0, left: 30, right:28, bottom: 10) :
          EdgeInsets.only(top:0.0, left: 30, right:28, bottom: 10),
          sliver: SliverToBoxAdapter(
              child:Card(
                elevation: 10,
                color: Color(0xFFFEDBD0),
                child:  SizedBox(
                  width: MediaQuery.of(context).size.width/1.2,
                  child: Padding(
                    padding: const EdgeInsets.only(left:30.0, top: 8, right: 30, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Specification', style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 12)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                child: Text('Category :', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text(catergory, style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                child: Text('Total Sales :', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text(widget.productModel.totalSales.toString(), style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                child: Text('SKU :', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text(widget.productModel.sku, style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                child: Text('Color :', style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text(colorType, style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 10)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top:10.0, left: 10, right:8, bottom: 10),
          sliver: SliverToBoxAdapter(
              child: WidgetRelatedProducts(labelName: "Related Product", products: widget.productModel.relatedIds,)
          ),
        ),
      ],
    );
  }
  Widget varibleProvider(List<Attribute>attributeList ){
    return  Container(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index){
            return  Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: variableBuilder(attributeList[index])
            );
          }, itemCount:attributeList.length,)
    );
  }
  Widget variableBuilder(Attribute attribute){

    switch (attribute.name){
      case Name.COLOR:
        Iterable l = attribute.options;
        List<OptionClass> model = List<OptionClass>.from(l.map((model)=> OptionClass.fromJson(model)));
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Color :",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Container(
                width: 200,
                height: 20,
                child:  ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    variationId = model[colorIndex].termId;
                    this.variation.paColor= model[colorIndex].slug;
                    return Padding(
                      padding: const EdgeInsets.only(left:8.0, ),
                      child: GestureDetector(onTap: (){
                        setState(() {
                          colorIndex= index;
                          this.variation.paColor= model[0].slug;
                          variationId = model[index].termId;
                        });
                      },
                          child:  Container(
                            width: 50,
                            decoration: BoxDecoration(
                                color:  colorIndex==index ? Colors.orange : Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5.0))
                            ),
                            child: Center(
                              child: Text(
                                model[index].name, style: TextStyle(color:  colorIndex==index ?  Colors.white: Colors.black, fontWeight: medium, fontSize: 12), textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )),
                    );
                  },itemCount: attribute.options.length,
                ),
              ),
            )
          ],
        );
        break;
      case Name.LOGO:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Logo :",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Container(
                width: 200,
                height: 20,
                child:  ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    this.variation.logo= attribute.options[logoIndex];
                    return GestureDetector(onTap: (){
                      setState(() {
                        logoIndex= index;
                        this.variation.logo= attribute.options[index];
                      });
                    },
                        child:  Container(
                          width: 50,
                          decoration: BoxDecoration(
                              color:  logoIndex==index ? Colors.orange : Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                          child: Center(
                            child: Text(
                              attribute.options[index], style: TextStyle(color:  logoIndex==index ?  Colors.white: Colors.black, fontWeight: medium, fontSize: 12), textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ));
                  },itemCount: attribute.options.length,
                ),
              ),
            )
          ],
        );
        break;
      case Name.SIZE:
        Iterable l = attribute.options;
        List<OptionClass> model = List<OptionClass>.from(l.map((model)=> OptionClass.fromJson(model)));
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Size :",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Container(
                width: 200,
                height: 20,
                child:  ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    this.variation.paSize= model[sizeIndex].slug;
                    return GestureDetector(onTap: (){
                      setState(() {
                        sizeIndex = index;
                        this.variation.paSize= model[index].slug.toString();
                      });
                    },
                        child:  Container(
                          width: 60,
                          decoration: BoxDecoration(
                              color:  sizeIndex==index ? Colors.orange : Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                          child: Center(
                            child: Text(
                              model[index].name, style: TextStyle(color:  sizeIndex==index ?  Colors.white: Colors.black, fontWeight: medium, fontSize: 12), textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ));
                  },itemCount: attribute.options.length,
                ),
              ),
            )
          ],
        );
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    if(BasePrefs.getString(WISHLIST)!=null && BasePrefs.getString(WISHLIST)!=""){
      var value = BasePrefs.getString(WISHLIST);
    List<ProductModel> wishList= (json.decode(value) as List<dynamic>)
          .map<ProductModel>((item) => ProductModel.fromJson(item))
          .toList();
      for(int i=0; i<wishList.length; i++){
        if(wishList[i].id == widget.productModel.id){
          isAdded = true;
        }
      }
    }
    return
      Scaffold(
        body: ProgressHUD( inAsyncCall: isApiCallProcess, opacity: 0.3, child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(child: _CustomScrollView()),
        ),),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0
                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.only(top:10.0, left: 20, bottom: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Visibility(visible: widget.productModel.regularPrice != widget.productModel.price && widget.productModel.regularPrice!="",
                          child: Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: Text(
                              "₹ "+widget.productModel.regularPrice,
                              style: TextStyle(
                                  color: orange,
                                  fontFamily: 'Poppins',
                                  fontSize: 20.0,
                                  fontWeight: semiBold, decoration: TextDecoration.lineThrough,decorationThickness: 2.85
                              ),
                            ),
                          )),
                      Text(
                        "₹ "+widget.productModel.price,
                        style: TextStyle(
                          color: black,
                          fontFamily: 'Poppins',
                          fontSize: 20.0,
                          fontWeight: semiBold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(color:Colors.orange),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              VariableProduct vproduct  = VariableProduct(id: widget.productModel.id,
                              quantity: 1, variationId: variationId, variation: variation);
                              if(widget.productModel.type != Type.VARIABLE ){
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                _webApiServices.getAddToCart(widget.productModel.id, "1").then((value) {
                                  _webResponseModel = value;
                                  if(_webResponseModel.code=="1"){
                                    cartDialog(_webResponseModel.message);
                                  }else{
                                    toast(_webResponseModel.message);
                                  }
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                });
                              }
                              else{
                                setState(() {
                                  isApiCallProcess = true;
                                });
                                _webApiServices.getAddToCartVariationProduct(variableProduct:vproduct).then((value) {
                                  _webResponseModel = value;
                                  if(_webResponseModel.code=="1"){
                                    cartDialog(_webResponseModel.message);
                                  }else{
                                    toast(_webResponseModel.message);
                                  }
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                });
                              }
                              },
                            child:  Padding(
                              padding: const EdgeInsets.only(top:5.0, bottom: 5.0, left: 0, right: 0),
                              child: SvgPicture.asset(ic_shoppingcart, color: orange,),
                            ),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: GestureDetector(onTap: (){
                          VariableProduct vproduct  = VariableProduct(id: widget.productModel.id,
                              quantity: 1, variationId: variationId, variation: variation);
                          if(widget.productModel.type != Type.VARIABLE ){
                            setState(() {
                              isApiCallProcess = true;
                            });
                            _webApiServices.getAddToCart(widget.productModel.id, "1").then((value) {
                              _webResponseModel = value;
                              if(_webResponseModel.code=="1"){
                              changeScreen(context, CartScreen());
                              }else{
                                toast(_webResponseModel.message);
                              }
                              setState(() {
                                isApiCallProcess = false;
                              });
                            });
                          }
                          else{
                            setState(() {
                              isApiCallProcess = true;
                            });
                            _webApiServices.getAddToCartVariationProduct(variableProduct:vproduct).then((value) {
                              _webResponseModel = value;
                              if(_webResponseModel.code=="1"){
                               changeScreen(context, CartScreen());
                              }else{
                                toast(_webResponseModel.message);
                              }
                              setState(() {
                                isApiCallProcess = false;
                              });
                            });
                          }
                        },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left:15.0, top: 5, bottom: 5, right: 15),
                              child:  Text('Buy Now', style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 12)),
                            ),
                          ),),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
  void cartDialog(String msg){
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder:(context, anim1, anim2){
          return Material(
            type: MaterialType.transparency,
            child:Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0
                      )
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
                              child:  GestureDetector(
                                onTap: (){setState(() {
                                  Navigator.pop(context);
                                });},
                                child: Container(
                                    height: 35,
                                    margin: EdgeInsets.zero,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black ,
                                      size: 15,
                                    )),
                              ),
                            ),
                          ],),
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
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(100)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0),
                                          blurRadius: 6.0
                                      )
                                    ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0.0, 1.0),
                                              blurRadius: 6.0
                                          )
                                        ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(40.0),
                                      child: SvgPicture.asset('assets/icons/ic_shoppingcart.svg', color: Colors.white,),
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
                                  child:  CircleAvatar(
                                    radius: 15.0,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )
                              ))

                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Text('Success!', style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 20),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Text(msg, style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 12),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0, left: 20, right:20, bottom: 20),
                        child: _cartDone(),
                      )
                    ],
                  ),
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

class VariableProduct {
  VariableProduct({
    this.id,
    this.quantity,
    this.variationId,
    this.variation,
  });

  int id;
  int quantity;
  int variationId;
  Variation variation;

  factory VariableProduct.fromJson(Map<String, dynamic> json) => VariableProduct(
    id: json["id"],
    quantity: json["quantity"],
    variationId: json["variation_id"],
    variation: Variation.fromJson(json["variation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "variation_id": variationId,
    "variation": variation.toJson(),
  };
}

class Variation {
  Variation({
    this.paColor,
    this.paSize,
    this.logo
  });

  String paColor;
  String paSize;
  String logo;

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    paColor: json["pa_color"],
    paSize: json["pa_size"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "pa_color": paColor,
    "pa_size": paSize,
    "logo":logo
  };
}
