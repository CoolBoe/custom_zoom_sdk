import 'dart:convert';
import 'package:wooapp/models/user.dart';


List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderHistory {
  OrderHistory({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  List<OrderModel> data;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
    status: json["status"],
    msg: json["msg"],
    data: List<OrderModel>.from(json["data"].map((x) => OrderModel.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderSummary {
  OrderSummary({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  OrderModel data;

  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
    status: json["status"],
    msg: json["msg"],
    data: OrderModel.fromJson(json["data"]),

  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class OrderModel {
  int id;
  int parentId;
  String number;
  String orderKey;
  String createdVia;
  String version;
  String orderStatus;
  String currency;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String discountTotal;
  String discountTax;
  String shippingTotal;
  String shippingTax;
  String cartTax;
  String total;
  String totalTax;
  bool pricesIncludeTax;
  int customerId;
  String customerIpAddress;
  String customerUserAgent;
  String customerNote;
  Billing billing;
  Shipping shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  Null datePaid;
  Null datePaidGmt;
  Null dateCompleted;
  Null dateCompletedGmt;
  String cartHash;
  List<MetaData> metaData;
  List<LineItems> lineItems;
  List<TaxLines> taxLines;
  List<ShippingLines> shippingLines;
  List<CouponLines> couponLines;
  String currencySymbol;
  Links lLinks;

  OrderModel(
      {this.id,
        this.parentId,
        this.number,
        this.orderKey,
        this.createdVia,
        this.version,
        this.orderStatus,
        this.currency,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.discountTotal,
        this.discountTax,
        this.shippingTotal,
        this.shippingTax,
        this.cartTax,
        this.total,
        this.totalTax,
        this.pricesIncludeTax,
        this.customerId,
        this.customerIpAddress,
        this.customerUserAgent,
        this.customerNote,
        this.billing,
        this.shipping,
        this.paymentMethod,
        this.paymentMethodTitle,
        this.transactionId,
        this.cartHash,
        this.metaData,
        this.lineItems,
        this.taxLines,
        this.shippingLines,
        this.couponLines,
        this.currencySymbol,
        this.lLinks});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    number = json['number'];
    orderKey = json['order_key'];
    createdVia = json['created_via'];
    version = json['version'];
    orderStatus = json['status'];
    currency = json['currency'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    cartTax = json['cart_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    pricesIncludeTax = json['prices_include_tax'];
    customerId = json['customer_id'];
    customerIpAddress = json['customer_ip_address'];
    customerUserAgent = json['customer_user_agent'];
    customerNote = json['customer_note'];
    billing =
    json['billing'] != null ? new Billing.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    transactionId = json['transaction_id'];
    cartHash = json['cart_hash'];

    if (json['line_items'] != null) {
      lineItems = new List<LineItems>();
      json['line_items'].forEach((v) {
        lineItems.add(new LineItems.fromJson(v));
      });
    }
    if (json['tax_lines'] != null) {
      taxLines = new List<TaxLines>();
      json['tax_lines'].forEach((v) {
        taxLines.add(new TaxLines.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = new List<ShippingLines>();
      json['shipping_lines'].forEach((v) {
        shippingLines.add(new ShippingLines.fromJson(v));
      });
    }
    if (json['coupon_lines'] != null) {
      couponLines = new List<CouponLines>();
      json['coupon_lines'].forEach((v) {
        couponLines.add(new CouponLines.fromJson(v));
      });
    }
    currencySymbol = json['currency_symbol'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['number'] = this.number;
    data['order_key'] = this.orderKey;
    data['created_via'] = this.createdVia;
    data['version'] = this.version;
    data['status'] = this.orderStatus;
    data['currency'] = this.currency;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['discount_total'] = this.discountTotal;
    data['discount_tax'] = this.discountTax;
    data['shipping_total'] = this.shippingTotal;
    data['shipping_tax'] = this.shippingTax;
    data['cart_tax'] = this.cartTax;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    data['prices_include_tax'] = this.pricesIncludeTax;
    data['customer_id'] = this.customerId;
    data['customer_ip_address'] = this.customerIpAddress;
    data['customer_user_agent'] = this.customerUserAgent;
    data['customer_note'] = this.customerNote;
    if (this.billing != null) {
      data['billing'] = this.billing.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping.toJson();
    }
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.paymentMethodTitle;
    data['transaction_id'] = this.transactionId;
    data['date_paid'] = this.datePaid;
    data['date_paid_gmt'] = this.datePaidGmt;
    data['date_completed'] = this.dateCompleted;
    data['date_completed_gmt'] = this.dateCompletedGmt;
    data['cart_hash'] = this.cartHash;

    if (this.lineItems != null) {
      data['line_items'] = this.lineItems.map((v) => v.toJson()).toList();
    }
    if (this.taxLines != null) {
      data['tax_lines'] = this.taxLines.map((v) => v.toJson()).toList();
    }
    if (this.shippingLines != null) {
      data['shipping_lines'] =
          this.shippingLines.map((v) => v.toJson()).toList();
    }
    if (this.couponLines != null) {
      data['coupon_lines'] = this.couponLines.map((v) => v.toJson()).toList();
    }
    data['currency_symbol'] = this.currencySymbol;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class MetaData {
  int id;
  String key;
  String value;

}

class LineItems {
  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String taxClass;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  List<Taxes> taxes;
  String sku;
  double price;
  Null parentName;
  String img_src;

  LineItems(
      {this.id,
        this.name,
        this.productId,
        this.variationId,
        this.quantity,
        this.taxClass,
        this.subtotal,
        this.subtotalTax,
        this.total,
        this.totalTax,
        this.taxes,
        this.sku,
        this.price,
        this.parentName,
        this.img_src});

  LineItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    taxClass = json['tax_class'];
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    if (json['taxes'] != null) {
      taxes = new List<Taxes>();
      json['taxes'].forEach((v) {
        taxes.add(new Taxes.fromJson(v));
      });
    }
    sku = json['sku'];
    price = json['price'] is int ? double.parse(json['price'].toString()) : json['price'];
    parentName = json['parent_name'];
    img_src = json['img_src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['variation_id'] = this.variationId;
    data['quantity'] = this.quantity;
    data['tax_class'] = this.taxClass;
    data['subtotal'] = this.subtotal;
    data['subtotal_tax'] = this.subtotalTax;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    if (this.taxes != null) {
      data['taxes'] = this.taxes.map((v) => v.toJson()).toList();
    }
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['parent_name'] = this.parentName;
    data['img_src'] = this.img_src;
    return data;
  }
}

class Taxes {
  int id;
  String total;
  String subtotal;

  Taxes({this.id, this.total, this.subtotal});

  Taxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['subtotal'] = this.subtotal;
    return data;
  }
}

class TaxLines {
  int id;
  String rateCode;
  int rateId;
  String label;
  bool compound;
  String taxTotal;
  String shippingTaxTotal;
  int ratePercent;
  List<Null> metaData;

  TaxLines(
      {this.id,
        this.rateCode,
        this.rateId,
        this.label,
        this.compound,
        this.taxTotal,
        this.shippingTaxTotal,
        this.ratePercent,
        this.metaData});

  TaxLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rateCode = json['rate_code'];
    rateId = json['rate_id'];
    label = json['label'];
    compound = json['compound'];
    taxTotal = json['tax_total'];
    shippingTaxTotal = json['shipping_tax_total'];
    ratePercent = json['rate_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rate_code'] = this.rateCode;
    data['rate_id'] = this.rateId;
    data['label'] = this.label;
    data['compound'] = this.compound;
    data['tax_total'] = this.taxTotal;
    data['shipping_tax_total'] = this.shippingTaxTotal;
    data['rate_percent'] = this.ratePercent;
    return data;
  }
}

class ShippingLines {
  int id;
  String methodTitle;
  String methodId;
  String instanceId;
  String total;
  String totalTax;
  List<MetaData> metaData;

  ShippingLines(
      {this.id,
        this.methodTitle,
        this.methodId,
        this.instanceId,
        this.total,
        this.totalTax,
        this.metaData});

  ShippingLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodTitle = json['method_title'];
    methodId = json['method_id'];
    instanceId = json['instance_id'];
    total = json['total'];
    totalTax = json['total_tax'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['method_title'] = this.methodTitle;
    data['method_id'] = this.methodId;
    data['instance_id'] = this.instanceId;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;

    return data;
  }
}
class CouponLines {
  int id;
  String code;
  String discount;
  String discountTax;
  List<MetaData> metaData;

  CouponLines(
      {this.id, this.code, this.discount, this.discountTax, this.metaData});

  CouponLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    discount = json['discount'];
    discountTax = json['discount_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['discount_tax'] = this.discountTax;
    return data;
  }
}

class Links {
  List<Self> self;

  Links({this.self});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = new List<Self>();
      json['self'].forEach((v) {
        self.add(new Self.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}


