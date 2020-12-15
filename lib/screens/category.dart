import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/mockdata/item_categories.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/widgets/loading.dart';

class CategoriesScreen extends StatefulWidget {

  const CategoriesScreen({Key key}) : super(key: key);
  @override
  CategoriesScreenState createState()=>CategoriesScreenState();

}
class CategoriesScreenState extends State<CategoriesScreen>{
  int _selectItem = 0;
  String _selectedItemID ;
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
  BasePrefs.init();
  CategoriesProvider.initialize();
  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height/1.32 - kToolbarHeight - 34) / 2.2;
    final double itemWidth = size.width / 2;

  final categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);
  final productProvider = Provider.of<ProductsProvider>(context);
  final app= Provider.of<AppProvider>(context);
    return Scaffold(
     body: Container(
       decoration: BoxDecoration(color: Colors.white),
         child: RefreshIndicator(
             onRefresh: () async {
               await Future.value({});
             },
             child: CustomScrollView(
               slivers: <Widget>[
                 SliverAppBar(
                   pinned: true,
                   expandedHeight: 50,
                   flexibleSpace: FlexibleSpaceBar(
                     title: Text("Categories",
                         style: TextStyle(
                             fontFamily: 'Poppins',
                             fontSize: 16.0,
                             fontWeight: FontWeight.w600,
                             color: Colors.black)),
                     centerTitle: true,
                   ),
                   floating: true,
                   leading: GestureDetector(
                       onTap: (){
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
                 SliverPadding(padding: EdgeInsets.all(8),
                   sliver: SliverGrid(
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 3,
                       childAspectRatio: (itemWidth/itemHeight),
                     ),
                     delegate: SliverChildBuilderDelegate(
                             (BuildContext context, int index){
                           return GestureDetector(onTap: ()async{
                             setState(() {
                               _selectItem  =index;
                               _selectedItemID = categoryProvider.categories[index].id;
                             });
                           },
                               child: Card(
                                 color: _selectItem==index ? Colors.orange: Colors.white,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),
                                 elevation: 3,
                                 child: Container(
                                   child: Center(
                                     child: Padding(
                                       padding: const EdgeInsets.all(18.0),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: <Widget>[
                                           // SvgPicture.asset(categoryProvider.categories[index].icon, alignment: Alignment.center, height: 30, width: 30, color: _selectItem==index ? Colors.white: Colors.black,),
                                           Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Text(categoryProvider.categories[index].name, style: TextStyle( color: _selectItem==index ? Colors.white: Colors.black,
                                                 fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Poppins')),
                                           )
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                               ));
                         },childCount: categoryProvider.categories.length
                     ),
                   ),
                 ),
               ],
             )),
      ),
      bottomNavigationBar:  Container(
         color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector (onTap: ()async{
              BasePrefs.setString(CATEGORY_ID, _selectedItemID);

             await productProvider.loadProductsByCategory(sort: 'default', page:'1', per_pag:'10',category: _selectedItemID);
              changeScreen(context, MainPageScreen(currentTab: 1,));
            },
            child:  Container(
              height: 40,
              decoration: BoxDecoration(
                color:  Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text('Next', style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14)),
              ),
            ),)

          )
      )
    );
  }
}