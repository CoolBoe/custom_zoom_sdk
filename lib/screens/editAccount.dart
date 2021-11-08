import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/loader_provider.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';

class EditAccountScreen extends BasePage{

  EditAccountScreen({Key key}) : super(key: key);
  @override
  EditAccountScreenState createState() => EditAccountScreenState();
}
class EditAccountScreenState extends BasePageState<EditAccountScreen>{
  Details model;
  WebApiServices _webApiServices;

  @override
  void initState() {
    _webApiServices = new WebApiServices();
    BasePrefs.init();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget pageUi(){
    return Scaffold(
        appBar: BaseAppBar(context, 'Edit Account', suffixIcon: Container()),
        body: pageBuilder(),
        bottomNavigationBar: customButton(title: "Save", onPressed: (){
          printLog("userDetailsDtata", model.toJson());
          var loader = Provider.of<LoaderProvider>(context, listen: false);
          loader.setLoadingStatus(true);
          _webApiServices.updateBilling(user_id:model.id.toString(),shipping: model.billing).then((value){
            printLog("ghjghjghjghj", value);
            loader.setLoadingStatus(false);
            if(value){
              toast("Data Saved Successfully");
              BasePrefs.setString(USER_MODEL, json.encode(model));
            }else{
              toast(NETWORK_ERROR);
            }
            // _saveForNextUse(title, model);
            loader.setLoadingStatus(false);
          });
        }
        ));
  }

 Widget pageBuilder() {
    BasePrefs.init();

 var value= BasePrefs.getString(USER_MODEL);
 if(value!=null){
   model = Details.fromJson(jsonDecode(value));
 }
    var user= Provider.of<UserProvider>(context, listen: false);
    return Container(
      color: Theme.of(context).backgroundColor,
      height:MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                circularImageView(imageUrl: user.getProfileImage(),
                    onCallback: (value){}),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20, left: 10),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5.0)),
                      color: Theme.of(context).focusColor
                  ),
                  child:Row(
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
                                color:  Theme.of(context).bottomAppBarColor,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(color: Theme.of(context).bottomAppBarColor, spreadRadius: 2),
                                ],
                              ),
                              child:Image.asset("assets/images/ic_user.png", color: Theme.of(context).accentColor,),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              initialValue:model==null ? "Hi User":
                              model.firstName!=null && model.firstName!=""?
                              model.billing.firstName!=null && model.billing.firstName!="" ?
                              "${model.billing.firstName..toUpperCase()}" : "${model.firstName.toUpperCase()}" :
                              "Hi User",
                              style: styleProvider(fontWeight: medium, size: 14, ),
                              onChanged: (value){
                                if(value!=null){
                                  printLog("hghghadadghg", value);
                                  this.model.billing.firstName = value;
                                }else{
                                  printLog("hghghghg", value);
                                  this.model.billing.firstName =  model.billing.firstName;
                                }
                              },
                            ),
                          )
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.edit, size: 15, color: Theme.of(context).accentColor,),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20, left: 10),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5.0)),
                      color: Theme.of(context).focusColor
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
                                color: Theme.of(context).bottomAppBarColor,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(color: Theme.of(context).bottomAppBarColor, spreadRadius: 2),
                                ],
                              ),
                              child:Image.asset(ic_pass_png, color: Theme.of(context).accentColor,),

                            ),
                          ),
                          Text("Password", style: styleProvider(fontWeight: medium, size: 14,),),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.arrow_forward_ios, size: 15,color: Theme.of(context).accentColor,),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20, left: 10),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5.0)),
                      color: Theme.of(context).focusColor
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
                                color: Theme.of(context).bottomAppBarColor,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(color: Theme.of(context).bottomAppBarColor, spreadRadius: 2),
                                ],
                              ),
                              child:Image.asset(ic_email_png, color:Theme.of(context).accentColor,),

                            ),
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              initialValue:model==null ? "Email here":
                              model.email!=null && model.email!=""?
                              model.billing.email!=null && model.billing.email!="" ?
                              "${model.billing.email..toUpperCase()}" : "${model.email.toUpperCase()}" :
                              "Hi User",
                              style: styleProvider(fontWeight: medium, size: 14, ),
                              onChanged: (value){
                                if(value!=null){
                                  printLog("hghghadadghg", value);
                                  this.model.billing.email = value;
                                }else{
                                  printLog("hghghghg", value);
                                  this.model.billing.email =  model.billing.email;
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.arrow_forward_ios, size: 15,color: Theme.of(context).accentColor,),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20, left: 10),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5.0)),
                      color: Theme.of(context).focusColor
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
                                color: Theme.of(context).bottomAppBarColor,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(color: Theme.of(context).bottomAppBarColor, spreadRadius: 2),
                                ],
                              ),
                              child:Image.asset(ic_phone_png,color: Theme.of(context).accentColor,),

                            ),
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none
                                ),
                                initialValue:model==null ? "Mobile here":
                                model.billing.phone!=null && model.billing.phone!="" ? model.billing.phone:
                                "Mobile here",
                                style: styleProvider(fontWeight: medium, size: 14),
                                onChanged: (value){
                                  if(value!=null){
                                    printLog("hghghadadghg", value);
                                    this.model.billing.phone = value;
                                  }else{
                                    printLog("hghghghg", value);
                                    this.model.billing.phone =  model.billing.phone;
                                  }}
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.arrow_forward_ios, size: 15,color: Theme.of(context).accentColor,),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20, left: 10),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5.0)),
                      color: Theme.of(context).focusColor
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
                                color: Theme.of(context).bottomAppBarColor,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(color:Theme.of(context).bottomAppBarColor,spreadRadius: 2),
                                ],
                              ),
                              child:Image.asset(ic_address_png,color: Theme.of(context).accentColor,),

                            ),
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none
                                ),
                                initialValue:model==null ? "Address here":
                                model.billing.address1!=null && model.billing.address1!="" ? model.billing.address1:
                                "Address here",
                                style: styleProvider(fontWeight: medium, size: 14),
                                onChanged: (value){
                                  if(value!=null){
                                    printLog("hghghadadghg", value);
                                    this.model.billing.address1 = value;
                                  }else{
                                    printLog("hghghghg", value);
                                    this.model.billing.address1 =  model.billing.address1;
                                  }}
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.arrow_forward_ios, size: 15,color: Theme.of(context).accentColor,),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only( top: 6, bottom: 6, right: 20, left: 10
                  ),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5.0)),
                      color:Theme.of(context).focusColor
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
                                color: Theme.of(context).bottomAppBarColor,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(color: Theme.of(context).bottomAppBarColor, spreadRadius: 2),
                                ],
                              ),
                              child:Image.asset(ic_globe_png, color: Theme.of(context).accentColor,),

                            ),
                          ),
                          Text("English", style: styleProvider(fontWeight: medium, size: 14),),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.arrow_forward_ios, size: 15,color: Theme.of(context).accentColor,),
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
        ),
      ),
    );
 }
}