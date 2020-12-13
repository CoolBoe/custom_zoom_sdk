import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/models/mockdata/item_colorpicker.dart';

class sortByColorPicker extends StatefulWidget{
  final int num;

  const sortByColorPicker( {Key key, this.num}) : super(key: key);

  @override
  sortByColorPickerState createState()=>sortByColorPickerState();

}

class sortByColorPickerState extends State<sortByColorPicker>{
  int value = 0;
  int selectedColor=0;
  @override
  Widget build(BuildContext context) {
    List<ColorBy> sortBy = [
      ColorBy(Colors.green, Colors.green[100],false),
      ColorBy(Colors.orange, Colors.orange[100], false),
      ColorBy(Colors.blue, Colors.blue[100], false),
      ColorBy(Colors.grey, Colors.grey[100], false),
      ColorBy(Colors.red, Colors.red[100], false),
      ColorBy(Colors.yellow, Colors.yellow[100], false),

    ];
    return Container(
      height: 50.0,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(onTap: (){
            setState(() {
             selectedColor=index;
            });
          },
          child:  Container(
            height: 30,
            width: 30,
            padding: EdgeInsets.only(left: 10, right: 10),
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: ShapeDecoration(
                color: sortBy[index].centerColor,
                shape: CircleBorder(
                    side: BorderSide(width: 6,
                        color: selectedColor==index ? sortBy[index].centerColor: sortBy[index].borderColor )
                )
            ),
          ));
        },itemCount: sortBy.length,
        ),
    );
  }
}