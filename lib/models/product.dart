// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:wooapp/validator/validate.dart';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.priceHtml,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.inStock,
    this.backorders,
    this.backordersAllowed,
    this.backOrder,
    this.soldIndividually,
    this.weight,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.relatedIds,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.groupedProducts,
    this.menuOrder,
  });

  int? id;
  String? name;
  String? slug;
  String? permalink;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  Type? type;
  Status? status;
  bool? featured;
  CatalogVisibility? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  String? priceHtml;
  bool? onSale;
  bool? purchasable;
  int? totalSales;
  bool? virtual;
  bool? downloadable;
  int? downloadExpiry;
  String? externalUrl;
  ButtonText? buttonText;
  TaxStatus? taxStatus;
  String? taxClass;
  bool? manageStock;
  dynamic stockQuantity;
  bool? inStock;
  Backorders? backorders;
  bool? backordersAllowed;
  bool? backOrder;
  bool? soldIndividually;
  String? weight;
  bool? shippingRequired;
  bool? shippingTaxable;
  int? shippingClassId;
  bool? reviewsAllowed;
  String? averageRating;
  int? ratingCount;
  List<int>? relatedIds;
  List<dynamic>? upsellIds;
  List<dynamic>? crossSellIds;
  int? parentId;
  String? purchaseNote;
  List<Category>? categories;
  List<dynamic>? tags;
  List<Images>? images;
  List<Attribute>? attributes;
  List<dynamic>? defaultAttributes;
  List<int>? variations;
  List<int>? groupedProducts;
  int? menuOrder;


  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    permalink: json["permalink"],
    dateCreated:json["date_created"]!=null ? DateTime.parse(json["date_created"]): null,
    dateCreatedGmt: json["date_created_gmt"]!=null ? DateTime.parse(json["date_created_gmt"]): null,
    dateModified: json["date_modified"]!=null ? DateTime.parse(json["date_modified"]): null,
    dateModifiedGmt: json["date_modified_gmt"]!=null ? DateTime.parse(json["date_modified_gmt"]): null,
    type:json["type"]!=null ? typeValues.map![json["type"]]: null,
    status:json["status"]!=null ? statusValues.map![json["status"]]: null,
    featured: json["featured"],
    catalogVisibility: json["catalog_visibility"]!=null ?
    catalogVisibilityValues.map![json["catalog_visibility"]]: null,
    description: json["description"],
    shortDescription: json["short_description"],
    sku: json["sku"],
    price: json["price"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    dateOnSaleFrom: json["date_on_sale_from"],
    dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
    dateOnSaleTo: json["date_on_sale_to"],
    dateOnSaleToGmt: json["date_on_sale_to_gmt"],
    priceHtml: json["price_html"],
    onSale: json["on_sale"],
    purchasable: json["purchasable"],
    totalSales: json["total_sales"],
    virtual: json["virtual"],
    downloadable: json["downloadable"],
    downloadExpiry: json["download_expiry"],
    externalUrl: json["external_url"],
    buttonText: json["button_text"]!=null ? buttonTextValues.map![json["button_text"]]: null,
    taxStatus: json["tax_status"]!=null ? taxStatusValues.map![json["tax_status"]] : null,
    taxClass: json["tax_class"],
    manageStock: json["manage_stock"],
    stockQuantity: json["stock_quantity"],
    inStock: json["in_stock"],
    backorders:json["backorders"]!=null ? backordersValues.map![json["backorders"]]: null,
    backordersAllowed: json["backorders_allowed"],
    backOrder: json["backordered"],
    soldIndividually: json["sold_individually"],
    weight: json["weight"],
    shippingRequired: json["shipping_required"],
    shippingTaxable: json["shipping_taxable"],
    shippingClassId: json["shipping_class_id"],
    reviewsAllowed: json["reviews_allowed"],
    averageRating: json["average_rating"],
    ratingCount: json["rating_count"],
    relatedIds: json["related_ids"]!=null ? List<int>.from(json["related_ids"].map((x) => x)) : null,
    upsellIds: json["upsell_ids"]!=null ? List<dynamic>.from(json["upsell_ids"].map((x) => x)) : null,
    crossSellIds: json["cross_sell_ids"]!=null ?
    List<dynamic>.from(json["cross_sell_ids"].map((x) => x)): null,
    parentId: json["parent_id"],
    purchaseNote: json["purchase_note"],
    categories: json["categories"]!=null ?
    List<Category>.from(json["categories"].map((x) => Category.fromJson(x))): null,
    tags: json["tags"]!=null ?
    List<dynamic>.from(json["tags"].map((x) => x)): null,
    images: json["images"]!=null ? List<Images>.from(json["images"].map((x) => Images.fromJson(x))): null,
    attributes: json["attributes"]!=null ?
    List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))): null,
    defaultAttributes: json["default_attributes"]!=null ?
    List<dynamic>.from(json["default_attributes"].map((x) => x)): null,
    variations: json["variations"]!=null ?
    List<int>.from(json["variations"].map((x) => x)): null,
    groupedProducts: json["grouped_products"]!=null ?
    List<int>.from(json["grouped_products"].map((x) => x)): null,
    menuOrder: json["menu_order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "permalink": permalink,
    "date_created": dateCreated!.toIso8601String(),
    "date_created_gmt": dateCreatedGmt!.toIso8601String(),
    "date_modified": dateModified!.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt!.toIso8601String(),
    "type": typeValues.reverse[type],
    "status": statusValues.reverse[status],
    "featured": featured,
    "catalog_visibility": catalogVisibilityValues.reverse[catalogVisibility],
    "description": description,
    "short_description": shortDescription,
    "sku": sku,
    "price": price,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "date_on_sale_from": dateOnSaleFrom,
    "date_on_sale_from_gmt": dateOnSaleFromGmt,
    "date_on_sale_to": dateOnSaleTo,
    "date_on_sale_to_gmt": dateOnSaleToGmt,
    "price_html": priceHtml,
    "on_sale": onSale,
    "purchasable": purchasable,
    "total_sales": totalSales,
    "virtual": virtual,
    "downloadable": downloadable,
    "download_expiry": downloadExpiry,
    "external_url": externalUrl,
    "button_text": buttonTextValues.reverse[buttonText],
    "tax_status": taxStatusValues.reverse[taxStatus],
    "tax_class": taxClass,
    "manage_stock": manageStock,
    "stock_quantity": stockQuantity,
    "in_stock": inStock,
    "backorders": backordersValues.reverse[backorders],
    "backorders_allowed": backordersAllowed,
    "backordered": backOrder,
    "sold_individually": soldIndividually,
    "weight": weight,
    "shipping_required": shippingRequired,
    "shipping_taxable": shippingTaxable,
    "shipping_class_id": shippingClassId,
    "reviews_allowed": reviewsAllowed,
    "average_rating": averageRating,
    "rating_count": ratingCount,
    "related_ids": relatedIds!=null ? List<dynamic>.from(relatedIds!.map((x) => x)): null,
    "upsell_ids": upsellIds!=null ? List<dynamic>.from(upsellIds!.map((x) => x)): null,
    "cross_sell_ids": crossSellIds!=null ? List<dynamic>.from(crossSellIds!.map((x) => x)) : null,
    "parent_id": parentId,
    "purchase_note": purchaseNote,
    "categories": categories!=null ? List<dynamic>.from(categories!.map((x) => x.toJson())): null,
    "tags": tags!=null ? List<dynamic>.from(tags!.map((x) => x)): null,
    "images": images!=null ? List<dynamic>.from(images!.map((x) => x.toJson())): null,
    "attributes": attributes!=null ? List<dynamic>.from(attributes!.map((x) => x.toJson())): null,
    "default_attributes": defaultAttributes!=null ? List<dynamic>.from(defaultAttributes!.map((x) => x)): null,
    "variations": variations!=null ? List<dynamic>.from(variations!.map((x) => x)): null,
    "grouped_products": groupedProducts!=null ? List<dynamic>.from(groupedProducts!.map((x) => x)): null,
    "menu_order": menuOrder,
  };
  calculateDiscount(){
    if(!isValidString(regularPrice) || !isValidString(price) || regularPrice== "" ||price =="") return null;
    double regulerPrice =  regularPrice== "" ? 0: double.parse(regularPrice ?? "") ;
    double salePrice = price== "" ? 0: double.parse(price ?? "") ;
    double discount = regulerPrice.toDouble()-salePrice ;
    double disPercent = (discount/regulerPrice)*100;
    return disPercent.round();
  }
}

