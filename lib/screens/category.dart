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
import 'package:wooapp/widgets/app_bar.dart';
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
         appBar: BaseAppBar(context, "Category"),
        body: _categoriesList(),

     );
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
    return SingleChildScrollView(
      child:
      Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                padding: EdgeInsets.zero,
                childAspectRatio: (itemWidth / itemHeight),
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                physics: ClampingScrollPhysics(),
                children:items.map((e) {
                  return GestureDetector(
                      onTap: () async {
                        setState(() {
                          var productList = Provider.of<ProductsProvider>(context, listen: false);
                          productList.resetStreams();
                          productList.setLoadingState(LoadMoreStatus.INITIAL);
                          productList.fetchProducts(_page, category_id: _selectedItemID);
                          changeScreen(
                              context,
                              MainPageScreen(
                                currentTab: 1,
                              ));
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 1,
                        child: Container(
                          child: Column(

                            children: <Widget>[
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight: Radius.circular(10)),
                                  image: DecorationImage(
                                    image: NetworkImage(e.image!=null ? e.image.src : "https://app.democontentphoeniixx.com/wp-content/uploads/2020/01/w1.jpeg", ), fit: BoxFit.fill
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(e.name,
                                    style: TextStyle(
                                        color:Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins')),
                              )
                            ],
                          ),
                        ),
                      ));
                }).toList(),
              ),
            )
          ],
        ),
      ) ,
    );
  }
}
