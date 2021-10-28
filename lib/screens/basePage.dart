import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/widgets/ProgressHUD.dart';
import 'package:wooapp/widgets/loading.dart';

class BasePage extends StatefulWidget{
  ProductModel productModel;
  String categoryId;
  BasePage({Key key,this.productModel, this.categoryId}) : super(key: key);

  get total => null;
  @override
  BasePageState createState()=>BasePageState();

}
class BasePageState<T extends BasePage> extends State<BasePage>{
  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loaderModel, child){
      printLog("BasePage", loaderModel.isApiCallProcess);
      return  Scaffold(
          body: ProgressHUD(child: pageUi(), inAsyncCall: loaderModel.isApiCallProcess, opacity: 0.3,)
      );
    });
  }
  Widget pageUi() {
    return null;
  }
}