import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/utils/widget_helper.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: AlertDialog(
          content: CircularProgressIndicator(),
        ));
  }
}

void loading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: CircularProgressIndicator(),
      );
    },
  );
}

void toast(Object msg) {
  Fluttertoast.showToast(
    msg: msg.toString(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black
    // timeInSecForIosWeb: 2
  );
}

void printLog(String tag, Object msg) {
  if (msg != null) {
    if (tag != null || tag.trim().isEmpty) {
      print(tag + " => " + msg.toString());
    }
  }
}

void snackBar(String msg) {
  SnackBar(
      content: Text(
    msg,
    style: TextStyle(color: Colors.white, fontSize: 20),
  ));
}

void fieldFocusChange(
    BuildContext context, FocusNode currentfocus, FocusNode nextfocus) {
  currentfocus.unfocus();
  FocusScope.of(context).requestFocus(nextfocus);
}

class ShimmerList extends StatelessWidget{
  String listType;
  ShimmerList({Key key,this.listType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch(listType){
      case "List":
        return ShimmerListBuilder();
        break;
      case "Grid":
        return ShimmerGridBuilder(context);
        break;
      case "Order":
        return ShimmerOrderBuilder();
        break;
      case "Category":
        return ShimmerCategoryBuilder();
        break;
      case "Home":
        return ShimmerHomeBuilder(context);
        break;

    }

  }
}

Widget ShimmerHomeBuilder(BuildContext context){
  return Shimmer.fromColors(
      baseColor: Colors.grey[200], highlightColor: Colors.white,
    child: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: ShimmerCategoryBuilder(),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 250,
              child: ShimmerGridBuilder(context),
            )
          ],
        ),
      ),
    ),
  );
}

Widget ShimmerListBuilder(){
  return Container(
    height: 290,
    child: ListView.builder(
        itemCount:3,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Shimmer.fromColors(
                child: ShimmerProductItem(), baseColor: Colors.grey[200], highlightColor: Colors.white),
          );
        }),
  );
}
Widget ShimmerOrderBuilder(){
  printLog("dadtdtd", "msg");
  return ListView.builder(
      itemCount:10,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index){
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Shimmer.fromColors(
              child: ShimmerOrderItem(), baseColor: Colors.grey[200], highlightColor: Colors.white),
        );
      });
}
Widget ShimmerGridBuilder(BuildContext context){
  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height / 1.32 - kToolbarHeight - 15) / 2;
  final double itemWidth = size.width / 2;
  return GridView.count(
    shrinkWrap: true,
    crossAxisCount: 2,
    padding: EdgeInsets.zero,
    childAspectRatio: (itemWidth / itemHeight),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    physics: ClampingScrollPhysics(),
    children:List.generate(10, (index) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Shimmer.fromColors(
            child: ShimmerProductItem(), baseColor: Colors.grey[200], highlightColor: Colors.white),
      );
    })
  );
}
Widget ShimmerCategoryBuilder(){
  return Container(
    height: 80,
    child: ListView.builder(
        itemCount:10,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Shimmer.fromColors(
                child: ShimmerCategoryItem(), baseColor: Colors.grey[200], highlightColor: Colors.white),
          );
        }),
  );
}
Widget ShimmerProductItem(){
  return Container(
    width: 130,
    decoration: BoxDecoration(
        border: Border.all(
          width: 0.1,
          color: accent_color,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    child: Column(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.grey
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 15,
          color: Colors.grey,
        ),
        SizedBox(
          height: 5,
        ),Container(
          height: 15,
          color: Colors.grey,
        ),
        SizedBox(height: 5,),
        Container(
          height: 15,
          color: Colors.grey,
        ),
      ],
    ),
  );
}
Widget ShimmerOrderItem(){
  return Container(
    decoration: BoxDecoration(
        borderRadius:
        BorderRadius.all(Radius.circular(dp10))
    ),
    height: 120,
    child: Row(
      children: <Widget>[
        Container(
          width: 120,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          )
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Container(height: 10,
             color: Colors.grey,),
              SizedBox(height: 5,),
              Container(height: 10,
                color: Colors.grey,),
              SizedBox(height: 5,),
              Container(height: 10,
                color: Colors.grey,),
            ],
          ),
        ),
      ],
    ),
  );
}
Widget ShimmerCategoryItem(){
  return Container(
      margin: EdgeInsets.only(left: 10),
      width: 80,
      height: 20,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10))
      )
  );
}

Widget somethingWentWrong(){
  return Container(
    child: Column(
      children: [
        Image.asset(ic_oops_png),
        SizedBox(height: 10,),
        Text(NETWORK_ERROR, style: styleProvider(fontWeight: medium,size: 14, color: black),)
      ],
    ),
      );
}

Widget dataNotFound(){
  return Container(
    child: Column(
      children: [
        Image.asset(ic_nodata_png),
        SizedBox(height: 10,),
        Text(DATA_NOT_FOUND, style: styleProvider(fontWeight: medium,size: 14, color: black),)
      ],
    ),
  );
}