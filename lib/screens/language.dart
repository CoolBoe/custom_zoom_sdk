import 'package:flutter/material.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';

class LanguageScreen extends BasePage{
  LanguageScreen({Key key}) : super(key: key);
  @override
  LanguageScreenState createState() => LanguageScreenState();
}
class LanguageScreenState extends BasePageState<LanguageScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      appBar: BaseAppBar(context, "Languages"),
      body: Container(),
      bottomNavigationBar: customButton(title: "Submit", onPressed: (){
        printLog("Submit", "Languages");
      },),
    );
  }

}