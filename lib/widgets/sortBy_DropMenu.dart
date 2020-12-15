import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/mockdata/item_categories.dart';
import 'package:wooapp/widgets/loading.dart';

class sortByDropMenu extends StatefulWidget{
  List<CategoryModel> categoryList;
  final int num;
  sortByDropMenu({Key key, this.num, this.categoryList}) : super(key: key);


  @override
  sortByDropMenuState createState()=>sortByDropMenuState(byCatgories: categoryList);


}

class sortByDropMenuState extends State<sortByDropMenu>{
  List<CategoryModel> byCatgories;

  sortByDropMenuState({Key key,  this.byCatgories});

  List<DropdownMenuItem<CategoryModel>> _dropdownMenuItems;
  CategoryModel _selectedCategori;
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(byCatgories);
    _selectedCategori= _dropdownMenuItems[0].value;
    super.initState();
  }
  List<DropdownMenuItem<CategoryModel>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<CategoryModel>> items = List();
    for (CategoryModel category in companies) {
      var imageUrl='https://app.democontentphoeniixx.com/wp-content/uploads/2020/01/w1.jpeg';
      if(category.image!=null){
        imageUrl = category.image.src;
      }
      printLog("imageURL", category.image);
      items.add(
        DropdownMenuItem(

          value: category,
          child: SizedBox(
            height: 30,
            child: Row(
              children: [
                Image.network(imageUrl, height: 15, width: 15),
                Padding(
                  padding: const EdgeInsets.only(left:10.0),
                  child: Text(category.name, style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.w400
                  ),),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return items;
  }
  onChangeDropdownItem(CategoryModel selectedCategori) {
    setState(() {
      _selectedCategori = selectedCategori;
    });
  }
  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(left:30.0, right: 30),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.grey[300], width: 0.5),
             ),
          child:  SizedBox(
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  value: _selectedCategori,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
              )
            ),
          ),
        ),
      ) ;
  }
}
