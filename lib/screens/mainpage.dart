import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/mockdata/item_categories.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/screens/cart.dart';
import 'package:wooapp/screens/favourite.dart';
import 'package:wooapp/screens/home.dart';
import 'package:wooapp/screens/profile.dart';
import 'package:wooapp/screens/productBuilder.dart';

class MainPageScreen extends StatefulWidget {
  int currentTab = 0;
  MainPageScreen({Key key, this.currentTab}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MainPageScreenState(currentTab);
  }
}

class MainPageScreenState extends State<MainPageScreen> with ChangeNotifier {
  bool _toggel = true;
  int currentTab;

  MainPageScreenState(this.currentTab);
  final List<Widget> screens = [
    HomeView(),
    ShopView(),
    FavouriteScreen(),
    ProfileView(),
  ];

  List<ByCatgories> sortBy = [
    ByCatgories("Home", 0, 'assets/icons/ic_home.svg'),
    ByCatgories("Shop", 1, 'assets/icons/ic_shop.svg'),
    ByCatgories("Shop by Category", 2, 'assets/icons/ic_categories.svg'),
    ByCatgories("Chat Support", 3, 'assets/icons/ic_chat.svg'),
    ByCatgories("Contact Us", 4, 'assets/icons/ic_call.svg'),
    ByCatgories("Terms of Service", 5, 'assets/icons/ic_support.svg'),
    ByCatgories("Give Feedback", 6, 'assets/icons/ic_rating.svg'),
  ];

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
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final app = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      body: PageStorage(
        child: currentScreen(currentTab),
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: SvgPicture.asset(
          "assets/icons/ic_shoppingcart.svg",
          color: Colors.white,
        ),
        onPressed: () {
          changeScreen(context, CartScreen());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
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
                        currentTab = 0;
                        currentScreen(currentTab);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/ic_home.svg",
                          color: currentTab == 0 ? Colors.orange : Colors.grey,
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                        currentScreen(currentTab);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/ic_shop.svg",
                          color: currentTab == 1 ? Colors.orange : Colors.grey,
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
                        currentTab = 2;
                        currentScreen(currentTab);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/ic_heart.svg",
                          color: currentTab == 2 ? Colors.orange : Colors.grey,
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentTab = 3;
                        currentScreen(currentTab);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/ic_profile.svg",
                          color: currentTab == 3 ? Colors.orange : Colors.grey,
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
    );
  }
}
