import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/firebase/event.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/mockdata/item_categories.dart';
import 'package:wooapp/providers/ThemeProvider.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/screens/cart.dart';
import 'package:wooapp/screens/favourite.dart';
import 'package:wooapp/screens/home.dart';
import 'package:wooapp/screens/profile.dart';
import 'package:wooapp/screens/productBuilder.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/loading.dart';

class MainPageScreen extends StatefulWidget {
  int currentTab = 0;
  MainPageScreen({Key key, this.currentTab}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MainPageScreenState();
  }
}

class MainPageScreenState extends State<MainPageScreen> with ChangeNotifier {
  bool _toggel = true;

  List<ByCatgories> sortBy = [
    ByCatgories("Home", 0, 'assets/icons/ic_home.svg'),
    ByCatgories("Shop", 1, 'assets/icons/ic_shop.svg'),
    ByCatgories("Shop by Category", 2, 'assets/icons/ic_categories.svg'),
    ByCatgories("Chat Support", 3, 'assets/icons/ic_chat.svg'),
    ByCatgories("Contact Us", 4, 'assets/icons/ic_call.svg'),
    ByCatgories("Terms of Service", 5, 'assets/icons/ic_support.svg'),
    ByCatgories("Give Feedback", 6, 'assets/icons/ic_rating.svg'),
  ];
  @override
  void initState() {
    BasePrefs.init();
    var cart = Provider.of<CartProvider>(context, listen: false);
    cart.getCartItemCount();
    super.initState();
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen(int screenId) {
    switch (screenId) {
      case 0:
        return HomeView();
      case 1:
        return ShopView();
      case 2:
        return FavouriteScreen();
      case 3:
        return ProfileView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen(widget.currentTab),
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(

        backgroundColor: accent_color,
        child: Stack(
          children: <Widget>[
            new Align(
              child: SvgPicture.asset(
                ic_shoppingcart,
                color: Colors.white,
              ),
            ),
            cartItem()
          ],
        ),
        onPressed: () {
          changeScreen(context, CartScreen());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:Container(
        color: Theme.of(context).backgroundColor,
        child:  BottomAppBar(
          color: Theme.of(context).bottomAppBarColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          widget.currentTab = 0;
                          currentScreen(widget.currentTab);
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/ic_home.svg",
                            color: widget.currentTab == 0
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).accentColor,
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          widget.currentTab = 1;
                          currentScreen(widget.currentTab);
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/ic_shop.svg",
                            color: widget.currentTab == 1
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).accentColor,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          widget.currentTab = 2;
                          currentScreen(widget.currentTab);
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/ic_heart.svg",
                            color: widget.currentTab == 2
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).accentColor,
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          widget.currentTab = 3;
                          currentScreen(widget.currentTab);
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/ic_profile.svg",
                            color: widget.currentTab == 3
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).accentColor,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Add code before the super
    super.dispose();
  }

  Widget cartItem() {
    return new Consumer<CartProvider>(builder: (context, cartModel, child) {
      if (cartModel.totalCartItem != null && cartModel.totalCartItem > 0) {
        return new Positioned(
            right: 0,
            child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      color: green_400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      cartModel.totalCartItem.toString(),
                      style: styleProvider(
                          fontWeight: medium, size: 14, color: white),
                    ))));
      } else {
        return Container();
      }
    });
  }
}
