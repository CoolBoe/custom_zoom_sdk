import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wooapp/models/mockdata/item_model.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key key}) : super(key: key);
  @override
  FavouriteScreenState createState() => FavouriteScreenState();
}

class FavouriteScreenState extends State<FavouriteScreen> {
  List<Item> itemList = [
    Item(
        "https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_6_front-600x600.jpg",
        "Black Hoodie",
        "₹ 450.00",
        "4.5",
        true,
        "21"),
    Item("https://app.tutiixx.com/wp-content/uploads/2019/01/T_6_front.jpg",
        "T-Shirt", "₹ 400.00", "4.5", true, "0"),
    Item(
        "https://app.tutiixx.com/wp-content/uploads/2019/01/T_5_front-600x600.jpg",
        "T-Shirt",
        "₹ 350.00",
        "4.5",
        true,
        "0"),
    Item("https://app.tutiixx.com/wp-content/uploads/2019/01/T_1_front.jpg",
        "T-Shirt", "₹ 290.00", "4.5", true, "0"),
    Item(
        "https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_7_front-600x600.jpg",
        "Hoodie",
        "₹ 920.00",
        "4.5",
        true,
        "0"),
    Item(
        "https://app.tutiixx.com/wp-content/uploads/2019/01/long-sleeve-tee-2-600x600.jpg",
        "Long Sleeve Tee",
        "₹ 220.00",
        "4.5",
        true,
        "0"),
  ];
  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    final double itemHeight = (size.height / 1.32 - kToolbarHeight - 34) / 2;
    final double itemWidth = size.width / 2;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 50,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Wishlist",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            centerTitle: true,
          ),
          floating: true,
          leading: GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(routes.MainPage_Route);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset('assets/icons/ic_search.svg'),
            )
          ],
        ),
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
                        '6 items',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
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
        SliverPadding(
          padding: EdgeInsets.only(left: 30, right: 30),
          sliver: SliverToBoxAdapter(
            child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        child: Text("Featured",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
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
        SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return _itemBuilder(context, index);
            }, childCount: itemList.length),
          ),
        ),
      ],
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    double rating = double.parse(itemList[index].stars);
    return Container(
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
                        image: NetworkImage(itemList[index].item_image),
                        fit: BoxFit.fill)),
                // child: Image.network(itemList[index].item_image, fit: BoxFit.fill)
              ),
              new Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 12.0,
                      backgroundColor: Colors.red[300],
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 15,
                      ),
                    )),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              itemList[index].item_name,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            itemList[index].price,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                      )),
                  onRatingUpdate: (rating) {
                    print(rating);
                  }),
              Text(
                " {" + itemList[index].stars + "}",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
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
                height: 300,
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
                                setState(() {});
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
                    // Expanded(
                    //     child: sortByDialog(1)
                    // )
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
