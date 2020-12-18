import 'dart:async';
import 'dart:math' as math;
import 'package:wooapp/helper/productList.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/mockdata/item_model.dart';
import 'package:wooapp/screens/category.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/widgets/item_DrawerBuilder.dart';

class HomeView extends StatefulWidget {

  const HomeView({Key key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeView> {
  bool _toggel = true;

  final String ic_eyeglasses = "assets/icons/ic_eyeglasses.svg";
  final PageController _controller = PageController();
  int pageCount = 4;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  List<String> _images = List();


  int currentTab = 0;
  int _selectItem = 0;
  @override
  void initState() {
    // TODO: implement initState
    _images..add("https://i.pinimg.com/originals/10/78/e8/1078e854e2933b6763c754d37198f762.png");
    _images..add("https://app.tutiixx.com/wp-content/uploads/2019/01/T_7_front-600x600.jpg");
    _images..add("https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_4_front-600x600.jpg");
    _images..add("https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_7_front-600x600.jpg");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: _buildDrawer(),
      body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: RefreshIndicator(
              onRefresh: () async {
                await Future.value({});
              },
              child: _CustomScrollView())),
    );
  }
  Widget _CustomScrollView() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height/1.32 - kToolbarHeight - 34) / 2;
    final double itemWidth = size.width / 2;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.grey[50],
          expandedHeight: 250,
          floating: false,
          centerTitle: true,
          iconTheme: new IconThemeData(color: Colors.black),
          flexibleSpace: FlexibleSpaceBar(
            background: LimitedBox(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Carousel(
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
                  images: [
                    NetworkImage(
                        "https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_7_front-600x600.jpg"),
                    NetworkImage(
                        "https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_6_front-600x600.jpg"),
                    NetworkImage(
                        "https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_2_front-600x600.jpg"),
                    NetworkImage(
                        "https://app.tutiixx.com/wp-content/uploads/2019/01/T_1_front-600x600.jpg")
                  ],
                ),
              ),
            ),
          ),
          title: Text('Woo App',style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SvgPicture.asset('assets/icons/ic_search.svg'),
            )
          ],
        ),
        SliverPadding(padding: EdgeInsets.only(top: 10, left: 30, right: 30),
        sliver: SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    child: Text("All Categories",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(onTap: (){
                      changeScreen(context, CategoriesScreen());
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Colors.black,
                      size: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        ),
        SliverPadding(padding: EdgeInsets.all(5),
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
                                  "assets/icons/ic_eyeglasses.svg",
                                  color: currentTab == 0
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Glasses",
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
                                  "assets/icons/ic_hoodie.svg",
                                  color: currentTab == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Hoodies",
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
                                  "assets/icons/ic_backpack.svg",
                                  color: currentTab == 2
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Backpack",
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
                Padding(
                  padding: EdgeInsets.only(left: 9, right: 9),
                  child:  GestureDetector(
                    onTap: (){setState(() {
                      currentTab = 3;
                    });},
                    child: Container(
                      height: 35,
                      margin: EdgeInsets.zero,
                      child: Card(
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10)),
                          color: currentTab == 3
                              ? Colors.orange
                              : Colors.white,
                          elevation: 2,
                          child: Padding(padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/icons/ic_sneaker.svg",
                                  color: currentTab == 3
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 0),
                                  child: Text(
                                    "Shoes",
                                    style: TextStyle(
                                        color: currentTab == 3
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
        SliverPadding(padding: EdgeInsets.only(left: 30, right: 30),
          sliver: SliverToBoxAdapter(
            child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        child: Text("Featured",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "See More",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Icon(
                          Icons.arrow_right_alt_rounded,
                          color: Colors.black,
                          size: 20,
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
        SliverPadding(padding: EdgeInsets.all(8),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: (itemWidth/itemHeight),
            ),
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index){
                  return _itemBuilder( context, index);
                },childCount: productList(context).length
            ),
          ),
        ),
        SliverPadding(padding: EdgeInsets.only(left: 30, right: 30),
          sliver: SliverToBoxAdapter(
            child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        child: Text("Top Sellers",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "See More",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Icon(
                          Icons.arrow_right_alt_rounded,
                          color: Colors.black,
                          size: 20,
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
        SliverPadding(padding: EdgeInsets.all(8),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: (itemWidth/itemHeight),
            ),
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index){
                  return _itemBuilder( context, index);
                },childCount: productList(context).length
            ),
          ),
        ),
      ],
    );
  }
  Widget _itemDrawer(String Icon, String Name){
    return
      Padding(
      padding: const EdgeInsets.only(top:10.0, left: 00, right: 30),
        child:  Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:10.0, left: 20, bottom: 10),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right:10.0),
                  child: SvgPicture.asset(Icon,width: 20,height: 20,),
                ),
                Text(Name, style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14))
              ],
            ),
          ),
        ),
    );
  }
  Widget _itemBuilder(BuildContext context, int index ){
    double rating = double.parse(productList(context)[index].ratingCount.toString());
    return GestureDetector(onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen()));
    },
    child: Container(
      height: 200,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(productList(context)[index].images[0].src),fit: BoxFit.fill
                    )
                ),
                // child: Image.network(itemList[index].item_image, fit: BoxFit.fill)
              ),
              new Align(alignment: Alignment.topRight,
                child:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/icons/ic_heart.svg', color: Colors.red,),
                ),)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(productList(context)[index].name,
              style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 12.0,
                fontWeight: FontWeight.w600,),),
          ),
          Text(productList(context)[index].price,
            style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 12.0,
              fontWeight: FontWeight.w600,),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              RatingBar(
                  itemSize: 20,
                  initialRating: rating,
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
              Text(" {"+productList(context)[index].ratingCount.toString()+"}",
                style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 12.0,
                  fontWeight: FontWeight.w600,),),
            ],
          )
        ],
      ),
    ),);
  }
  Widget _buildDrawer() {
    return Container(
      width: 250,
        child:  ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
            child: Drawer(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 250,
                      child: DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.black
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top:20.0),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80'),
                                  backgroundColor: Colors.transparent,
                                ),
                                Text('Phoeniixx Design', style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.white
                                ),),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5.0),
                                        child: Text('Dark Mode', style: TextStyle( color: Colors.white, fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w400),),
                                      ),
                                      AnimatedContainer(duration: Duration(milliseconds: 1000),
                                        height:15,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: _toggel ? Colors.white : Colors.orange
                                        ),
                                        child: Stack(
                                          children: <Widget>[
                                            AnimatedPositioned(
                                                duration: Duration(milliseconds: 1000),
                                                curve: Curves.easeIn,
                                                right: _toggel?0.0:20.0,
                                                left: _toggel?20.0:0.0,
                                                child:InkWell(
                                                  onTap: toggleButton,
                                                  child: AnimatedSwitcher(
                                                    duration: Duration(milliseconds: 1000),
                                                    transitionBuilder: (Widget child, Animation<double> animation){
                                                      return ScaleTransition(
                                                          child: child,
                                                          scale: animation);
                                                    },
                                                      child: _toggel ? Icon(Icons.circle, color: Colors.orange, size: 15,) : Icon(Icons.circle, color: Colors.white, size: 15,)
                                                ), )
                                            )],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 400,
                      child: ItemDrawerBuilder(),
                    ),
                    Expanded(child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color:  Colors.black,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top:10.0, left: 30, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right:10.0),
                                child: SvgPicture.asset('assets/icons/ic_logout.svg',width: 20,height: 20, color: Colors.white,),
                              ),
                              Text('Logout', style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14))
                            ],
                          ),
                        ),
                      ),),
                      )
                  ],
                ),
            ),
        )

    );
  }
  void toggleButton() {
  setState(() {
    _toggel = !_toggel;
  });
  }
}

