import 'package:flutter/material.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';

class PrivacyScreen extends BasePage{
  PrivacyScreen({Key key}) : super(key: key);
  @override
  PrivacyScreenState createState() => PrivacyScreenState();
}
class PrivacyScreenState extends BasePageState<PrivacyScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      appBar: BaseAppBar(context, "Privacy", suffixIcon: Container()),
      body: Container(),
      bottomNavigationBar: customButton(title: "Submit", onPressed: (){
        printLog("Submit", "Setting");
      },),
    );
  }

}