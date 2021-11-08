// To parse this JSON data, do
//
//     final coupons = couponsFromJson(jsonString);

import 'dart:convert';

import 'link.dart';

List<Coupons> couponsFromJson(String str) => List<Coupons>.from(json.decode(str).map((x) => Coupons.fromJson(x)));

String couponsToJson(List<Coupons> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coupons {
  Coupons({
    this.id,
    this.code,
    this.amount,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountType,
    this.description,
    this.dateExpires,
    this.dateExpiresGmt,
    this.usageCount,
    this.individualUse,
    this.productIds,
    this.excludedProductIds,
    this.usageLimit,
    this.usageLimitPerUser,
    this.limitUsageToXItems,
    this.freeShipping,
    this.productCategories,
    this.excludedProductCategories,
    this.excludeSaleItems,
    this.minimumAmount,
    this.maximumAmount,
    this.emailRestrictions,
    this.usedBy,
    this.metaData,
    this.links,
  });

  int? id;
  String? code;
  String? amount;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? discountType;
  String? description;
  dynamic dateExpires;
  dynamic dateExpiresGmt;
  int? usageCount;
  bool? individualUse;
  List<dynamic>? productIds;
  List<dynamic>? excludedProductIds;
  dynamic usageLimit;
  dynamic usageLimitPerUser;
  dynamic limitUsageToXItems;
  bool? freeShipping;
  List<dynamic>? productCategories;
  List<dynamic>? excludedProductCategories;
  bool? excludeSaleItems;
  String? minimumAmount;
  String? maximumAmount;
  List<dynamic>? emailRestrictions;
  List<dynamic>? usedBy;
  List<dynamic>? metaData;
  Links? links;

  factory Coupons.fromJson(Map<String, dynamic> json) => Coupons(
    id: json["id"],
    code: json["code"],
    amount: json["amount"],
    dateCreated: json["date_created"]!=null ? DateTime.parse(json["date_created"]) : null,
    dateCreatedGmt: json["date_created_gmt"]!=null ? DateTime.parse(json["date_created_gmt"]) : null,
    dateModified: json["date_modified"]!=null ? DateTime.parse(json["date_modified"]) : null,
    dateModifiedGmt: json["date_modified_gmt"]!=null ? DateTime.parse(json["date_modified_gmt"]) : null,
    discountType: json["discount_type"],
    description: json["description"],
    dateExpires: json["date_expires"],
    dateExpiresGmt: json["date_expires_gmt"],
    usageCount: json["usage_count"],
    individualUse: json["individual_use"],
    productIds: List<dynamic>.from(json["product_ids"].map((x) => x)),
    excludedProductIds: List<dynamic>.from(json["excluded_product_ids"].map((x) => x)),
    usageLimit: json["usage_limit"],
    usageLimitPerUser: json["usage_limit_per_user"],
    limitUsageToXItems: json["limit_usage_to_x_items"],
    freeShipping: json["free_shipping"],
    productCategories: List<dynamic>.from(json["product_categories"].map((x) => x)),
    excludedProductCategories: List<dynamic>.from(json["excluded_product_categories"].map((x) => x)),
    excludeSaleItems: json["exclude_sale_items"],
    minimumAmount: json["minimum_amount"],
    maximumAmount: json["maximum_amount"],
    emailRestrictions: List<dynamic>.from(json["email_restrictions"].map((x) => x)),
    usedBy: List<dynamic>.from(json["used_by"].map((x) => x)),
    metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "amount": amount,
    "date_created": dateCreated!=null ? dateCreated!.toIso8601String() : null,
    "date_created_gmt": dateCreatedGmt!=null ? dateCreatedGmt!.toIso8601String() : null,
    "date_modified": dateModified!=null  ? dateModified!.toIso8601String(): null,
    "date_modified_gmt": dateModifiedGmt!=null ? dateModifiedGmt!.toIso8601String() : null,
    "discount_type": discountType,
    "description": description,
    "date_expires": dateExpires,
    "date_expires_gmt": dateExpiresGmt,
    "usage_count": usageCount,
    "individual_use": individualUse,
    "product_ids": productIds!=null ? List<dynamic>.from(productIds!.map((x) => x)) : null,
    "excluded_product_ids": excludedProductIds!=null ?
    List<dynamic>.from(excludedProductIds!.map((x) => x)) : null,
    "usage_limit": usageLimit,
    "usage_limit_per_user": usageLimitPerUser,
    "limit_usage_to_x_items": limitUsageToXItems,
    "free_shipping": freeShipping,
    "product_categories": productCategories!=null ? List<dynamic>.from(productCategories!.map((x) => x)) : null,
    "excluded_product_categories": excludedProductCategories!=null ? List<dynamic>.from(excludedProductCategories!.map((x) => x)): null,
    "exclude_sale_items": excludeSaleItems,
    "minimum_amount": minimumAmount,
    "maximum_amount": maximumAmount,
    "email_restrictions": emailRestrictions!=null ? List<dynamic>.from(emailRestrictions!.map((x) => x)) : null,
    "used_by": usedBy!=null ? List<dynamic>.from(usedBy!.map((x) => x)) : null,
    "meta_data": metaData!=null ? List<dynamic>.from(metaData!.map((x) => x)) : null,
    "_links": links!=null ? links!.toJson() : null,
  };
}

