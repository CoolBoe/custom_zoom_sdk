import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/mockdata/item_colorpicker.dart';
import 'package:wooapp/models/mockdata/item_sortby.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/helper/color.dart' as color;
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:wooapp/widgets/loading.dart';

class ProductScreen extends StatefulWidget {

  ProductModel productModel;
  ProductScreen({Key key, this.productModel}) : super(key: key);
  @override
  ProductScreenState createState()=>ProductScreenState();

}

class ProductScreenState extends State<ProductScreen>{

  Widget _cartDone(){
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0,
          left: 30,
          right: 30
      ),
      child: GestureDetector(onTap: (){
        // Navigator.of(context).pushNamed(routes.CartScreen_Route);
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

    final productProvider = Provider.of<ProductsProvider>(context, listen: false);

    for(int i=0; i<widget.productModel.relatedIds.length; i++){
      printLog("relatedIdss", widget.productModel.relatedIds[i].toString());
      productProvider.loadProductsById(
          id: widget.productModel.relatedIds[i].toString());
    }
    List<ProductModel> modelList =productProvider.productsByIdsList;
    printLog("relatedIdmodelListss", modelList.length.toString());

    String catergory = "Uncategorized";
    String attributes = "Uncategorized";
    if(widget.productModel.categories!=null){
      catergory= widget.productModel.categories[0].name;
    };
    if(widget.productModel.attributes!=null){
      attributes = "Variation in "+widget.productModel.attributes[0].name;
    }
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 50,
          backgroundColor: color.grey,
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
              child: SvgPicture.asset('assets/icons/ic_search.svg'),
            )
          ],
        ),
        SliverPersistentHeader(
          delegate: MySliverAppBar(expandedHeight: 350, productModel: widget.productModel),
          pinned: true,
        ),
        SliverPadding(padding: const EdgeInsets.only(top: 0),
         sliver: SliverToBoxAdapter(
          child: SizedBox(
            height: 0,
          ),
        ),),
        SliverPadding(
          padding: const EdgeInsets.only(top:150.0, left: 30, right:28, bottom: 10),
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
                                child: Text(attributes, style: TextStyle(
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
          padding: const EdgeInsets.only(top:0.0, left: 10, right:8, bottom: 10),
          sliver: SliverToBoxAdapter(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Related Product", style: TextStyle( color: Colors.black,
                       fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 15),),
                 ),
                ],
              )
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: modelList.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(onTap: (){
                      changeScreen(context, ProductScreen(productModel: modelList[index],));
                    },
                    child:Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 180,
                                child: FadeInImage(
                                  placeholder: AssetImage('assets/images/bg_lock.png'),
                                  image: NetworkImage(modelList.length >= 0 ? modelList[index].images[0].src : 'assets/images/bg_lock.png'),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(modelList.length >= 0 ? modelList[index].name : "Woo App",
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
                                      text:modelList.length >= 0 ?"₹ "+modelList[index].price+"   ": "₹ 200 ",
                                      style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 12.0,
                                        fontWeight: FontWeight.w600,),),
                                    new TextSpan(
                                      text:  modelList.length >= 0 ? "₹"+ modelList[index].regularPrice: "₹ 250",
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
                                  initialRating:double.parse(modelList.length >= 0 ?modelList[index].ratingCount.toString(): "5"),
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
                              Text(modelList.length >= 0 ? " {"+modelList[index].averageRating+"}" : "5",
                                style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 12.0,
                                  fontWeight: FontWeight.w600,),),
                            ],
                          )
                        ],
                      ),
                    ) ,)
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: RefreshIndicator(
              onRefresh: () async {
                await Future.value({});
              },
              child:  Center(child: _CustomScrollView())),
        ),
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
                  Text('₹ '+widget.productModel.price, style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 24)),
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(color:Colors.orange),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                          ),
                          child: GestureDetector(
                            onTap: ()async{
                              final cart = Provider.of<CartProvider>(context);

                              cartDialog();
                            },
                            child:  Padding(
                              padding: const EdgeInsets.only(top:5.0, bottom: 5.0, left: 0, right: 0),
                              child: SvgPicture.asset('assets/icons/ic_shoppingcart.svg', color: Colors.orange,),
                            ),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: GestureDetector(onTap: (){
                          // Navigator.of(context).pushNamed(routes.CartScreen_Route);
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
  void cartDialog(){

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
                        child: Text('1 product has been added to your cart!', style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 12),),
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
class MySliverAppBar extends SliverPersistentHeaderDelegate{
  final double expandedHeight;
  ProductModel productModel;

  MySliverAppBar({@required this.expandedHeight, this.productModel});
  List<ColorBy> sortByColor = [
    ColorBy(Colors.green, Colors.green[100],false),
    ColorBy(Colors.orange, Colors.orange[100], false),
    ColorBy(Colors.blue, Colors.blue[100], false),
    ColorBy(Colors.grey, Colors.grey[100], false),
    ColorBy(Colors.red, Colors.red[100], false),
    ColorBy(Colors.yellow, Colors.yellow[100], false),
  ];
  List<SortBy> sortBy = [
    SortBy("XS", 0, ),
    SortBy("S", 1),
    SortBy("M", 2),
    SortBy("L", 3),
    SortBy("XL", 4),
    SortBy("XXL", 5),
  ];
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool IsColorAttribute;
    bool IsSizeAttribute;
    if(productModel.attributes!=null){
      for (int i=0; i<productModel.attributes.length; i++){
         if(productModel.attributes[i].name=="Color"){
           IsColorAttribute=true;
         }if(productModel.attributes[i].name=="Size"){
           IsSizeAttribute=true;
         }
      }
    }

    List<NetworkImage> imgeLisr  = List<NetworkImage>();
    for(int i=0; i<productModel.images.length; i++){
     imgeLisr.add(NetworkImage(productModel.images[i].src));
    }
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          height: 350,
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
            dotColor: Colors.grey,
            dotPosition: DotPosition.bottomCenter,
            showIndicator: true,
            indicatorBgPadding: 6.0,
            images:imgeLisr
          ),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              '',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
            top: expandedHeight/1.1-shrinkOffset,
            left: MediaQuery.of(context).size.width/13,
            child: Opacity(
              opacity: 1-shrinkOffset/expandedHeight,
              child: Card(
                elevation: 3,
                child:  SizedBox(
                  height: 170,
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
                            Text(productModel.name,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                            Padding(
                              padding: EdgeInsets.only(right: 30),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon( Icons.star, color: Colors.orange,size: 20,),
                                  Text("{"+ productModel.ratingCount.toString()+ "}",

                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ],),
                        Text(productModel.description,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        Padding(
                          padding: const EdgeInsets.only(top:15.0),
                          child: Row(
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
                                  height: 20,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(onTap: (){

                                      },
                                          child:  Container(
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color:  Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(5.0))
                                            ),
                                            child: Center(child: Text(sortBy[index].name, style: TextStyle(color:  Colors.black), textAlign: TextAlign.center,)),
                                          ));
                                    },itemCount: sortBy.length,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: Row(
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
                                  height: 50.0,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(onTap: (){
                                      },
                                          child:  Container(
                                            height: 25,
                                            width: 25,
                                            padding: EdgeInsets.only(left: 5, right: 5),
                                            margin: EdgeInsets.only(left: 5, right: 5),
                                            decoration: ShapeDecoration(
                                                color: sortByColor[index].centerColor,
                                                shape: CircleBorder(
                                                    side: BorderSide(width: 6,
                                                        color: sortByColor[index].borderColor )
                                                )
                                            ),
                                          ));
                                    },itemCount: sortBy.length,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ],
    );

  }
  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate)=>true;



}