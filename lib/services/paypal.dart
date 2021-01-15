import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/loading.dart';

class PaypalServices{

  Future<String>getAccessToken() async{
    try{
      var authToken = base64Encode(utf8.encode(paypalClientId+":"+paypalSecretKey),);

      var response = await Dio().post('${paypalURL}/v1/oauth2/token?grant_type=client_credentials', options: new Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
          HttpHeaders.contentTypeHeader: "application/json"
        }
      ));
      if(response.statusCode==200 || response.statusCode==201){
        final body = response.data;
        return body["access_token"];
      }
      return null;
    }catch(e){
      printLog("CHECKPONT2", e);
      rethrow;
    }
  }

  Map<dynamic, dynamic> defaultCurrency={
    "symbol":"INR",
    "decimalDigits":2,
    "symbolBeforeTheNumber":true,
    "currency":"INR"
  };

  Map<String, dynamic>getOrderParams(BuildContext context){
    var cartModel =Provider.of<CartProvider>(context, listen: false);
    cartModel.getCartData();

    List items =[];
    cartModel.getCart.cartData.forEach((CartDatum item){
      items.add({
        "name": item.name,
        "quantity": item.quantity,
        "price":getValidString(item.price),
        "currency":defaultCurrency["currency"]
      });
    });
    String totalAmount= getValidString(cartModel.getCart.total);

    Map<String, dynamic>temp={
      "intent":"sale",
      "payer":{"payment_method":"paypal"},
      "transactions":[
        {
          "amount" :{
            "total":totalAmount,
          "currency":defaultCurrency["currency"]
        },
          "description" :"The payment transaction description.",
          "payment options":{
            "allowed_payment_method":"INSTANT_FUNDING_SOURCE"
          },
          "item_list":{
            "items":items,
          }
        }
      ],
      "note_to_payer":"Contact us for any questions on your order.",
      "redirect_urls":{"return_url":returnURL, "cancel_url":cancelURL}
  };
    return temp;
  }

  Map<String, dynamic> getTempOrderParams(BuildContext context) {
    List items = [
      {
        "name": "itemName",
        "quantity": "quantity",
        "price": "itemPrice",
        "currency": defaultCurrency["currency"]
      }
    ];


    // checkout invoice details
    String totalAmount = '1.99';
    String subTotalAmount = '1.99';
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'Gulshan';
    String userLastName = 'Yadav';
    String addressCity = 'Delhi';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'India';
    String addressState = 'Delhi';
    String addressPhoneNumber = '+919990119091';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount":
              ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (true)
              "shipping_address": {
                "recipient_name": userFirstName +
                    " " +
                    userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": returnURL,
        "cancel_url": cancelURL
      }
    };
    return temp;
  }
  Future<Map<String, String>> createPaypalPayment(transactions, accessToken,)async{
    printLog("createPaypalPayment", 'transactions=>$transactions, accessToken=>$accessToken');
    try{
      var response = await Dio().post(
          "https://api.sandbox.paypal.com/v1/payments/payment",
          data: transactions,
          options:new Options(
              headers:{
                "content-type": "application/json",
                'Authorization': 'Basic ' + accessToken
              },
          )
      );
      final body = response.data;
      if(response.statusCode==201 || response.statusCode==200){
        if(body["links"]!=null && body["links"].lenght>0){
          List links = body["links"];
          String executeUrl ="";
          String approvalUrl="";
          final item = links.firstWhere((o) => o["rel"]=="approval_url",
          orElse: ()=> null);
          if(item!=null){
            approvalUrl=item["href"];
          }
          final item1= links.firstWhere((o) => o["rel"]=="execute",
          orElse: ()=>null);
          if(item1!=null){
            executeUrl=item1["href"];
          }
          return {"executeUrl":executeUrl, "approvalUrl":approvalUrl};
        }
        return null;
      }else{
        throw Exception(body["message"]);
      }
    }catch(e){
      printLog("createPaypalPaymentError", e.toString());
    }
  }
  Future<String> executePayment(url, payerId, accessToken) async{
    try{
      var response = await Dio().post(url, data: jsonEncode({"payer_id":payerId}),
      options: new Options(
        headers: {
          HttpHeaders.authorizationHeader:'Bearer $accessToken',
          HttpHeaders.contentTypeHeader:"application/json"
        },
      ));
      final body = response.data;
      if(response.statusCode==200 && response.statusCode==201){
        return body["id"];
      }
      return null;
    }catch(e){
      rethrow;
    }

  }
}