class Attribute {
  Attribute({
    this.name,
    this.slug,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });

  String? name;
  String? slug;
  int? position;
  bool? visible;
  bool? variation;
  List<dynamic>? options;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    name: json["name"],
    slug: json["slug"],
    position: json["position"],
    visible: json["visible"],
    variation: json["variation"],
    options: json["options"]!=null ? List<dynamic>.from(json["options"].map((x) => x)): null,
  );

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "slug": slugValues.reverse[slug],
    "position": position,
    "visible": visible,
    "variation": variation,
    "options": options!=null ? List<dynamic>.from(options!.map((x) => x)): null,
  };
}
enum Backorders { NO }

final backordersValues = EnumValues({
  "no": Backorders.NO
});

enum Name { COLOR, LOGO, SIZE }

final nameValues = EnumValues({
  "Color": Name.COLOR,
  "Logo": Name.LOGO,
  "Size": Name.SIZE
});

class OptionClass {
  OptionClass({
    this.termId,
    this.name,
    this.slug,
    this.termGroup,
    this.termTaxonomyId,
    this.taxonomy,
    this.description,
    this.parent,
    this.count,
    this.filter,
  });

  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  Slug? taxonomy;
  String? description;
  int? parent;
  int? count;
  Filter? filter;

  factory OptionClass.fromJson(Map<String, dynamic> json) => OptionClass(
    termId: json["term_id"],
    name: json["name"],
    slug: json["slug"],
    termGroup: json["term_group"],
    termTaxonomyId: json["term_taxonomy_id"],
    taxonomy: json["taxonomy"]!=null ? slugValues.map![json["taxonomy"]]: null,
    description: json["description"],
    parent: json["parent"],
    count: json["count"],
    filter: json["filter"]!=null ? filterValues.map![json["filter"]]: null,
  );

