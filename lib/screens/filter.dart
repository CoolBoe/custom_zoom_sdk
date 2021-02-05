import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int currentTab = 0;
  int _page=1;
  bool isReset= false;
  List<String> _selectedColors = List();
  List<String> _selectedSizes = List();
  int selectedId;
  var minValue, maxValue;
  Widget currentScreen(int screenId) {
    switch (screenId) {
      case 0:
        return priceFilter();
      case 1:
        return categoryFilter();
      case 2:
        return colorFilter();
      case 3:
        return sizeFilter();
    }
  }
  @override
  void initState() {
   AppProvider.initialize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return pageUi();
  }
  final PageStorageBucket bucket = PageStorageBucket();

  Widget pageUi(){
    return Scaffold(
      appBar: BaseAppBar(context, "Filter", backgroundColor: grey_100,suffixIcon: GestureDetector(onTap: (){
        resetFilter();
      },
      child: Icon(Icons.refresh_sharp),)),
      body: filterUi(),
      bottomNavigationBar: customButton(title: "Apply Filter",onPressed: (){
        var productList = Provider.of<ProductsProvider>(context, listen: false);
        if(!isReset){
          productList.resetStreams();
          productList.setLoadingState(LoadMoreStatus.INITIAL);
          productList.fetchProducts(_page, category_id:selectedId.toString(),min_price: minValue, max_price: maxValue , colorList:jsonEncode(_selectedColors), sizelist: jsonEncode(_selectedSizes));
        }else{
          productList.resetStreams();
          productList.setLoadingState(LoadMoreStatus.INITIAL);
          productList.fetchProducts(_page);
        }
        Navigator.pop(context);
      },
      ),
    );
  }

  Widget filterUi() {
    return  Container(
      color: Colors.white70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 20),
            width: 150,
            color: Colors.grey[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      currentTab = 0;
                    });
                  },
                  child: Container(
                      height: 50,
                      color: currentTab==0?Colors.white:Colors.grey[100],
                      child: Center(child: Text("Price", style: styleProvider(size: 15, fontWeight: medium, ),))),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      currentTab = 1;
                    });
                  },
                  child: Container(
                      height: 50,
                      color:  currentTab==1?Colors.white:Colors.grey[100],
                      child: Center(child: Text("Category", style: styleProvider(size: 15, fontWeight: medium, ),))),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      currentTab = 2;
                    });
                  },
                  child: Container(
                      height: 50,
                      color:  currentTab==2?Colors.white:Colors.grey[100],
                      child: Center(child: Text(_selectedColors.length>0 ? "Color (${_selectedColors.length})" : "Color", style: styleProvider(size: 15, fontWeight: medium, ),))),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      currentTab = 3;
                    });
                  },
                  child: Container(
                      height: 50,
                      color: currentTab==3?Colors.white:Colors.grey[100],
                      child: Center(child: Text(_selectedSizes.length>0 ? "Size (${_selectedSizes.length})" : "Size", style: styleProvider(size: 15, fontWeight: medium, ),))),
                ),
              ],
            ),
          ),
          Container(
            child: PageStorage(
              child: currentScreen(currentTab),
              bucket: bucket,
            ),
          ),
        ],
      ),
    );
  }

  Widget priceFilter(){
    return new Consumer<AppProvider>(builder: (context, app, child){
      if(app.priceRange!=null){
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Minimum Price"),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(dp5)),
                          border: Border.all(color: Colors.grey[400], width: 0.5),
                        ),
                        child: new TextField(
                         keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration.collapsed(
                            hintText: app.priceRange.min.toString(),
                            hintStyle: styleProvider(size: 14, color: Colors.grey, fontWeight: medium)
                          )
                          ..applyDefaults(Theme.of(context).inputDecorationTheme),
                          onChanged: (value){
                            setState(() {
                              minValue = value;
                              printLog("gygghjh", minValue);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("Maximum Price"),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(dp5)),
                          border: Border.all(color: Colors.grey[400], width: 0.5),
                        ),
                        child: new TextField(
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration.collapsed(
                              hintText: app.priceRange.max.toString(),
                              hintStyle: styleProvider(size: 14, color: Colors.grey, fontWeight: medium)
                          )
                            ..applyDefaults(Theme.of(context).inputDecorationTheme),
                          onChanged: (value){
                            setState(() {
                              maxValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }else{
        return progressBar(context, accent_color);
      }
    });
  }

  Widget categoryFilter(){
    return Container(
      child: new Consumer<CategoriesProvider>(builder: (context, app, child){
        if(app.allCategories!=null && app.allCategories.length>0){
          return Expanded(child: Container(
            child:ListView.builder(
              itemBuilder: (context, index) {
                return RadioListTile(
                  value: app.allCategories[index].id,
                  dense: false,
                  groupValue: selectedId,
                  onChanged: (ind){
                    setState(() {
                      selectedId = ind;
                    });
                    printLog("valueSelected",selectedId);
                    },
                  title: Text(app.allCategories[index].name),
                );
              },
              itemCount:app.allCategories.length,
            )
          ));
        }else{
          return Expanded(child: progressBar(context, accent_color));
        }
    },
      ));
  }

  void _onColorSelected(bool selected, slug) {
    if (selected == true) {
      setState(() {
        _selectedColors.add(slug);
      });
    } else {
      setState(() {
        _selectedColors.remove(slug);
      });
    }
  }
  void _onSizeSelected(bool selected, slug) {
    if (selected == true) {
      setState(() {
        _selectedSizes.add(slug);
      });
    } else {
      setState(() {
        _selectedSizes.remove(slug);
      });
    }
  }
  Widget colorFilter(){
    return Container(
      child: new Consumer<AppProvider>(builder: (context, app, child){
        if(app.getColorList!=null && app.getColorList.length>0){
          return Expanded(child: Container(
            child: ListView.builder(itemBuilder: (context, index){
              return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(app.getColorList[index].name, style: styleProvider(color: Colors.black),),
                  value: _selectedColors.contains(app.getColorList[index].slug),
                  onChanged: (bool selected){
                    _onColorSelected(selected,
                        app.getColorList[index].slug);
                    printLog("fgfagdghag", _selectedColors);
                  });
            },
            itemCount: app.getColorList.length,),
          ));
        }else{
          return Container();
        }
      }),
    );
  }
  Widget sizeFilter(){
    return Container(
      child: new Consumer<AppProvider>(builder: (context, app, child){
        if(app.getSizeList!=null && app.getSizeList.length>0){
          return Expanded(child: Container(
            child: ListView.builder(itemBuilder: (context, index){
              return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(app.getSizeList[index].name, style: styleProvider(color: Colors.black),),
                  value: _selectedSizes.contains(app.getSizeList[index].slug),
                  onChanged: (bool selected){
                    _onSizeSelected(selected,
                        app.getSizeList[index].slug);
                    printLog("fgfagdghag", _selectedSizes);
                  });
            },
              itemCount: app.getSizeList.length,),
          ));
        }else{
          return Container();
        }
      }),
    );
  }

  void resetFilter() {
    setState(() {
      selectedId = 0;
      _selectedColors = [];
      _selectedSizes = [];
    });
  }
}
