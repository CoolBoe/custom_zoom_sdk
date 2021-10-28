import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/paymentGateway.dart';
import 'package:wooapp/models/product.dart';

class ReviewOrder {
  bool chosenGateway;
  List<Product> product;
  String discountTotal;
  String cartSubtotal;
  List<Coupon> cartDiscountCoupon;
  String chosenShippingMethod;
  List<ShippingMethod> shippingMethod;
  CartTaxTotal cartTaxTotal;
  String cartOrderTotal;
  String cartOrderTotalWithoutSymbol;
  List<PaymentGateway> paymentGateway;

  ReviewOrder(
      {this.chosenGateway,
        this.product,
        this.discountTotal,
        this.cartSubtotal,
        this.cartDiscountCoupon,
        this.chosenShippingMethod,
        this.shippingMethod,
        this.cartTaxTotal,
        this.cartOrderTotal,
        this.cartOrderTotalWithoutSymbol,
        this.paymentGateway});

  ReviewOrder.fromJson(Map<String, dynamic> json) {
    chosenGateway = json['chosen_gateway'];
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
    discountTotal = json['discount_total'];
    cartSubtotal = json['cart_subtotal'];
    if (json['cart_discount_coupon'] != null) {
      cartDiscountCoupon = new List<Coupon>();
      json['cart_discount_coupon'].forEach((v) {
        cartDiscountCoupon.add(new Coupon.fromJson(v));
      });
    }
    chosenShippingMethod = json['chosen_shipping_method'];
    if (json['shipping_method'] != null) {
      shippingMethod = new List<ShippingMethod>();
      json['shipping_method'].forEach((v) {
        shippingMethod.add(new ShippingMethod.fromJson(v));
      });
    }
    cartTaxTotal = json['cart_tax_total'] != null
        ? new CartTaxTotal.fromJson(json['cart_tax_total'])
        : null;
    cartOrderTotal = json['cart_order_total'];
    cartOrderTotalWithoutSymbol = json['cart_order_total_without_symbol'];
    if (json['payment_gateway'] != null) {
      paymentGateway = new List<PaymentGateway>();
      json['payment_gateway'].forEach((v) {
        paymentGateway.add(new PaymentGateway.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chosen_gateway'] = this.chosenGateway;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    data['discount_total'] = this.discountTotal;
    data['cart_subtotal'] = this.cartSubtotal;
    if (this.cartDiscountCoupon != null) {
      data['cart_discount_coupon'] =
          this.cartDiscountCoupon.map((v) => v.toJson()).toList();
    }
    data['chosen_shipping_method'] = this.chosenShippingMethod;
    if (this.shippingMethod != null) {
      data['shipping_method'] =
          this.shippingMethod.map((v) => v.toJson()).toList();
    }
    if (this.cartTaxTotal != null) {
      data['cart_tax_total'] = this.cartTaxTotal.toJson();
    }
    data['cart_order_total'] = this.cartOrderTotal;
    data['cart_order_total_without_symbol'] = this.cartOrderTotalWithoutSymbol;
    if (this.paymentGateway != null) {
      data['payment_gateway'] =
          this.paymentGateway.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int productId;
  PincodeDelivery pincodeDelivery;
  int variationId;
  String productName;
  String productQty;
  String productTotal;

  Product(
      {this.productId,
        this.pincodeDelivery,
        this.variationId,
        this.productName,
        this.productQty,
        this.productTotal});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    pincodeDelivery = json['pincode_delivery'] != null
        ? new PincodeDelivery.fromJson(json['pincode_delivery'])
        : null;
    variationId = json['variation_id'];
    productName = json['product_name'];
    productQty = json['product_qty'].toString();
    productTotal = json['product_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    if (this.pincodeDelivery != null) {
      data['pincode_delivery'] = this.pincodeDelivery.toJson();
    }
    data['variation_id'] = this.variationId;
    data['product_name'] = this.productName;
    data['product_qty'] = this.productQty;
    data['product_total'] = this.productTotal;
    return data;
  }
}
class CartTaxTotal {
  String s12IGST;
  CartTaxTotal({this.s12IGST});

  CartTaxTotal.fromJson(Map<String, dynamic> json) {
    s12IGST = json['12% IGST'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['12% IGST'] = this.s12IGST;
    return data;
  }
}


