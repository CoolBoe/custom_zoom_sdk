import 'dart:convert';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

class CartServices {
  List<CartModel> categories = new List<CartModel>();

  Future<bool>getAddToCart({String id, String quantity, String variation, String variation_id}) => WebApiServices().getAddToCart(id, quantity).then((data){
    if(data.statusCode==HTTP_CODE_200){
      printLog("API getAddToCart(200):- ",data.body);
      WebResponseModel values =WebResponseModel.fromJson(json.decode(data.body));
      if(values.code=="0"){
        return false;
      }else{
        return true;
      }
    }else{
      printLog("Errorr", data.statusCode);
      toast(NETWORK_ERROR);
      return false;
      }
  });
}