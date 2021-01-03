import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/mockdata/item_categories.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key key}) : super(key: key);
  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  int _selectItem = 0;
  var _page = 1;
  String _selectedItemID = '15';
  List<ByCatgories> productbycategories = [
    ByCatgories('Glasses', 0, "assets/icons/ic_eyeglasses.svg"),
    ByCatgories('Hoodies', 1, "assets/icons/ic_hoodie.svg"),
    ByCatgories("Backpack", 2, "assets/icons/ic_backpack.svg"),
    ByCatgories("Men Shoes", 3, "assets/icons/ic_sneaker.svg"),
    ByCatgories("Purse", 4, "assets/icons/ic_bag.svg"),
    ByCatgories("Watch", 5, "assets/icons/ic_watch.svg"),
    ByCatgories("Skirt", 6, "assets/icons/ic_skirt.svg"),
    ByCatgories("Clothing", 7, "assets/icons/ic_cloth.svg"),
    ByCatgories("Jeans", 8, "assets/icons/ic_trousers.svg")
  ];


  @override
  void initState() {
    var categoryList=Provider.of<CategoriesProvider>(context, listen: false);
    categoryList.fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: _categoriesList(),
        bottomNavigationBar: Container(
            color: Colors.transparent,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    var productList = Provider.of<ProductsProvider>(context, listen: false);
                    productList.resetStreams();
                    productList.setLoadingState(LoadMoreStatus.INITIAL);
                    productList.fetchProducts(_page, category_id: _selectedItemID);
                    changeScreen(
                        context,
                        MainPageScreen(
                          currentTab: 1,
                        ));
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text('Next',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 14)),
                    ),
                  ),
                ))));
  }
  Widget _categoriesList(){
    return new Consumer<CategoriesProvider>(builder: (context, categoryModel, child){
      if(categoryModel.allCategories!=null &&
          categoryModel.allCategories.length>0
      ){
        return _categoriesListBuilder(categoryModel.allCategories);
      }else{
        return progressBar(context, orange);
      }
    });
  }
  Widget _categoriesListBuilder(List<CategoryModel> items){
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height / 1.32 - kToolbarHeight - 34) / 2.2;
    final double itemWidth = size.width / 2;
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: dp50,
              backgroundColor: white,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Categories",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: medium,
                        color: black)),
                centerTitle: true,
              ),
              floating: true,
              leading: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SvgPicture.asset(ic_search),
                )
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: (itemWidth / itemHeight),
                ),
                delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      var imageUrl =
                          'https://app.democontentphoeniixx.com/wp-content/uploads/2020/01/w1.jpeg';
                      if (items[index].image != null) {
                        imageUrl = items[index].image.src;
                      }
                      return GestureDetector(
                          onTap: () async {
                            setState(() {
                              _selectItem = index;
                              _selectedItemID = items[index].id.toString();
                            });
                          },
                          child: Card(
                            color: _selectItem == index
                                ? Colors.orange
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 3,
                            child: Container(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.network(imageUrl,
                                          alignment: Alignment.center,
                                          height: 55,
                                          width: 60),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(items[index].name,
                                            style: TextStyle(
                                                color: _selectItem == index
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins')),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    }, childCount: items.length),
              ),
            ),
          ],
        ));
  }
}
