import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/widgets/ProgressHUD.dart';

class BasePage extends StatefulWidget{
  ProductModel productModel;
  BasePage({Key key,this.productModel}) : super(key: key);
  @override
  BasePageState createState()=>BasePageState();

}
class BasePageState<T extends BasePage> extends State<BasePage>{
  bool isApiCallProcess = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loaderModel, child){
      return  Scaffold(
          body: ProgressHUD(child: pageUi(), inAsyncCall: isApiCallProcess, opacity: 0.3,)
      );
    });

  }
  Widget pageUi() {
    return null;
  }
  
}