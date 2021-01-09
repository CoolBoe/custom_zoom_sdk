import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/cityModel.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/cityListBuilder.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class DeliveryScreen extends BasePage{
   DeliveryScreen({Key key}) : super(key: key);
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
  String msg;
  String discount_total;
  String cart_subtotal;
  String taxes;
  String total;
  Shipping shippingModel;
  Billing billingModel;
  String totalAmount;
  AppProvider app;
  String shipping_Flat;
  String shipping_Free;
  @override
  void initState() {
    // TODO: implement initState
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.getCartData();
    app = Provider.of<AppProvider>(context, listen: false);
    app.fetchStateLIst(states: "IN");
    shippingModel = new Shipping();
    billingModel = new Billing();
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      key: scaffoldState,
      appBar: BaseAppBar(context, "Delivery Information", suffixIcon: Container()),
      body: orderBuilder(),
    );
  }
  Widget orderBuilder() {
    return Container(decoration: BoxDecoration(color: Colors.white),
      child: new Consumer<CartProvider>(builder: (context, cartModel, child) {
        if (cartModel.getCart != null) {
          cartData = cartModel.getCart;
          discount_total = getValidString(cartData.discountTotal);
          cart_subtotal = getValidString(cartData.cartSubtotal);
          taxes  = getValidString(cartData.taxes);
          total = getValidString(cartData.total);
          shipping_Flat= cartData.shippingMethod!=null && cartData.shippingMethod.length>0 ? getValidString(cartData.shippingMethod[0].shippingMethodPrice) : "00.00";
          shipping_Free= cartData.shippingMethod!=null && cartData.shippingMethod.length>1 ? getValidString(cartData.shippingMethod[1].shippingMethodPrice) : "00.00";
          return stepper();
        } else {
          return progressBar(context, orange);
        }
      }),
    );
  }
  Widget stepper(){
    return new Consumer<AppProvider>(builder: (context, model, child){
      printLog("getCityList", model.getCityList);
      if(model.getCityList!=null &&
          model.getCityList.length>0
      ){

        return stepperBuilder(model.getCityList);
      }else{
        return progressBar(context, orange);
      }
    });
  }
  Widget stepperBuilder(List<CityModel> list){
    printLog("stateList", list);
    return Container(
      child: Theme(data: ThemeData(primaryColor: orange), child:  new Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        physics: ClampingScrollPhysics(),
        controlsBuilder: _createEventControlBuilder,
        onStepTapped: (int step) => setState(() => _currentStep = step),
        onStepContinue:  _currentStep < 2 ? () => saveShippingForm() : null,
        onStepCancel: _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
        steps: <Step>[
          new Step(
            title: new Text('Delivery \nAddress',style: styleProvider(fontWeight: medium, size: 10, color: black),),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
            content:new Form(
                key: shippingForm,
                child:  Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormHelper.fieldLabel("First Name", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                      FormHelper.textInput(context, "", (value){
                        shippingModel.firstName = value;
                      }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                        if(value.toString().isEmpty){
                          return "please enter valid name";
                        }return null;
                      }),
                      FormHelper.fieldLabel("Last Name", regular, 10, color: grey),
                      FormHelper.textInput(context, "", (value){
                        shippingModel.lastName = value;
                      }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                        if(value.toString().isEmpty){
                          return "please enter valid last name";
                        }return null;
                      }),
                      FormHelper.fieldLabel("Email", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                      FormHelper.textInput(context, "", (value){
                        shippingModel.email = value;
                      }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                        if(value.toString().isEmpty){
                          return "please enter valid email id";
                        }return null;
                      }),
                      FormHelper.fieldLabel("Phone Number", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                      FormHelper.textInput(context, "", (value){
                        shippingModel.phone = value;
                      }, isTextArea: true, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                        if(value.toString().isEmpty){
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
                                  printLog("onChanged", model.id);
                                  billingModel.country = model.name;
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
                                  printLog("onChanged", model.id);
                                  billingModel.state = model.name;
                                }else{
                                  return "please choose state name";
                                }
                              })),
                      FormHelper.fieldLabel("City", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                      FormHelper.textInput(context, "", (value){
                        shippingModel.city = value;
                      }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                        if(value.toString().isEmpty){
                          return "please enter valid city";
                        }return null;
                      }),
                      FormHelper.fieldLabel("Post Code", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                      FormHelper.textInput(context, "", (value){
                        shippingModel.postcode = value;
                      }, isTextArea: true, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                        if(value.toString().isEmpty || value.toString().length != 6){
                          return "please enter valid postcode";
                        }return null;
                      }),
                      FormHelper.fieldLabel("Address Line 1", regular, 10, color: grey,prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
                      FormHelper.textInput(context, "", (value){
                        shippingModel.address1 = value;
                      }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                        if(value.toString().isEmpty || value.toString().length != 6){
                          return "please enter valid address";
                        }return null;
                      }),
                      FormHelper.fieldLabel("Address Line 2", regular, 10, color: grey),
                      FormHelper.textInput(context, "", (value){
                        shippingModel.address2= value;
                      }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
                        printLog("onValidate", value);
                      }),
                      SizedBox(height: 30,)
                    ],
                  ),
                )),
          ),
          // new Step(
          //   title: new Text('Billing',style: styleProvider(fontWeight: medium, size: 10, color: black)),
          //   isActive: _currentStep >= 0,
          //   state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
          //   content:  Form(
          //     key: billingForm,
          //     child: Container(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           FormHelper.fieldLabel("First Name", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
          //           FormHelper.textInput(context, "",  (value){
          //             billingModel.firstName= value;
          //           }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
          //             if(value.toString().isEmpty){
          //               toast("please enter valid name");
          //             }return null;
          //           }),
          //           FormHelper.fieldLabel("Last Name", regular, 10, color: grey),
          //           FormHelper.textInput(context, "",  (value){
          //             billingModel.lastName= value;
          //           }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
          //             if(value.toString().isEmpty){
          //               toast("please enter valid last name");
          //             }return null;
          //           }),
          //           FormHelper.fieldLabel("Country", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
          //           Padding(
          //               padding: const EdgeInsets.only(top: 5),
          //               child: cityDropList(
          //                   cityList: countryList,
          //                   hint: "Select Country",
          //                   onChanged: (model){
          //                     printLog("onChanged", model.id);
          //                     app.fetchStateLIst(states: model.sortname);
          //                   })),
          //           FormHelper.fieldLabel("State/Provision", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
          //           Padding(
          //               padding: const EdgeInsets.only(top: 5),
          //               child: cityDropList(
          //                   hint: "Select State",
          //                   cityList: list,
          //                   onChanged: (model){
          //                     printLog("onChanged", model.id);
          //                   })),
          //           FormHelper.fieldLabel("City", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
          //           FormHelper.textInput(context, "",  (value){
          //             billingModel.city = value;
          //           }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
          //             if(value.toString().isEmpty){
          //               toast("please enter valid city");
          //             }return null;
          //           }),
          //           FormHelper.fieldLabel("Post Code", regular, 10, color: grey, prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
          //           FormHelper.textInput(context, "",  (value){
          //             billingModel.postcode = value;
          //           }, isTextArea: true, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
          //             if(value.toString().isEmpty || value.toString().length != 6){
          //               toast("please enter valid postcode");
          //             }return null;
          //           }),
          //           FormHelper.fieldLabel("Address Line 1", regular, 10, color: grey,prefixIcon: Icon(Icons.star, size: 5,color: grey, )),
          //           FormHelper.textInput(context, "", (value){
          //             billingModel.address1 = value;
          //           }, fontWeight: regular, size: 15, textColor: black, onValidate: (value){
          //             if(value.toString().isEmpty){
          //               toast("please enter valid address");
          //             }return null;
          //           }),
          //           FormHelper.fieldLabel("Address Line 2", regular, 10, color: grey,
          //           ),
          //           FormHelper.textInput(context, "",  (value){
          //             billingModel.address2 = value;
          //           }, fontWeight: regular, size: 15, textColor: black),
          //           SizedBox(height: 30,)
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          new Step(
            title: new Text('  Order\nPayment',style: styleProvider(fontWeight: medium, size: 10, color: black),),
            isActive: _currentStep >= 0,
            state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
            content:  Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 30, right: 28, bottom: 10),
                    child: Container(
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, top: 8, right: 30, bottom: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Shipping Methods',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                                  cartData.shippingMethod!=null ? ShippingCart(cartData.shippingMethod) : Container(),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 30, right: 28, bottom: 10),
                    child: Container(
                        child: Card(
                          elevation: 10,
                          color: Color(0xFFFEDBD0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, top: 8, right: 30, bottom: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Order Summary',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text('Subtotal :',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20.0),
                                          child: Text(cart_subtotal.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text('Shipping Charges :',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20.0),
                                          child: Text(getShippingPrice() ,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text('Tax :',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20.0),
                                          child: Text(taxes.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text('Total Discount :',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20.0),
                                          child: Text(discount_total.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    child: Container(
                                      height: 0.9,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 70,
                                          child: Text('Total :',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20.0),
                                          child: Text("₹ "+totalPrice(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: 30,)
                ],
              ),
            ),
          ),
        ],)),
    );
  }
  String getShippingPrice() {
    return value==0 ? shipping_Flat.toString():shipping_Free.toString();
  }
  Widget ShippingCart(List<ShippingMethod> shippingMethod){
    return ListView.builder(
        itemCount: shippingMethod.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70,
                  child: Text(shippingMethod[index].shippingMethodName,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 10)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                            parse(shippingMethod[index].shippingMethodPrice)
                                .documentElement
                                .text,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 10)),
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Radio(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          value: index,
                          activeColor: Colors.black,
                          groupValue: value,
                          onChanged: (val) {
                            printLog("onChanged", val);
                            setState(() {
                              value = val;
                            });
                            printLog("onSetChanged", val);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
  void calculateShippingDialog(){
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
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 200,
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
                              child: Text("Calculate Shipping",
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
                      Padding(
                        padding:  const EdgeInsets.only(top: 20),
                        child: Container(
                          height: 40,
                          width: 300,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[50]
                              )
                          ),
                        ),
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
  String totalPrice(){
    printLog("getshipp", getShippingPrice());
    double price = getValidDecimalInDouble(discount_total)+getValidDecimalInDouble(taxes)+getValidDecimalInDouble(cart_subtotal)+getValidDecimalInDouble(getShippingPrice());
    return getValidDecimalFormat(price);
  }
  Widget _createEventControlBuilder(BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: onStepCancel,
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 6, bottom: 6),
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(30.0),
                  color: orange
                ),
                child: Text('Previous', style: styleProvider(size: 12, color: white),)),
          ),
          FlatButton(
            onPressed: onStepContinue,
            child: Container(
                padding: EdgeInsets.only(left: 30, right: 30, top: 6, bottom: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: orange
                ),
                child: Text('Next', style: styleProvider(size: 12, color: white),)),
          ),
        ]
    );
  }
  saveDetails(){
    if(saveShippingForm()){
      printLog("shippingdata", shippingModel.toJson());
     setState(() {
       _currentStep+=1;
     });
    }
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
}