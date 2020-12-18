import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/mockdata/item_categories.dart';
import 'package:wooapp/widgets/loading.dart';

class sortByDropMenu extends StatefulWidget{
  List<CategoryModel> categoryList;
  final ValueChanged<CategoryModel> onChanged;
  CategoryModel defaultValue ;
  String hint;
  sortByDropMenu({
    Key key,
    this.defaultValue,
    this.categoryList,
    this.onChanged,
    this.hint})
      : super(key: key);

  @override
  sortByDropMenuState createState()=>sortByDropMenuState();

}

class sortByDropMenuState extends State<sortByDropMenu>{
  List<CategoryModel> byCatgories;
  CategoryModel selectedItem;

  List<DropdownMenuItem<CategoryModel>> _dropdownMenuItems;
  @override
  void initState() {
    super.initState();
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
              child: DropdownButton<CategoryModel>(
                items: widget.categoryList.map((model) {
                  var imageUrl='https://app.democontentphoeniixx.com/wp-content/uploads/2020/01/w1.jpeg';
                  if(model.image!=null){
                    imageUrl = model.image.src;
                  }
                  return new DropdownMenuItem<CategoryModel>(
                    value: model,
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Image.network(imageUrl, height: 15, width: 15),
                          Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Text(model.name, style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w400
                            ),),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                value: selectedItem == null ? widget.defaultValue : selectedItem,
                isExpanded: true,
                onChanged: (CategoryModel model){
                   setState(() {
                     selectedItem=  model;
                  });
                  printLog("datahh", model.id.toString());
                  widget.onChanged(model);
                },
                hint: Text(widget.hint, style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.w400
                ),),
                underline: Container(),
              )
            ),
          ),
        ),
      ) ;
  }
}

