class CartModel {
  String chosenShippingMethod;
  List<ShippingMethod> shippingMethod;
  String discountTotal;
  String cartSubtotal;
  List<Null> coupon;
  String taxes;
  String total;
  List<CartData> cartData;

  CartModel(
      {this.chosenShippingMethod,
        this.shippingMethod,
        this.discountTotal,
        this.cartSubtotal,
        this.coupon,
        this.taxes,
        this.total,
        this.cartData});

  CartModel.fromJson(Map<String, dynamic> json) {
    chosenShippingMethod = json['chosen_shipping_method'];
    if (json['shipping_method'] != null) {
      shippingMethod = new List<ShippingMethod>();
      json['shipping_method'].forEach((v) {
        shippingMethod.add(new ShippingMethod.fromJson(v));
      });
    }
    discountTotal = json['discount_total'];
    cartSubtotal = json['cart_subtotal'];
    // if (json['coupon'] != null) {
    //   coupon = new List<Null>();
    //   json['coupon'].forEach((v) {
    //     coupon.add(new Null.fromJson(v));
    //   });
    // }
    taxes = json['taxes'];
    total = json['total'];
    if (json['cart_data'] != null) {
      cartData = new List<CartData>();
      json['cart_data'].forEach((v) {
        cartData.add(new CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chosen_shipping_method'] = this.chosenShippingMethod;
    if (this.shippingMethod != null) {
      data['shipping_method'] =
          this.shippingMethod.map((v) => v.toJson()).toList();
    }
    data['discount_total'] = this.discountTotal;
    data['cart_subtotal'] = this.cartSubtotal;
    // if (this.coupon != null) {
    //   data['coupon'] = this.coupon.map((v) => v.toJson()).toList();
    // }
    data['taxes'] = this.taxes;
    data['total'] = this.total;
    if (this.cartData != null) {
      data['cart_data'] = this.cartData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingMethod {
  String id;
  String methodId;
  String shippingMethodName;
  String shippingMethodPrice;
  String shippingMethodPriceWithoutSymbol;

  ShippingMethod(
      {this.id,
        this.methodId,
        this.shippingMethodName,
        this.shippingMethodPrice,
        this.shippingMethodPriceWithoutSymbol});

  ShippingMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodId = json['method_id'];
    shippingMethodName = json['shipping_method_name'];
    shippingMethodPrice = json['shipping_method_price'];
    shippingMethodPriceWithoutSymbol =
    json['shipping_method_price_without_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['method_id'] = this.methodId;
    data['shipping_method_name'] = this.shippingMethodName;
    data['shipping_method_price'] = this.shippingMethodPrice;
    data['shipping_method_price_without_symbol'] =
        this.shippingMethodPriceWithoutSymbol;
    return data;
  }
}

class CartData {
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
  Null stockQuanity;
  int quantity;
  String subtotal;

  CartData(
      {this.name,
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
        this.subtotal});

  CartData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    cartItemKey = json['cart_item_key'];
    varitions = json['varitions'];
    price = json['price'];
    pincodeDelivery = json['pincode_delivery'] != null
        ? new PincodeDelivery.fromJson(json['pincode_delivery'])
        : null;
    productDesc = json['product_desc'];
    shippingClass = json['shipping_class'];
    soldInd = json['sold_ind'];
    manageStock = json['manage_stock'];
    stockQuanity = json['stock_quanity'];
    quantity = json['quantity'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['cart_item_key'] = this.cartItemKey;
    data['varitions'] = this.varitions;
    data['price'] = this.price;
    if (this.pincodeDelivery != null) {
      data['pincode_delivery'] = this.pincodeDelivery.toJson();
    }
    data['product_desc'] = this.productDesc;
    data['shipping_class'] = this.shippingClass;
    data['sold_ind'] = this.soldInd;
    data['manage_stock'] = this.manageStock;
    data['stock_quanity'] = this.stockQuanity;
    data['quantity'] = this.quantity;
    data['subtotal'] = this.subtotal;
    return data;
  }
}

class PincodeDelivery {
  bool delivery;

  PincodeDelivery({this.delivery});

  PincodeDelivery.fromJson(Map<String, dynamic> json) {
    delivery = json['delivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery'] = this.delivery;
    return data;
  }
}
