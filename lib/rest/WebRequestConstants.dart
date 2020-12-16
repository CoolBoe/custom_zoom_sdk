import 'dart:convert';

class WebRequestConstants{

  static const String getDomainUrl ="/wp-json/wc/v2/";

  static const String getBaseUrl ="https://app.democontentphoeniixx.com";

  static const String getWPBaseUrl= "https://wooapp.themiixx.com";


//  String getDomainUrl ="https://app.democontentphoeniixx.com/wp-json/wc/v2/";
//  String getDomainWebUrl= "https://app.democontentphoeniixx.com/wp-json/wc/v2/";

  static const String SMS_SENDER = "APP";
  static const String MOBILE_CODE = "+91";
  static const String DEVICE_TYPE = "android";
  static const String VERIFICATION = "newreg";
  static const String FORGOT_PASSWORD = "forget-password";
  static const String USER_LOGOUT = "logout";
  static const String REGISTER= "register";
  static const String CHANGE_PASSWORD = "change-password";
  static const String SOCIAL_LOGIN = "social-login";
  static const String LOGIN="login";
  static const String ALL_CATEGORIES="products/all-categories";
  static const String PRODUCT="products";
  static const String CUSTOM_PRODUCT="custom-products";
  static const String PRICE_RANGE="products/price-range";
  static const String PRODUCT_BY_ID ="get-product-by-id";
  static const String SORT ="sort";
  static const String PAGE = "page";
  static const String PER_PAGE = "per_page";

  /*--------------------------------Cart Filters-----------------------------------------------------*/
  static const String CART = "cart";
  static const String ADD_CART = "cart/add";
  static const String CART_UPDATE = "cart/update";
  static const String CART_REMOVE = "cart/remove";
  static const String CART_CLEAR = "cart/clear";
  static const String CART_TOTAL ="cart/totals";
  static const String COUPON = "cart/coupon";
  static const String REMOVE_COUPON = "cart/remove-coupon";
  static const String CART_ITEM_COUNT= "cart/item-count";

  /*-----------------------------Product Filters-----------------------------------------*/
  static const String CATEGORY= "category";
  static const String BRAND= "brand";
  static const String SEARCH= "search";
  static const String MAX_PRICE = "max_price";
  static const String MIN_PRICE = "min_price";
  static const String ON_SALE = "on_sale";
  static const String ON_SEARCH = "search";
  static const String FEATURED = "featured";

  /*-------------------------------------Sort Filters-----------------------------------------------------------------*/
  static const String SORT_BY_DEFAULT = "default";
  static const String SORT_BY_POPULARITY = "popularity";
  static const String SORT_BY_RATING ="rating";
  static const String SORT_BY_DATE ="date";
  static const String SORT_BY_PRICE_DESC = "price_desc";
  static const String SORT_BY_PRICE_ASC = "price_asc";






}