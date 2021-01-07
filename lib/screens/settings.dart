import 'package:flutter/material.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';

class SettingScreen extends BasePage{
  SettingScreen({Key key}) : super(key: key);
  @override
  SettingScreenState createState() => SettingScreenState();
}
class SettingScreenState extends BasePageState<SettingScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      appBar: BaseAppBar(context, "Setting", suffixIcon: Container()),
      body: Container(),
      bottomNavigationBar: customButton(title: "Submit", onPressed: (){
        printLog("Submit", "Setting");
      },),
    );
  }

}