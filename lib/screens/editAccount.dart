import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
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
      body: pageBuilder(),
      bottomNavigationBar: customButton(title: "Save", onPressed: (){
    printLog("click", "Save");}
    ));
}

 Widget pageBuilder() {
    BasePrefs.init();
 var value= BasePrefs.getString(USER_MODEL);
 Details model = Details.fromJson(jsonDecode(value));
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
         circularImageView(imageUrl: model!=null ? model.avatarUrl : "",
           onCallback: (value){}),
           SizedBox(
             height: 30,
           ),
          Container(
            padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200]
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:6.0, top: 6, bottom: 6, right: 20),
                      child: Container(
                        width: 30,
                        height: 30,
                        padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(color: Colors.grey[50], spreadRadius: 2),
                          ],
                        ),
                        child:Image.asset("assets/images/ic_user.png"),

                      ),
                    ),
                    Text(model.billing.firstName, style: styleProvider(fontWeight: medium, size: 14, color: black),),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.edit, size: 15,),
                )
              ],
            ),
          ),
           SizedBox(
             height: 10,
           ),
           Container(
             padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20),
             decoration: BoxDecoration(
                 color: Colors.grey[200]
             ),
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left:6.0, top: 6, bottom: 6, right: 20),
                       child: Container(
                         width: 30,
                         height: 30,
                         padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                         decoration: BoxDecoration(
                           color: white,
                           borderRadius: BorderRadius.circular(5),
                           boxShadow: [
                             BoxShadow(color: Colors.grey[50], spreadRadius: 2),
                           ],
                         ),
                         child:Image.asset("assets/images/ic_user.png"),

                       ),
                     ),
                     Text("Password", style: styleProvider(fontWeight: medium, size: 14, color: black),),
                   ],
                 ),

                 Padding(
                   padding: const EdgeInsets.only(right: 10),
                   child: Icon(Icons.arrow_forward_ios, size: 15,),
                 )
               ],
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Container(
             padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20),
             decoration: BoxDecoration(
                 color: Colors.grey[200]
             ),
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left:6.0, top: 6, bottom: 6, right: 20),
                       child: Container(
                         width: 30,
                         height: 30,
                         padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                         decoration: BoxDecoration(
                           color: white,
                           borderRadius: BorderRadius.circular(5),
                           boxShadow: [
                             BoxShadow(color: Colors.grey[50], spreadRadius: 2),
                           ],
                         ),
                         child:Image.asset("assets/images/ic_user.png"),

                       ),
                     ),
                     Text(model.email, style: styleProvider(fontWeight: medium, size: 14, color: black),),
                   ],
                 ),

                 Padding(
                   padding: const EdgeInsets.only(right: 10),
                   child: Icon(Icons.arrow_forward_ios, size: 15,),
                 )
               ],
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Container(
             padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20),
             decoration: BoxDecoration(
                 color: Colors.grey[200]
             ),
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left:6.0, top: 6, bottom: 6, right: 20),
                       child: Container(
                         width: 30,
                         height: 30,
                         padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                         decoration: BoxDecoration(
                           color: white,
                           borderRadius: BorderRadius.circular(5),
                           boxShadow: [
                             BoxShadow(color: Colors.grey[50], spreadRadius: 2),
                           ],
                         ),
                         child:Image.asset("assets/images/ic_user.png"),

                       ),
                     ),
                     Text(model.billing.phone, style: styleProvider(fontWeight: medium, size: 14, color: black),),
                   ],
                 ),

                 Padding(
                   padding: const EdgeInsets.only(right: 10),
                   child: Icon(Icons.arrow_forward_ios, size: 15,),
                 )
               ],
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Container(
             padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20),
             decoration: BoxDecoration(
                 color: Colors.grey[200]
             ),
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left:6.0, top: 6, bottom: 6, right: 20),
                       child: Container(
                         width: 30,
                         height: 30,
                         padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                         decoration: BoxDecoration(
                           color: white,
                           borderRadius: BorderRadius.circular(5),
                           boxShadow: [
                             BoxShadow(color: Colors.grey[50], spreadRadius: 2),
                           ],
                         ),
                         child:Image.asset("assets/images/ic_user.png"),

                       ),
                     ),
                     Text(model.billing.address1, style: styleProvider(fontWeight: medium, size: 14, color: black),),
                   ],
                 ),

                 Padding(
                   padding: const EdgeInsets.only(right: 10),
                   child: Icon(Icons.arrow_forward_ios, size: 15,),
                 )
               ],
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Container(
             padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20),
             decoration: BoxDecoration(
                 color: Colors.grey[200]
             ),
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left:6.0, top: 6, bottom: 6, right: 20),
                       child: Container(
                         width: 30,
                         height: 30,
                         padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                         decoration: BoxDecoration(
                           color: white,
                           borderRadius: BorderRadius.circular(5),
                           boxShadow: [
                             BoxShadow(color: Colors.grey[50], spreadRadius: 2),
                           ],
                         ),
                         child:Image.asset("assets/images/ic_user.png"),

                       ),
                     ),
                     Text("Engish", style: styleProvider(fontWeight: medium, size: 14, color: black),),
                   ],
                 ),

                 Padding(
                   padding: const EdgeInsets.only(right: 10),
                   child: Icon(Icons.arrow_forward_ios, size: 15,),
                 )
               ],
             ),
           ),
           SizedBox(
             height: 10,
           ),
         ],
       ),
      ),
    );
 }
}