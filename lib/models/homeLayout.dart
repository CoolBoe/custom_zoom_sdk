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
    this.pNumber,
    this.featuredProducts,
    this.fNumber,
    this.saleProducts,
    this.saleNumber,
    this.topRatedProducts,
    this.topRatedNumber,
    this.sectionBanners,
    this.banners,
    this.categories,
  });

  List<ProductModel>? topSeller;
  int? pNumber;
  List<ProductModel>? featuredProducts;
  int? fNumber;
  List<ProductModel>? saleProducts;
  int? saleNumber;
  List<ProductModel>? topRatedProducts;
  int? topRatedNumber;
  List<SectionBanner>? sectionBanners;
  List<HomeLayoutBanner>? banners;
  List<HomeLayoutCategory>? categories;

  factory HomeLayout.fromJson(Map<String, dynamic> json) => HomeLayout(
    topSeller:json["top_seller"] ==null || json["top_seller"]==false ? null: List<ProductModel>.from(json["top_seller"].map((x) => ProductModel.fromJson(x))),
    pNumber: json["tspnumber"],
    featuredProducts: json["featured_products"] ==null || json["featured_products"]==false ? null: List<ProductModel>.from(json["featured_products"].map((x) => ProductModel.fromJson(x))),
    fNumber: json["fpnumber"],
    saleProducts:json["sale_products"] ==null || json["sale_products"]==false ? null: List<ProductModel>.from(json["sale_products"].map((x) => ProductModel.fromJson(x))),
    saleNumber: json["salepnumber"],
    topRatedProducts:json["top_rated_products"] ==null || json["top_rated_products"]==false ? null:  List<ProductModel>.from(json["top_rated_products"].map((x) => ProductModel.fromJson(x))),
    topRatedNumber: json["top_rated_pnumber"],
    sectionBanners: json["section_banners"]==null ?  null : List<SectionBanner>.from(json["section_banners"].map((x) => SectionBanner.fromJson(x))),
    banners:json["banners"]==null ?  null :  List<HomeLayoutBanner>.from(json["banners"].map((x) => HomeLayoutBanner.fromJson(x))),
    categories: List<HomeLayoutCategory>.from(json["categories"].map((x) => HomeLayoutCategory.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    "top_seller": topSeller !=null ? List<dynamic>.from(topSeller!.map((x) => x.toJson())): null,
    "tspnumber": pNumber,
    "featured_products": featuredProducts!=null && featuredProducts!.length>0 ? List<dynamic>.from(featuredProducts!.map((x) => x.toJson())) : null,
    "fpnumber": fNumber,
    "sale_products": List<dynamic>.from(saleProducts!.map((x) => x.toJson())),
    "salepnumber": saleNumber,
    "top_rated_products": List<dynamic>.from(topRatedProducts!.map((x) => x.toJson())),
    "top_rated_pnumber": topRatedNumber,
    "section_banners":sectionBanners ==null || sectionBanners!.length<=0 ? null:  List<dynamic>.from(sectionBanners!.map((x) => x.toJson())),
    "banners":banners ==null || banners!.length<=0 ? null:  List<dynamic>.from(banners!.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class HomeLayoutBanner {
  HomeLayoutBanner({
    this.title,
    this.location,
    this.banner,
  });

  String? title;
  String? location;
  List<BannerBanner>? banner;

  factory HomeLayoutBanner.fromJson(Map<String, dynamic> json) => HomeLayoutBanner(
    title: json["title"],
    location: json["location"],
    banner: json["banner"]!=null ?
    List<BannerBanner>.from(json["banner"].map((x) => BannerBanner.fromJson(x))): null,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "location": location,
    "banner": banner!=null ? List<dynamic>.from(banner!.map((x) => x.toJson())): null,
  };
}

class BannerBanner {
  BannerBanner({
    this.bannerType,
    this.connectId,
    this.bannerUrl,
  });

  String? bannerType;
  String? connectId;
  String? bannerUrl;

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

  String? name;
  String? id;
  String? image;

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

  String? title;
  String? layoutType;
  String? backgroundColor;
  String? titleColor;
  List<BannerBanner>? banner;

  factory SectionBanner.fromJson(Map<String, dynamic> json) => SectionBanner(
    title: json["title"],
    layoutType: json["layout_type"],
    backgroundColor: json["background_color"],
    titleColor: json["title_color"],
    banner: json["banner"]!=null ?
    List<BannerBanner>.from(json["banner"].map((x) => BannerBanner.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "layout_type": layoutType,
    "background_color": backgroundColor,
    "title_color": titleColor,
    "banner": banner!=null ?
    List<dynamic>.from(banner!.map((x) => x.toJson())): null,
  };
}
