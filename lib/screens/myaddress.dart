import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/cityModel.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/loader_provider.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/delivery.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/cityListBuilder.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class MyAddress extends BasePage{
  MyAddress({Key key}) : super(key: key);
  @override
  MyAddressState createState() => MyAddressState();
}
class MyAddressState extends BasePageState<MyAddress>{

  @override
  void initState() {
    BasePrefs.init();
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      appBar: BaseAppBar(context, "My Address", suffixIcon: Container()),
      body:pageBuilder(),
      bottomNavigationBar:buttonBuilder(),
    );
  }

 Widget pageBuilder() {
    return BasePrefs.getString(MYADDRESSLISTS)==null ? Container(
      child: Column(
        children: [
            Padding(
              padding: const EdgeInsets.all(58.0),
              child: Image.asset(ic_oops_png),
            ),
            Text("Please Add Your Shipping Address", style: styleProvider(fontWeight: semiBold, size: 14, color: black),)
        ],
      ),
    ): SingleChildScrollView();
 }

 Widget buttonBuilder() {
    return BasePrefs.getString(MYADDRESSLISTS)!=null ? customButton(title:"Next", onPressed: (){
      changeScreen(context, DeliveryScreen());
    }): customButton(title: "Add", color: green, onPressed: (){
    changeScreen(context, DeliveryScreen());
    },);
 }
}