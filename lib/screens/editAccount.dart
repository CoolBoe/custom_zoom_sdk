import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';

class EditAccountScreen extends StatefulWidget{

  const EditAccountScreen({Key key}) : super(key: key);
  @override
  EditAccountScreenState createState() => EditAccountScreenState();
}
class EditAccountScreenState extends State<EditAccountScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(context, 'Edit Account', suffixIcon: Container()),
      body: Container(),
      bottomNavigationBar: GestureDetector(onTap: (){},
      child:   customButton(title: "Save", onPressed: (){
        printLog("click", "Save");
      },),)
    );
  }

}