import 'dart:convert';

class WebRequestConstants {
  static const String getDomainUrl = "/wp-json/wc/v2/";

  static const String getBaseUrl = "https://app.democontentphoeniixx.com";
  static const String BaseAuthId =
      "ck_182712e047bc83b22974476388360fca763c0005";
  static const String BaseAuthPass =
      "cs_3351fba7577bb78534600af478007e73f8babd4e";
  static const String getWPBaseUrl = "https://wooapp.themiixx.com";

  static const String getPlaceUrl = "https://location.wlfpt.co/api/v1/";
    String BaseAuth =
      'Basic ' + base64Encode(utf8.encode('$BaseAuthId:$BaseAuthPass'));
  static const String COOKIES = "Cookie";

//  String getDomainUrl ="https://app.democontentphoeniixx.com/wp-json/wc/v2/";
//  String getDomainWebUrl= "https://app.democontentphoeniixx.com/wp-json/wc/v2/";

  static const String SMS_SENDER = "APP";
  static const String MOBILE_CODE = "+91";
  static const String DEVICE_TYPE = "android";
  static const String VERIFICATION = "newreg";
  static const String FORGOT_PASSWORD = "forget-password";
  static const String USER_LOGOUT = "logout";
  static const String REGISTER = "register";
  static const String CHANGE_PASSWORD = "change-password";
  static const String SOCIAL_LOGIN = "social-login";
  static const String LOGIN = "login";
  static const String ALL_CATEGORIES = "products/all-categories";
  static const String PRODUCT = "products";
  static const String CUSTOM_PRODUCT = "custom-products";
  static const String PRICE_RANGE = "products/price-range";
  static const String PRODUCT_BY_ID = "get-products-by-id";
  static const String SORT = "sort";
  static const String PAGE = "page";
  static const String PER_PAGE = "per_page";

  static const String CUSTOMERS = "customers";
  static const String UPDATE_BILLING = "checkout/update-billing";
  static const String PAYTM_CHECKSUM = "paytm-checksum";
  static const String PAYMENT = "payment";
  static const String UPDATE_ORDER = "checkout/update-order";
  static const String NEW_ORDER ="checkout/new-order";
  static const String PAYMENT_GATEWAY = "checkout/payment-gateway";
  static const String REVIEW_ORDER = "checkout/review-order";

  static const String ORDER_ID = "ORDER_ID";
  static const String CUST_ID_METHOD = "CUST_ID METHOD";

  /*--------------------------------Cart Filters-----------------------------------------------------*/
  static const String CART = "cart";
  static const String ADD_CART = "cart/add";
  static const String CART_UPDATE = "cart/update";
  static const String CART_REMOVE = "cart/remove";
  static const String CART_CLEAR = "cart/clear";
  static const String CART_TOTAL = "cart/totals";
  static const String COUPON = "coupons";
  static const String REMOVE_COUPON = "cart/remove-coupon";
  static const String CART_ITEM_COUNT = "cart/item-count";
  static const String QUANTITY = "quantity";
  static const String VARIATION = "variation";
  static const String VARIATION_ID = "variation_id";
  static const String CART_ITEM_KEY = "cart_item_key";
  static const String REVIEWORDER = "review-order";

  /*-----------------------------Product Filters-----------------------------------------*/
  static const String CATEGORY = "category";
  static const String BRAND = "brand";
  static const String SEARCH = "search";
  static const String MAX_PRICE = "max_price";
  static const String MIN_PRICE = "min_price";
  static const String ON_SALE = "on_sale";
  static const String ON_SEARCH = "search";
  static const String FEATURED = "featured";
  static const String PRODUCT_ID = "id";

  /*-------------------------------------Sort Filters-----------------------------------------------------------------*/
  static const String SORT_BY_DEFAULT = "default";
  static const String SORT_BY_POPULARITY = "popularity";
  static const String SORT_BY_RATING = "rating";
  static const String SORT_BY_DATE = "date";
  static const String SORT_BY_PRICE_DESC = "price_desc";
  static const String SORT_BY_PRICE_ASC = "price_asc";

  /*-------------------------------------Place Constants-----------------------------------------------------------------*/
  static const String COUNTRIES = "countries";
  static const String STATES = "states";
  static const String CITIES = "cities";
  static const String PLACE_FILTER = "filter";
}
