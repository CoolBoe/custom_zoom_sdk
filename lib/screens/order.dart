import 'package:flutter/material.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';

class OrderScreen extends BasePage{
  OrderScreen({Key key}) : super(key: key);
  @override
  OrderScreenState createState() => OrderScreenState();
}
class OrderScreenState extends BasePageState<OrderScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      appBar: BaseAppBar(context, "My Order", suffixIcon: Container()),
      body: Container(),
      bottomNavigationBar: customButton(title: "Submit", onPressed: (){
        printLog("Submit", "Payment");
      },),
    );
  }

}