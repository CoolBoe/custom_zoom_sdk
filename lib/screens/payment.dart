import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:payu_money_flutter/payu_money_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/paymentGateway.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class PaymentScreen extends BasePage{
  PaymentScreen({Key key}) : super(key: key);
  @override
  PaymentScreenState createState() => PaymentScreenState();
}
class PaymentScreenState extends BasePageState<PaymentScreen>{
  PayuMoneyFlutter payuMoneyFlutter = PayuMoneyFlutter();

  // Payment Details
  String phone = "8318045008";
  String email = "gmail@gmail.com";
  String productName = "My Product Name";
  String firstName = "Vaibhav";
  String txnID = "223428947";
  String amount = "1.0";

  int checkedIndex ;
  String paymentMethod = '';
  bool checked = false;
  @override
  void initState() {
    var app = Provider.of<AppProvider>(context, listen: false);
    app.fetchPaymentMethod();
    setupPayment();
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      appBar: BaseAppBar(context, "Payment Method", suffixIcon: Container()),
      body: _paymentGatway(),
      bottomNavigationBar: customButton(title: "Submit", onPressed: (){
        if(paymentMethod!=null && paymentMethod!=""){
            switch(paymentMethod){
              case "bacs":
                toast("Direct Bank Transfer");
                break;
              case "cheque":
                toast("Cheque Transfer");
                break;
              case "cod":
                toast("cash on delivery");
                break;
              case "paypal":
                toast("paypal");
                break;
              case "payumbolt":
                toast("PayuMoney");
               startPayment();
                break;
              case "razorpay":
                toast("Razor Pay");
                break;
              case "paytmpay":
                toast("PayTm");
                break;
            }
        }else{
          toast(PAY_METHOD_NOT_FOUND);
        }
      }),
    );
  }
  Widget _paymentGatway(){
    return new Consumer<AppProvider>(builder: (context, app, child){
      if(app.getPaymentGateway!=null && app.getPaymentGateway.length>0){
        return paymentGatwayBuilder(app.getPaymentGateway);
      }else{
        return progressBar(context, accent_color);
      }
    });
  }
  Widget paymentGatwayBuilder(List<PaymentGateway> gateway){
    return Container(
      padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: gateway.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                checked = index == checkedIndex;
                return GestureDetector(onTap: (){
                  setState(() {
                    checkedIndex = index;
                    paymentMethod = gateway[index].gatewayId;
                  });
                },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.redAccent[50],
                        border:Border.all(color: checked ? accent_color : accent_color_50),
                        boxShadow: [
                          BoxShadow(color:  checked ? accent_color : accent_color_50, spreadRadius: 1)
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              child: Image.asset(ic_money)),
                          Text(gateway[index].gatewayTitle, style: styleProvider(fontWeight: medium, size: 13, color: black),)
                        ],
                      ),
                    ),
                  ),);
              }),
        ],
      ),
    );
  }
  // Function for setting up the payment details
  setupPayment() async {
    bool response = await payuMoneyFlutter.setupPaymentKeys(
        merchantKey: PayUmerchantKey,
        merchantID: PayUmerchantID,
        isProduction: false,
        activityTitle: appName,
        disableExitConfirmation: false);
  }
  Future<Map<String, dynamic>> startPayment() async {
    // Generating hash from php server

    Response res =
    await post(Uri.parse("https://PayUMoneyServer.codedivinedivin.repl.co"), body: {
      "txnid": txnID,
      "phone": phone,
      "email": email,
      "amount": amount,
      "productinfo": productName,
      "firstname": firstName,
    });
    var data = jsonDecode(res.body);
    print(data);
    String hash = data['params']['hash'];
    print(hash);
    var myResponse = await payuMoneyFlutter.startPayment(
        txnid: txnID,
        amount: amount,
        name: firstName,
        email: email,
        phone: phone,
        productName: productName,
        hash: hash);
    print("Message ${myResponse}");
  }

}