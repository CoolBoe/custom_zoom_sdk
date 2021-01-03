import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/models/mockdata/item_sortby.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/sort_by.dart';
import 'package:wooapp/providers/product.dart';

class sortByDialog extends StatefulWidget {
  final int num;

  const sortByDialog(int s, {Key key, this.num}) : super(key: key);

  @override
  sortByDialogState createState() => sortByDialogState();
}

class sortByDialogState extends State<sortByDialog> {
  int value = 0;
  List<SortBy> _sortByOptions = [
    SortBy('default', "Default", "asc"),
    SortBy('popularity', "Popularity", "asc"),
    SortBy('rating', "Average Rating", "asc"),
    SortBy("date", "What's New", "asc"),
    SortBy("price_asc", "Price: Low to High", "asc"),
    SortBy("price_desc", "Price: high to low", "desc")
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Text(
                  _sortByOptions[index].text,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                width: 20,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(unselectedWidgetColor: Colors.orange),
                  child: Radio(
                    value: index,
                    activeColor: Colors.orange,
                    groupValue: value,
                    onChanged: (val) {
                      setState(() {
                        value = val;
                      });
                      var productList = Provider.of<ProductsProvider>(context, listen: false);
                      productList.resetStreams();
                      productList.setLoadingState(LoadMoreStatus.INITIAL);
                      productList.setSortOrder(_sortByOptions[index]);
                      productList.fetchProducts("1");
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
      itemCount: _sortByOptions.length,
    );
  }
}

