import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/mockdata/item_categories.dart';
import 'package:wooapp/screens/chatsupport.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/category.dart';
import 'package:wooapp/screens/termOfUse.dart';

class ItemDrawerBuilder extends StatefulWidget {
  final int num;

  const ItemDrawerBuilder({Key key, this.num}) : super(key: key);
  @override
  ItemDrawerBuilderState createState() => ItemDrawerBuilderState();
}

class ItemDrawerBuilderState extends State<ItemDrawerBuilder> {
  int value = 0;
  bool selectedColor = false;
  int _selectItem = 0;
  @override
  Widget build(BuildContext context) {
    List<ByCatgories> sortBy = [
      ByCatgories("Home", 0, 'assets/icons/ic_home.svg'),
      ByCatgories("Shop", 1, 'assets/icons/ic_shop.svg'),
      ByCatgories("Shop by Category", 2, 'assets/icons/ic_categories.svg'),
      ByCatgories("Chat Support", 3, 'assets/icons/ic_chat.svg'),
      ByCatgories("Contact Us", 4, 'assets/icons/ic_call.svg'),
      ByCatgories("Terms of Service", 5, 'assets/icons/ic_support.svg'),
      ByCatgories("Give Feedback", 6, 'assets/icons/ic_rating.svg'),
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 30),
      child: Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: sortBy.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectItem = index;
                      switch (_selectItem) {
                        case 0:
                          changeScreen(context, MainPageScreen());
                          break;
                        case 1:
                          changeScreen(context, MainPageScreen());
                          break;
                        case 2:
                          changeScreen(context, CategoriesScreen());
                          break;
                        case 3:
                          changeScreen(context, ChatScreen());
                          break;
                        case 4:
                          contactUsDialog();
                          break;
                        case 5:
                          changeScreen(context, TermsOfUseScreen());
                          break;
                        case 6:
                          ratingDialog();
                          break;
                      }
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 0, right: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectItem == index
                            ? Colors.orange
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 30, bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SvgPicture.asset(
                                sortBy[index].icon,
                                width: 20,
                                height: 20,
                                color: _selectItem == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Text(sortBy[index].name,
                                style: TextStyle(
                                    color: _selectItem == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14))
                          ],
                        ),
                      ),
                    ),
                  ));
            }),
      ),
    );
  }

  void contactUsDialog() {
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text("Contact Us",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
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
                                      color: Colors.black,
                                      size: 25,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 10, right: 20),
                          child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: Text('EMAIL',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14)),
                                  ),
                                ),
                              ))),
                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 0, right: 20),
                          child: Container(
                              padding: EdgeInsets.zero,
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: Text('CALL',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14)),
                                  ),
                                ),
                              ))),
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

  void ratingDialog() {
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
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
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text("Do you like using wooApp",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
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
                                      color: Colors.black,
                                      size: 25,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding:
                                  EdgeInsets.only(left: 00, top: 10, right: 00),
                              child: Container(
                                  width: 150,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 35.0,
                                            right: 35,
                                            top: 5,
                                            bottom: 5),
                                        child: Center(
                                          child: Text('Yes',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ))),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: 00, top: 10, right: 00),
                              child: Container(
                                  width: 150,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        child: Center(
                                          child: Text('Not Really',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ],
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
