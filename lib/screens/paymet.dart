import 'package:flutter/material.dart';
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
  int checkedIndex ;
  bool checked = false;
  @override
  void initState() {
    var app = Provider.of<AppProvider>(context, listen: false);
    app.fetchPaymentMethod();
    super.initState();
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      appBar: BaseAppBar(context, "Payment Method", suffixIcon: Container()),
      body: _paymentGatway(),

    );
  }
  Widget _paymentGatway(){
    return new Consumer<AppProvider>(builder: (context, app, child){
      if(app.getPaymentGateway!=null && app.getPaymentGateway.length>0){
        return paymentGatwayBuilder(app.getPaymentGateway);
      }else{
        return progressBar(context, orange);
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
                  });

                },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: orange_50,
                        border:Border.all(color:orange_50),
                        boxShadow: [
                          BoxShadow(color: orange_50, spreadRadius: 1)
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
          GestureDetector(
            onTap: (){
              setState(() {
                checked = false;
                checkedIndex = 10;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: orange_50,
                  border:Border.all(color: orange_50),
                  boxShadow: [
                    BoxShadow(color: orange_50, spreadRadius: 1)
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                        width: 60,
                        child: Image.asset(ic_money)),
                    Text("Razor Pay", style: styleProvider(fontWeight: medium, size: 13, color: black),)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}