class ShippingMethod {
  ShippingMethod({
    this.id,
    this.methodId,
    this.shippingMethodName,
    this.shippingMethodPrice,
    this.shippingMethodPriceWithoutSymbol,
  });

  String? id;
  String? methodId;
  String? shippingMethodName;
  String? shippingMethodPrice;
  String? shippingMethodPriceWithoutSymbol;

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