import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/mockdata/item_model.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/product.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/sortBy_Dialog.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key key}) : super(key: key);
  @override
  FavouriteScreenState createState() => FavouriteScreenState();
}

class FavouriteScreenState extends State<FavouriteScreen> {
  int currentTab = 0;
  int sortByIndex = 0;
  ProductsProvider productList;
  int _page =1;
  @override
  void initState() {
    productList = Provider.of<ProductsProvider>(context, listen: false);
    productList.fetchProducts(_page);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(context, "Wishlist", prefixIcon: Container(), suffixIcon: Container()),
      body: Container(
          child:  _CustomScrollView()),
    );
  }

  Widget _CustomScrollView() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height / 1.32 - kToolbarHeight - 34) / 2;
    final double itemWidth = size.width / 2;
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverToBoxAdapter(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 9, right: 9),
                      child: Text(
                        'Top Items',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 9, right: 9),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentTab = 0;
                          SortByDialog();
                        });
                      },
                      child: Container(
                        height: 35,
                        margin: EdgeInsets.zero,
                        child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color:
                                currentTab == 0 ? Colors.orange : Colors.white,
                            elevation: 2,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    "assets/icons/ic_sortby.svg",
                                    color: currentTab == 0
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Sort By",
                                      style: TextStyle(
                                          color: currentTab == 0
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 8),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // SliverPadding(
        //   padding: EdgeInsets.only(left: 30, right: 30),
        //   sliver: SliverToBoxAdapter(
        //     child: Container(
        //       child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: <Widget>[
        //             GestureDetector(
        //                 child: Text("Featured",
        //                     style: TextStyle(
        //                         fontFamily: 'Poppins',
        //                         fontSize: 14.0,
        //                         fontWeight: FontWeight.w500,
        //                         color: Colors.black))),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: <Widget>[
        //                 Text(
        //                   "See More",
        //                   style: TextStyle(
        //                       fontFamily: 'Poppins',
        //                       fontSize: 10.0,
        //                       fontWeight: FontWeight.w500,
        //                       color: Colors.black),
        //                 ),
        //                 Icon(
        //                   Icons.arrow_right_alt_rounded,
        //                   color: Colors.black,
        //                   size: 20,
        //                 )
        //               ],
        //             )
        //           ]),
        //     ),
        //   ),
        // ),
        SliverPadding(
          padding: const EdgeInsets.only(top:10, left:15.0, right: 15),
          sliver: SliverToBoxAdapter(
            child: _productList(),),
        )
      ],
    );
  }

  Widget _productList(){
    return new Consumer<ProductsProvider>(builder: (context, productModel, child){
      if(productModel.allProducts!=null &&
          productModel.allProducts.length>0
      ){
        return _buildProductList(productModel.allProducts);
      }else{
        return progressBar(context, orange);
      }
    });
  }

  Widget _buildProductList(List<ProductModel> productList) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height / 1.32 - kToolbarHeight - 15) / 2;
    final double itemWidth = size.width / 2;
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      padding: EdgeInsets.zero,
      childAspectRatio: (itemWidth / itemHeight),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      physics: ClampingScrollPhysics(),
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
    );
  }
  void SortByDialog() {
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
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
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
                                    color: Colors.black,
                                    size: 25,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: Text("Sort By",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: Container(
                                  height: 35,
                                  margin: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.refresh,
                                    color: Colors.black,
                                    size: 25,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      child: sortByDialog(sortByIndex),
                    ),
                   customButton(title: "APPLY",onPressed: (){
                     Navigator.pop(context);
                   })
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
}
