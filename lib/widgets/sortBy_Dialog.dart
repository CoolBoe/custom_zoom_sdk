import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/models/mockdata/item_sortby.dart';

class sortByDialog extends StatefulWidget{
  final int num;

  const sortByDialog(int s, {Key key, this.num}) : super(key: key);

  @override
  sortByDialogState createState()=>sortByDialogState();

}

class sortByDialogState extends State<sortByDialog>{
  int value = 0;
  List<SortBy> sortBy = [
    SortBy('Popularity', 0),
    SortBy('Average Rating', 1),
    SortBy("What's New", 2),
    SortBy("Price: Low to High", 3),
    SortBy("Price: high to low", 4)

  ];
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
     return Padding(
       padding: const EdgeInsets.only(left:30.0, right: 30.0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             GestureDetector(
               onTap: (){},
               child:   Text(sortBy[index].name,
                 style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 16.0,
                   fontWeight: FontWeight.w400,),),
             ),
             Theme(data: Theme.of(context).copyWith(
               unselectedWidgetColor: Colors.orange
             ), child: Radio(
               value: index,
               activeColor: Colors.orange,
               groupValue: value,
               onChanged: (val){
                 setState(() {
                   value= val;
                 });
               },
             ),)
           ],
       ),
     );
    }
    , itemCount: sortBy.length,);
  }
}
