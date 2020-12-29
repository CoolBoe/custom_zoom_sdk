import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/services/cart.dart';
import 'dart:convert';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

class CartProvider with ChangeNotifier {
  WebResponseModel webResponseModel;
  CartServices cartServices = CartServices();
  CartModel cartModel;

  CartProvider() {
    getCart();
  }

  Future<WebResponseModel> getAddToCart(
      {String id,
      String quantity,
      String variation,
      String variation_id}) async {
    webResponseModel =
        await cartServices.getAddToCart(id: id, quantity: quantity);
    notifyListeners();
  }

  Future<WebResponseModel> getAddToCartVariationProduct(
      {String id,
      String quantity,
      String variation,
      String variation_id}) async {
    webResponseModel = await cartServices.getAddToCartVariationProduct(
        id: id,
        quantity: quantity,
        variation: variation,
        variation_id: variation_id);
    notifyListeners();
  }

  Future<CartModel> getCart() async {
    cartModel = await cartServices.getCart();
    printLog("getAddToCart", cartModel);
    notifyListeners();
  }
}
