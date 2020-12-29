import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/models/mockdata/item_sortby.dart';

class sortBySizeBuilder extends StatefulWidget {
  final int num;

  const sortBySizeBuilder({Key key, this.num}) : super(key: key);

  @override
  sortBySizeBuilderState createState() => sortBySizeBuilderState();
}

class sortBySizeBuilderState extends State<sortBySizeBuilder> {
  int value = 0;
  bool selectedColor = false;
  int _selectItem = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 13;
    final double itemWidth = size.width / 2;
    int selectedItem = 0;
    List<SortBy> sortBy = [
      SortBy(
        "XS",
        0,
      ),
      SortBy("S", 1),
      SortBy("M", 2),
      SortBy("L", 3),
      SortBy("XL", 4),
      SortBy("XXL", 5),
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30),
      child: Container(
        height: 80.0,
        child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: sortBy.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectItem = index;
                    debugPrint(selectedItem.toString());
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          _selectItem == index ? Colors.orange : Colors.white,
                      border: Border.all(color: Colors.grey[100], width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Center(
                      child: Text(
                    sortBy[index].name,
                    style: TextStyle(
                        color:
                            _selectItem == index ? Colors.white : Colors.black),
                    textAlign: TextAlign.center,
                  )),
                ),
              );
            }),
      ),
    );
  }
}
