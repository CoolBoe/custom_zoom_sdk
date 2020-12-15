
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/models/mockdata/item_colorpicker.dart';
import 'package:wooapp/models/mockdata/item_sortby.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/product.dart';

class ProductScreen extends StatefulWidget {

  ProductModel productModel;
   ProductScreen({Key key, this.productModel}) : super(key: key);
  @override
  ProductScreenState createState()=>ProductScreenState();

}

class ProductScreenState extends State<ProductScreen>{
  ProductModel productModel;

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

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: MySliverAppBar(expandedHeight: 550, productModel: productModel),
          pinned: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top:130.0, left: 30, right:28, bottom: 10),
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
                                child: Text(productModel.categories[0].name, style: TextStyle(
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
                                child: Text(productModel.totalSales.toString(), style: TextStyle(
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
                                child: Text(productModel.sku, style: TextStyle(
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
                                child: Text(productModel.attributes[0], style: TextStyle(
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
                Text('₹ '+productModel.price, style: TextStyle(
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
                        onTap: (){
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
         return Stack(
           fit: StackFit.expand,
           overflow: Overflow.visible,
           children: [
             Container(
               height: 350,
               decoration: BoxDecoration(
                   color: Colors.grey[200]
               ),
               child: Padding(
                 padding: const EdgeInsets.only(top: 60.0, bottom: 30),
                 child: Image.network(productModel.images[0].src),
               ),
             ),
             Positioned(
                 top: expandedHeight/9-shrinkOffset,
                 left: MediaQuery.of(context).size.width/20,
                 child: GestureDetector(onTap: (){
                   Navigator.pop(context);
                 },
                 child: Icon(
                  Icons.arrow_back, color: Colors.black,
                  ),
                 )),
                 
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
