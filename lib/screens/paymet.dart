import 'package:flutter/material.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';

class PaymentScreen extends BasePage{
  PaymentScreen({Key key}) : super(key: key);
  @override
  PaymentScreenState createState() => PaymentScreenState();
}
class PaymentScreenState extends BasePageState<PaymentScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      appBar: BaseAppBar(context, "Payment Method", suffixIcon: Container()),
      body: Container(),
      bottomNavigationBar: customButton(title: "Submit", onPressed: (){
        printLog("Submit", "Payment");
      },),
    );
  }

}