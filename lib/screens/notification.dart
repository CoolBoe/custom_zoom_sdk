import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';

class NotificationScreen extends BasePage{
  NotificationScreen({Key key}) : super(key: key);
  @override
  NotificationScreenState createState() => NotificationScreenState();
}
class NotificationScreenState extends BasePageState<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      appBar: BaseAppBar(context, "Noitification Setting", suffixIcon: Container()),
      body: Container(),
      bottomNavigationBar: customButton(title: "Submit", onPressed: (){
        printLog("Submit", "msg");
      },),
    );
  }
}