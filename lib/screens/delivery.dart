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
import 'package:wooapp/models/myAddressLists.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/checkout.dart';
import 'package:wooapp/screens/myaddress.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/cityListBuilder.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class DeliveryScreen extends BasePage{
  String total;
   DeliveryScreen({Key key, this.total}) : super(key: key);
  @override
  DeliveryScreenState createState() => DeliveryScreenState();
}
class DeliveryScreenState extends BasePageState<DeliveryScreen>{
  int _currentStep = 0;
  CartModel cartData = CartModel();
  GlobalKey<FormState> shippingForm = GlobalKey<FormState>();
  GlobalKey<FormState> billingForm = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  int value = 0;
  WebApiServices _webApiServices;
  Details userDetails;
  String msg;
  String discount_total;
  String cart_subtotal;
  String taxes;
  String total;
  String title;
  String totalAmount;
  AppProvider app;

  @override
  void initState() {
    _webApiServices = new WebApiServices();
    BasePrefs.init();
    app = Provider.of<AppProvider>(context, listen: false);
    app.fetchStateLIst(states: "IN");
    super.initState();
  }
  @override
  Widget pageUi() {
    return Scaffold(
      key: scaffoldState,
      appBar: BaseAppBar(context, "Delivery Information", suffixIcon: Container()),
      body:stepper(),
      bottomNavigationBar: customButton(title: "Update",onPressed: (){
        if(!saveShippingForm()){
        toast("please complete above details");
        }else{
            var loader = Provider.of<LoaderProvider>(context, listen: false);
            loader.setLoadingStatus(true);
           _webApiServices.updateBilling(user_id:userDetails.id.toString(), billing_email: userDetails.billing.email, billing_phone:userDetails.billing.phone,
            billing_address_1: userDetails.billing.address1, billing_address_2:userDetails.billing.address2,
            billing_city:userDetails.billing.city, billing_company: "", billing_country: userDetails.billing.country,
            billing_first_name:userDetails.billing.firstName, billing_last_name: userDetails.billing.lastName,
            billing_postcode:userDetails.billing.postcode, billing_state: userDetails.billing.state, checkbox: false).then((value){
             toast(value.msg);
            if(value.status==1){
              Details details = value.details;
              BasePrefs.setString(USER_MODEL, json.encode(details));
              changeScreen(context, CheckOutScreen(totalAmount: widget.total));
              printLog("datafat", details.toJson().toString());
            }


             // _saveForNextUse(title, model);
             loader.setLoadingStatus(false);
           });
        }

      },),
    );
  }
  Widget orderBuilder() {
    return Container(
      child: new Consumer<UserProvider>(builder: (context, model, child) {
        if (model.userModel != null) {
          printLog("userData", BasePrefs.getString(USER_MODEL));
          return Container();
        } else {
          return progressBar(context, orange);
        }
      }),
    );
  }
  Widget stepper(){
    return new Consumer<AppProvider>(builder: (context, model, child){
      printLog("getCityList", model.getCityList);
      if(model.getCityList!=null && model.getCityList.length>0){
        return stepperBuilder(model.getCityList);
      }else{
        return progressBar(context, orange);
      }
    });
  }
  Widget stepperBuilder(List<CityModel> list){
    BasePrefs.init();
    var value= BasePrefs.getString(USER_MODEL);
    userDetails = Details.fromJson(jsonDecode(value));
    return SingleChildScrollView(
      child: new Form(
          key: shippingForm,
          child:  Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel("First Name", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                FormHelper.textInput(context, userDetails.billing.firstName, (value){
                  printLog("firstNamgge", value);
                  if(value==null){
                    userDetails.billing.firstName = userDetails.billing.firstName;
                  }else{
                    userDetails.billing.firstName = value;
                  }
                }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                  if(value.toString().isEmpty){
                    return "please enter valid name";
                  }return null;
                }),
                FormHelper.fieldLabel("Last Name", regular, 10, color: grey),
                FormHelper.textInput(context, userDetails.billing.lastName, (value){
                  if(value==null){
                    userDetails.billing.lastName = userDetails.billing.lastName;
                  }else{
                    userDetails.billing.lastName = value;
                  }
                }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                  if(value.toString().isEmpty){
                    return "please enter valid last name";
                  }return null;
                }),
                FormHelper.fieldLabel("Email", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                FormHelper.textInput(context, userDetails.billing.email, (value){
                  if(value==null){
                    userDetails.billing.email = userDetails.billing.email;
                  }else{
                    userDetails.billing.email = value;
                  }
                }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                  if(value.toString().isEmpty){
                    return "please enter valid email id";
                  }return null;
                }),
                FormHelper.fieldLabel("Phone Number", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                FormHelper.textInput(context, userDetails.billing.phone, (value){
                  if(value==null){
                    userDetails.billing.phone = userDetails.billing.phone;
                  }else{
                    userDetails.billing.phone = value;
                  }
                }, isTextArea: true, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                  if(value.toString().isEmpty || value.toString().length!=10){
                    return "please enter valid phone";
                  }return null;
                }),
                FormHelper.fieldLabel("Country", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: cityDropList(
                        cityList:countryList ,
                        hint: "Select Country",
                        onChanged: (model){
                          if(model!=null){
                            userDetails.billing.country = model.name;
                            printLog("onChanged", model.id);
                          }else{
                            return "please choose country name";
                          }
                        })),
                FormHelper.fieldLabel("State/Provision", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: cityDropList(
                        hint: "Select State",
                        cityList: list,
                        onChanged: (model){
                          if(model!=null){
                            userDetails.billing.state = model.name;
                            printLog("onChanged", model.id);

                          }else{
                            return "please choose state name";
                          }
                        })),
                FormHelper.fieldLabel("City", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                FormHelper.textInput(context,userDetails.billing.city, (value){
                  if(value==null){
                    userDetails.billing.city = userDetails.billing.city;
                  }else{
                    userDetails.billing.city = value;
                  }
                }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                  if(value.toString().isEmpty){
                    return "please enter valid city";
                  }return null;
                }),
                FormHelper.fieldLabel("Post Code", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                FormHelper.textInput(context, userDetails.billing.postcode, (value){
                  if(value==null){
                    userDetails.billing.postcode = userDetails.billing.postcode;
                  }else{
                    userDetails.billing.postcode = value;
                  }
                }, isTextArea: true, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                  if(value.toString().isEmpty || value.toString().length != 6){
                    return "please enter valid postcode";
                  }return null;
                }),
                FormHelper.fieldLabel("Address Line 1", regular, 10, color: grey,prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                FormHelper.textInput(context, userDetails.billing.address1, (value){
                  if(value==null){
                    userDetails.billing.address1 = userDetails.billing.address1;
                  }else{
                    userDetails.billing.address1 = value;
                  }
                }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                  if(value.toString().isEmpty){
                    return "please enter valid address";
                  }return null;
                }),
                FormHelper.fieldLabel("Address Line 2", regular, 10, color: grey),
                FormHelper.textInput(context, userDetails.billing.address2, (value){
                  if(value==null){
                    userDetails.billing.address2 = userDetails.billing.address2;
                  }else{
                    userDetails.billing.address2 = value;
                  }
                }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                  printLog("onValidate", value);
                }),
                SizedBox(height: 30,)
              ],
            ),
          )),
    );
  }

  bool saveShippingForm(){
    final form = shippingForm.currentState;
    bool value;
    if(form.validate()){
      form.save();
      value = true;
    }else{
      value = false;
    }
    printLog("saveShippingForm", value);
    return value;
  }
  void _saveForNextUse(String title, UserModel userModel) {
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(userModel.msg,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                    height: 35,
                                    margin: EdgeInsets.zero,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 25,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding:
                              EdgeInsets.only(left: 00, top: 10, right: 00),
                              child: Container(
                                  width: 150,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        printLog("fghfhgh", userModel);
                                        BasePrefs.init();
                                       var address =  BasePrefs.getString(MYADDRESSLISTS)!=null ? BasePrefs.getString(MYADDRESSLISTS) : null;
                                       if(address!=null){
                                         var add = BasePrefs.getString(MYADDRESSLISTS);
                                         var datad = json.decode(add);
                                         Iterable l = datad;
                                         List<MyAddressList> model = List<MyAddressList>.from(l.map((model)=> MyAddressList.fromJson(model)));
                                         List<MyAddressList> list = model;
                                         MyAddressList address = new MyAddressList(title: title, userModel: userModel);
                                         list.add(address);
                                         BasePrefs.setString(MYADDRESSLISTS, json.encode(list));
                                         var data = BasePrefs.getString(MYADDRESSLISTS);
                                       }else{
                                         List<MyAddressList> list = [];
                                         MyAddressList address = new MyAddressList(title: title, userModel: userModel);
                                         list.add(address);
                                         BasePrefs.setString(MYADDRESSLISTS, jsonEncode(list));
                                         var data = BasePrefs.getString(MYADDRESSLISTS);
                                         printLog("MYADDRESSLISTS", data);
                                       }
                                         },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 35.0,
                                              right: 35,
                                              top: 5,
                                              bottom: 5),
                                          child: Center(
                                            child: Text('Yes',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))),
                          Padding(
                              padding:
                              EdgeInsets.only(left: 00, top: 10, right: 00),
                              child: Container(
                                  width: 150,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        child: Center(
                                          child: Text('Not Really',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position:
            Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
            child: child,
          );
        });
  }
}