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
    SortBy('Default', 0),
    SortBy('Popularity', 1),
    SortBy("Rating", 2),
    SortBy("Date", 3),
    SortBy("High to Low", 4),
    SortBy("Low to High", 5)

  ];
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
     return Padding(
       padding: const EdgeInsets.only(left:30.0, right: 30.0, top: 5),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             GestureDetector(
               onTap: (){},
               child:   Text(sortBy[index].name,
                 style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 16.0,
                   fontWeight: FontWeight.w400,),),
             ),
             SizedBox(
               height: 20,
               width: 20,
               child: Theme(data: Theme.of(context).copyWith(
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
               ),),
             )
           ],
       ),
     );
    }
    , itemCount: sortBy.length,);
  }
}
