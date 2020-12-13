import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/models/mockdata/item_categories.dart';

class sortByDropMenu extends StatefulWidget{
  final int num;
  const sortByDropMenu({Key key, this.num}) : super(key: key);


  @override
  sortByDropMenuState createState()=>sortByDropMenuState();


}

class sortByDropMenuState extends State<sortByDropMenu>{
  List<ByCatgories> byCatgories = [
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
  List<DropdownMenuItem<ByCatgories>> _dropdownMenuItems;
  ByCatgories _selectedCategori;
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(byCatgories);
    _selectedCategori= _dropdownMenuItems[0].value;
    super.initState();
  }
  List<DropdownMenuItem<ByCatgories>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<ByCatgories>> items = List();
    for (ByCatgories category in companies) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: SizedBox(
            height: 30,
            child: Row(
              children: [
                SvgPicture.asset(category.icon, height: 15,width: 15,),
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
  onChangeDropdownItem(ByCatgories selectedCategori) {
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
