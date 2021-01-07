// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

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

  String chosenShippingMethod;
  List<ShippingMethod> shippingMethod;
  String discountTotal;
  String cartSubtotal;
  List<Coupon> coupon;
  String taxes;
  String total;
  List<CartDatum> cartData;

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
    "shipping_method": List<dynamic>.from(shippingMethod.map((x) => x.toJson())),
    "discount_total": discountTotal,
    "cart_subtotal": cartSubtotal,
    "coupon": List<dynamic>.from(coupon.map((x) => x.toJson())),
    "taxes": taxes,
    "total": total,
    "cart_data": List<dynamic>.from(cartData.map((x) => x.toJson())),
  };
}

class CartDatum {
  CartDatum({
    this.name,
    this.image,
    this.cartItemKey,
    this.varitions,
    this.price,
    this.pincodeDelivery,
    this.productDesc,
    this.shippingClass,
    this.soldInd,
    this.manageStock,
    this.stockQuanity,
    this.quantity,
    this.subtotal,
  });

  String name;
  String image;
  String cartItemKey;
  String varitions;
  String price;
  PincodeDelivery pincodeDelivery;
  String productDesc;
  int shippingClass;
  String soldInd;
  bool manageStock;
  dynamic stockQuanity;
  String quantity;
  String subtotal;

  factory CartDatum.fromJson(Map<String, dynamic> json) => CartDatum(
    name: json["name"],
    image: json["image"],
    cartItemKey: json["cart_item_key"],
    varitions: json["varitions"],
    price: json["price"],
    pincodeDelivery: PincodeDelivery.fromJson(json["pincode_delivery"]),
    productDesc: json["product_desc"],
    shippingClass: json["shipping_class"],
    soldInd: json["sold_ind"],
    manageStock: json["manage_stock"],
    stockQuanity: json["stock_quanity"],
    quantity: json["quantity"],
    subtotal: json["subtotal"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "cart_item_key": cartItemKey,
    "varitions": varitions,
    "price": price,
    "pincode_delivery": pincodeDelivery.toJson(),
    "product_desc": productDesc,
    "shipping_class": shippingClass,
    "sold_ind": soldInd,
    "manage_stock": manageStock,
    "stock_quanity": stockQuanity,
    "quantity": quantity,
    "subtotal": subtotal,
  };
}

class PincodeDelivery {
  PincodeDelivery({
    this.delivery,
  });

  bool delivery;

  factory PincodeDelivery.fromJson(Map<String, dynamic> json) => PincodeDelivery(
    delivery: json["delivery"],
  );

  Map<String, dynamic> toJson() => {
    "delivery": delivery,
  };
}

class Coupon {
  Coupon({
    this.code,
    this.discount,
  });

  String code;
  String discount;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    code: json["code"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "discount": discount,
  };
}

class ShippingMethod {
  ShippingMethod({
    this.id,
    this.methodId,
    this.shippingMethodName,
    this.shippingMethodPrice,
    this.shippingMethodPriceWithoutSymbol,
  });

  String id;
  String methodId;
  String shippingMethodName;
  String shippingMethodPrice;
  String shippingMethodPriceWithoutSymbol;

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
    id: json["id"],
    methodId: json["method_id"],
    shippingMethodName: json["shipping_method_name"],
    shippingMethodPrice: json["shipping_method_price"],
    shippingMethodPriceWithoutSymbol: json["shipping_method_price_without_symbol"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "method_id": methodId,
    "shipping_method_name": shippingMethodName,
    "shipping_method_price": shippingMethodPrice,
    "shipping_method_price_without_symbol": shippingMethodPriceWithoutSymbol,
  };
}
