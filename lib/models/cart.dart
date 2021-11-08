// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'coupon_data.dart';
import 'pin_code_delivery.dart';
import 'shipping_method.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.chosenShippingMethod,
    this.shippingMethod,
    this.discountTotal,
    this.cartSubtotal,
    this.coupon,
    this.taxes,
    this.total,
    this.cartData,
  });

  String? chosenShippingMethod;
  List<ShippingMethod>? shippingMethod;
  String? discountTotal;
  String? cartSubtotal;
  List<Coupon>? coupon;
  String? taxes;
  String? total;
  List<CartDatum>? cartData;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    chosenShippingMethod: json["chosen_shipping_method"],
    shippingMethod: json["shipping_method"]==null ? [] : List<ShippingMethod>.from(json["shipping_method"].map((x) => ShippingMethod.fromJson(x))),
    discountTotal: json["discount_total"],
    cartSubtotal: json["cart_subtotal"],
    coupon: json["coupon"]==null ? [] : List<Coupon>.from(json["coupon"].map((x) => Coupon.fromJson(x))),
    taxes: json["taxes"],
    total: json["total"],
    cartData: json["cart_data"]==null ? [] : List<CartDatum>.from(json["cart_data"].map((x) => CartDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chosen_shipping_method": chosenShippingMethod,
    "shipping_method": List<dynamic>.from(shippingMethod!.map((x) => x.toJson())),
    "discount_total": discountTotal,
    "cart_subtotal": cartSubtotal,
    "coupon": List<dynamic>.from(coupon!.map((x) => x.toJson())),
    "taxes": taxes,
    "total": total,
    "cart_data": List<dynamic>.from(cartData!.map((x) => x.toJson())),
  };
}

class CartDatum {
  CartDatum({
    this.name,
    this.image,
    this.cartItemKey,
    this.variation,
    this.price,
    this.pinCodeDelivery,
    this.productDesc,
    this.shippingClass,
    this.soldInd,
    this.manageStock,
    this.stockQuantity,
    this.quantity,
    this.subtotal,
  });

  String? name;
  String? image;
  String? cartItemKey;
  String? variation;
  String? price;
  PinCodeDelivery? pinCodeDelivery;
  String? productDesc;
  int? shippingClass;
  String? soldInd;
  bool? manageStock;
  dynamic stockQuantity;
  String? quantity;
  String? subtotal;

  factory CartDatum.fromJson(Map<String, dynamic> json) => CartDatum(
    name: json["name"],
    image: json["image"],
    cartItemKey: json["cart_item_key"],
    variation: json["varitions"],
    price: json["price"],
    pinCodeDelivery: PinCodeDelivery.fromJson(json["pincode_delivery"]),
    productDesc: json["product_desc"],
    shippingClass: json["shipping_class"],
    soldInd: json["sold_ind"],
    manageStock: json["manage_stock"],
    stockQuantity: json["stock_quanity"],
    quantity: json["quantity"].toString(),
    subtotal: json["subtotal"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "cart_item_key": cartItemKey,
    "varitions": variation,
    "price": price,
    "pincode_delivery": pinCodeDelivery!=null ? pinCodeDelivery!.toJson() : null,
    "product_desc": productDesc,
    "shipping_class": shippingClass,
    "sold_ind": soldInd,
    "manage_stock": manageStock,
    "stock_quanity": stockQuantity,
    "quantity": quantity,
    "subtotal": subtotal,
  };
}
