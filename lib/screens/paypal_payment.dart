import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/services/paypal.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class PaypalPayment extends StatefulWidget{

  PaypalPayment({Key key}) : super(key: key);
  @override
  PaypalPaymentState createState()=>PaypalPaymentState();
}
class PaypalPaymentState extends State<PaypalPayment>{
  InAppWebViewController webView;
  String url = "";
  double progress = 0;
  GlobalKey<ScaffoldState> scaffoldKey;
  String checkoutURL;
  String executeURL;
  String accessToken;

  PaypalServices paypalServices;

  @override
  void initState() {
    super.initState();
    paypalServices =new PaypalServices();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();

    Future.delayed(Duration.zero, () async{
      try{
        accessToken= await paypalServices.getAccessToken();
        printLog("accessToken", accessToken);
        final transactions = paypalServices.getTempOrderParams(context);
        printLog("transactions", transactions);
        final res= await paypalServices.createPaypalPayment(transactions, accessToken);
        if(res!=null){
          printLog("checkoutURL", res);
          setState(() {
            checkoutURL= res["approvalUrl"];
            executeURL = res["executeUrl"];
          });
        }
      }catch(e){
        printLog('Execptions', e.toString());
      }
    });
  }
  @override
    Widget build(BuildContext context) {
    if(checkoutURL!=null){
      return Scaffold(
        appBar: BaseAppBar(context, "PayPal Payment"),
        body: Stack(
          children: [
            InAppWebView(
              initialUrl: checkoutURL,
              initialOptions: new InAppWebViewGroupOptions(
                  android: AndroidInAppWebViewOptions(
                      textZoom: 120
                  )
              ),
              onWebViewCreated: (InAppWebViewController controller){
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String requestURL)async{
                if(requestURL.contains(returnURL)){
                  final url = Uri.parse(requestURL);
                  final payerId =url.queryParameters['PayerID'];
                  if(payerId!=null){
                      await paypalServices.executePayment(executeURL, payerId, accessToken).then((value) => 
                      printLog("executePayment", value));
                      Navigator.of(context).pop();
                  }else{
                    Navigator.of(context).pop();
                  }
                }else{
                  Navigator.of(context).pop();
                }
                if(requestURL.contains(cancelURL)){
                  Navigator.of(context).pop();
                }
              },
              onProgressChanged:(InAppWebViewController controller, int progress){
                setState(() {
                  this.progress = progress / 100 ;
                });
              },
            ),
            progress <1 ? SizedBox(height: 3,child: LinearProgressIndicator(value: progress, backgroundColor: Theme.of(context).accentColor.withOpacity(0.2), )) :
            SizedBox()
          ],
        ),
      );

    }else{
      return Scaffold(key: scaffoldKey, appBar: BaseAppBar(context, "PayPal Payment"), body: Container(child: progressBar(context, accent_color),),);
    }
      }
}