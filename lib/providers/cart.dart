import 'package:flutter/cupertino.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/services/cart.dart';
import 'dart:convert';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

class CartProvider with ChangeNotifier{
  bool cartStatus;
  CartServices _cartServices = CartServices();

  CartProvider.initialize(){
    getAddToCart();
  }
  Future<WebResponseModel>getAddToCart({String id, String quantity, String variation, String variation_id}) => WebApiServices().getAddToCart(id, quantity).then((data){
    if(data.statusCode==HTTP_CODE_200){
      printLog("API getAddToCart(200):- ",data.body);
      WebResponseModel values =WebResponseModel.fromJson(json.decode(data.body));
      if(values.code=="0"){
        return values;
      }else{
        return values;
      }
    }else{
      printLog("Errorr", data.statusCode);
      // toast(NETWORK_ERROR);
      return null;
    }
  });
  Future<WebResponseModel>getAddToCartVariationProduct({String id, String quantity, String variation, String variation_id}) => WebApiServices().getAddToCartVariationProduct(id, quantity, variation, variation_id).then((data){
    if(data.statusCode==HTTP_CODE_200){
      printLog("API getAddToCart(200):- ",data.body);
      WebResponseModel values =WebResponseModel.fromJson(json.decode(data.body));
      if(values.code=="0"){
        return values;
      }else{
        return values;
      }
    }else{
      printLog("Errorr", data.statusCode);
      // toast(NETWORK_ERROR);
      return null;
    }
  });
}
