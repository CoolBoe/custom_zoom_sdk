// To parse this JSON data, do
//
//     final homeLayout = homeLayoutFromJson(jsonString);

import 'dart:convert';

import 'package:wooapp/models/product.dart';

HomeLayout homeLayoutFromJson(String str) => HomeLayout.fromJson(json.decode(str));

String homeLayoutToJson(HomeLayout data) => json.encode(data.toJson());

class HomeLayout {
  HomeLayout({
    this.topSeller,
    this.tspnumber,
    this.featuredProducts,
    this.fpnumber,
    this.saleProducts,
    this.salepnumber,
    this.topRatedProducts,
    this.topRatedPnumber,
    this.sectionBanners,
    this.banners,
    this.categories,
  });

  List<ProductModel> topSeller;
  int tspnumber;
  List<ProductModel> featuredProducts;
  int fpnumber;
  List<ProductModel> saleProducts;
  int salepnumber;
  List<ProductModel> topRatedProducts;
  int topRatedPnumber;
  List<SectionBanner> sectionBanners;
  List<HomeLayoutBanner> banners;
  List<HomeLayoutCategory> categories;

  factory HomeLayout.fromJson(Map<String, dynamic> json) => HomeLayout(
    topSeller:json["top_seller"] ==null || json["top_seller"]==false ? null: List<ProductModel>.from(json["top_seller"].map((x) => ProductModel.fromJson(x))),
    tspnumber: json["tspnumber"],
    featuredProducts: json["featured_products"] ==null || json["featured_products"]==false ? null: List<ProductModel>.from(json["featured_products"].map((x) => ProductModel.fromJson(x))),
    fpnumber: json["fpnumber"],
    saleProducts:json["sale_products"] ==null || json["sale_products"]==false ? null: List<ProductModel>.from(json["sale_products"].map((x) => ProductModel.fromJson(x))),
    salepnumber: json["salepnumber"],
    topRatedProducts:json["top_rated_products"] ==null || json["top_rated_products"]==false ? null:  List<ProductModel>.from(json["top_rated_products"].map((x) => ProductModel.fromJson(x))),
    topRatedPnumber: json["top_rated_pnumber"],
    sectionBanners: List<SectionBanner>.from(json["section_banners"].map((x) => SectionBanner.fromJson(x))),
    banners: List<HomeLayoutBanner>.from(json["banners"].map((x) => HomeLayoutBanner.fromJson(x))),
    categories: List<HomeLayoutCategory>.from(json["categories"].map((x) => HomeLayoutCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "top_seller": topSeller !=null ? List<dynamic>.from(topSeller.map((x) => x.toJson())): null,
    "tspnumber": tspnumber,
    "featured_products": List<dynamic>.from(featuredProducts.map((x) => x.toJson())),
    "fpnumber": fpnumber,
    "sale_products": List<dynamic>.from(saleProducts.map((x) => x.toJson())),
    "salepnumber": salepnumber,
    "top_rated_products": List<dynamic>.from(topRatedProducts.map((x) => x.toJson())),
    "top_rated_pnumber": topRatedPnumber,
    "section_banners": List<dynamic>.from(sectionBanners.map((x) => x.toJson())),
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class HomeLayoutBanner {
  HomeLayoutBanner({
    this.title,
    this.location,
    this.banner,
  });

  String title;
  String location;
  List<BannerBanner> banner;

  factory HomeLayoutBanner.fromJson(Map<String, dynamic> json) => HomeLayoutBanner(
    title: json["title"],
    location: json["location"],
    banner: List<BannerBanner>.from(json["banner"].map((x) => BannerBanner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "location": location,
    "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
  };
}

class BannerBanner {
  BannerBanner({
    this.bannerType,
    this.connectId,
    this.bannerUrl,
  });

  String bannerType;
  String connectId;
  String bannerUrl;

  factory BannerBanner.fromJson(Map<String, dynamic> json) => BannerBanner(
    bannerType: json["banner_type"],
    connectId: json["connect_id"],
    bannerUrl: json["banner_url"],
  );

  Map<String, dynamic> toJson() => {
    "banner_type": bannerType,
    "connect_id": connectId,
    "banner_url": bannerUrl,
  };
}

class HomeLayoutCategory {
  HomeLayoutCategory({
    this.name,
    this.id,
    this.image,
  });

  String name;
  String id;
  String image;

  factory HomeLayoutCategory.fromJson(Map<String, dynamic> json) => HomeLayoutCategory(
    name: json["name"],
    id: json["id"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "image": image == null ? null : image,
  };
}


enum TaxonomyEnum { PA_COLOR, PA_SIZE }

final taxonomyEnumValues = EnumValues({
  "pa_color": TaxonomyEnum.PA_COLOR,
  "pa_size": TaxonomyEnum.PA_SIZE
});

enum Backorders { NO }

final backordersValues = EnumValues({
  "no": Backorders.NO
});

enum CatalogVisibility { VISIBLE, HIDDEN }

final catalogVisibilityValues = EnumValues({
  "hidden": CatalogVisibility.HIDDEN,
  "visible": CatalogVisibility.VISIBLE
});



enum CategoryName { HOODIES, ACCESSORIES, TSHIRTS, MUSIC }

final categoryNameValues = EnumValues({
  "Accessories": CategoryName.ACCESSORIES,
  "Hoodies": CategoryName.HOODIES,
  "Music": CategoryName.MUSIC,
  "Tshirts": CategoryName.TSHIRTS
});

enum CategorySlug { HOODIES, ACCESSORIES, TSHIRTS, MUSIC }

final categorySlugValues = EnumValues({
  "accessories": CategorySlug.ACCESSORIES,
  "hoodies": CategorySlug.HOODIES,
  "music": CategorySlug.MUSIC,
  "tshirts": CategorySlug.TSHIRTS
});

class Dimensions {
  Dimensions({
    this.length,
    this.width,
    this.height,
  });

  String length;
  String width;
  String height;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    length: json["length"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "length": length,
    "width": width,
    "height": height,
  };
}

class Download {
  Download({
    this.id,
    this.name,
    this.file,
  });

  String id;
  String name;
  String file;

  factory Download.fromJson(Map<String, dynamic> json) => Download(
    id: json["id"],
    name: json["name"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "file": file,
  };
}

class Images {
  Images({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
    this.position,
  });

  int id;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String src;
  String name;
  String alt;
  int position;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    id: json["id"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
    dateModified: DateTime.parse(json["date_modified"]),
    dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
    src: json["src"],
    name: json["name"],
    alt: json["alt"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_created": dateCreated.toIso8601String(),
    "date_created_gmt": dateCreatedGmt.toIso8601String(),
    "date_modified": dateModified.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt.toIso8601String(),
    "src": src,
    "name": name,
    "alt": alt,
    "position": position,
  };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection> self;
  List<Collection> collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
  };
}

class Collection {
  Collection({
    this.href,
  });

  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}





enum ShippingClass { RAJASTHAN }

final shippingClassValues = EnumValues({
  "rajasthan": ShippingClass.RAJASTHAN
});

enum ShortDescription { P_THIS_IS_A_SIMPLE_PRODUCT_P, P_THIS_IS_A_VARIABLE_PRODUCT_P, P_THIS_IS_A_SIMPLE_VIRTUAL_PRODUCT_P }

final shortDescriptionValues = EnumValues({
  "<p>This is a simple product.</p>\n": ShortDescription.P_THIS_IS_A_SIMPLE_PRODUCT_P,
  "<p>This is a simple, virtual product.</p>\n": ShortDescription.P_THIS_IS_A_SIMPLE_VIRTUAL_PRODUCT_P,
  "<p>This is a variable product.</p>\n": ShortDescription.P_THIS_IS_A_VARIABLE_PRODUCT_P
});

enum Status { PUBLISH }

final statusValues = EnumValues({
  "publish": Status.PUBLISH
});

enum TaxStatus { TAXABLE }

final taxStatusValues = EnumValues({
  "taxable": TaxStatus.TAXABLE
});

enum Type { SIMPLE, VARIABLE }

final typeValues = EnumValues({
  "simple": Type.SIMPLE,
  "variable": Type.VARIABLE
});

class SectionBanner {
  SectionBanner({
    this.title,
    this.layoutType,
    this.backgroundColor,
    this.titleColor,
    this.banner,
  });

  String title;
  String layoutType;
  String backgroundColor;
  String titleColor;
  List<BannerBanner> banner;

  factory SectionBanner.fromJson(Map<String, dynamic> json) => SectionBanner(
    title: json["title"],
    layoutType: json["layout_type"],
    backgroundColor: json["background_color"],
    titleColor: json["title_color"],
    banner: List<BannerBanner>.from(json["banner"].map((x) => BannerBanner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "layout_type": layoutType,
    "background_color": backgroundColor,
    "title_color": titleColor,
    "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
  };
}