  Map<String, dynamic> toJson() => {
    "term_id": termId,
    "name": name,
    "slug": slug,
    "term_group": termGroup,
    "term_taxonomy_id": termTaxonomyId,
    "taxonomy": slugValues.reverse[taxonomy],
    "description": description,
    "parent": parent,
    "count": count,
    "filter": filterValues.reverse[filter],
  };
}

enum Filter { RAW }

final filterValues = EnumValues({
  "raw": Filter.RAW
});

enum Slug { PA_COLOR, LOGO, PA_SIZE }

final slugValues = EnumValues({
  "logo": Slug.LOGO,
  "pa_color": Slug.PA_COLOR,
  "pa_size": Slug.PA_SIZE
});


enum ButtonText { EMPTY, BUY_ON_THE_WORD_PRESS_SWAG_STORE }

final buttonTextValues = EnumValues({
  "Buy on the WordPress swag store!": ButtonText.BUY_ON_THE_WORD_PRESS_SWAG_STORE,
  "": ButtonText.EMPTY
});

enum CatalogVisibility { VISIBLE }

final catalogVisibilityValues = EnumValues({
  "visible": CatalogVisibility.VISIBLE
});

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
  });

  int? id;
  String? name;
  String? slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}

class Images {
  Images({
    this.id,
    this.src,
    this.name,
    this.alt,
    this.position,
  });

  int? id;
  String? src;
  String? name;
  String? alt;
  int? position;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    id: json["id"],
    src: json["src"],
    name: json["name"],
    alt: json["alt"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "src": src,
    "name": name,
    "alt": alt,
    "position": position,
  };
}

enum Status { PUBLISH }

final statusValues = EnumValues({
  "publish": Status.PUBLISH
});

enum TaxStatus { TAXABLE }

final taxStatusValues = EnumValues({
  "taxable": TaxStatus.TAXABLE
});

enum Type { SIMPLE, VARIABLE, GROUPED, EXTERNAL }

final typeValues = EnumValues({
  "external": Type.EXTERNAL,
  "grouped": Type.GROUPED,
  "simple": Type.SIMPLE,
  "variable": Type.VARIABLE
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
