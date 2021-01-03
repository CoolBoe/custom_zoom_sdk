import 'dart:convert';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

class CartServices {
  // Future<WebResponseModel> getAddToCart({String id, String quantity}) =>
  //     WebApiServices().getAddToCart(id, quantity).then((data) {
  //       if (data.statusCode == HTTP_CODE_200 || data.statusCode==HTTP_CODE_201) {
  //         printLog("API getAddToCart(200):- ", data.data);
  //         WebResponseModel values = WebResponseModel.fromJson(data.data);
  //         printLog("API WebResponseModel(200):- ", values.code);
  //         return values;
  //       } else {
  //         printLog("Errorr", data.statusCode);
  //         toast(NETWORK_ERROR);
  //         return null;
  //       }
  //     });
  // Future<CartModel> getCart() async => WebApiServices().getCart().then((data) {
  //       printLog("getAddToCart", "response1");
  //       if (data.statusCode == HTTP_CODE_200) {
  //         printLog("API getCart(200):- ", data.data);
  //         CartModel cartModel = CartModel.fromJson(data.data);
  //         printLog("API getcartModel:- ", cartModel);
  //         return cartModel;
  //       } else {
  //         printLog("Errorr", data.statusCode);
  //         toast(NETWORK_ERROR);
  //         return null;
  //       }
  //     });
  // Future<WebResponseModel> getAddToCartVariationProduct(
  //         {String id,
  //         String quantity,
  //         String variation,
  //         String variation_id}) =>
  //     WebApiServices()
  //         .getAddToCartVariationProduct(id, quantity, variation, variation_id)
  //         .then((data) {
  //       if (data.statusCode == HTTP_CODE_200) {
  //         printLog("API getAddToCart(200):- ", data.body);
  //         WebResponseModel values =
  //             WebResponseModel.fromJson(json.decode(data.body));
  //         if (values.code == "0") {
  //           return values;
  //         } else {
  //           return values;
  //         }
  //       } else {
  //         printLog("Errorr", data.statusCode);
  //         // toast(NETWORK_ERROR);
  //         return null;
  //       }
  //     });
}
