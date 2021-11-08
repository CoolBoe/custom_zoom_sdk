/*-------------User Constants-----------*/

import 'package:flutter/cupertino.dart';
import 'package:wooapp/models/cityModel.dart';
const String appName = 'Woo App';
const String fontName = 'Poppins';
const String app_Theme = 'app_theme';
const String dark_Mode = 'dark_mode';
const String light_Mode = 'light_mode';
const String USER_MODEL = 'user_model';
const String InCompleteDataError = 'Please Enter a Valid info';
const String InCompletePasswordError = 'Please Enter a Valid password';
const String InCompleteEmailError = 'Please Enter a Valid Email Id';
const String USERINFO = 'user_info';
const String USER_EMAIL = 'email';
const String WISHLIST = 'wishList';
const String IsLogin = 'islogin';
const String USER_ID = 'id';
const String MYADDRESSLISTS = 'my_address_lists';
const String USER_MODEL_PREFS_KEY = 'user_model';
const String USER_FB_ID = 'fb_id';
const String ACCESS_TOKEN = 'access_token';
const String USER_FIRST_NAME = 'first_name';
const String USER_LAST_NAME = 'last_name';
const String USER_NAME = 'username';
const String USER_ADDRESS = 'useraddress';
const String USER_ROLE = 'role';
const String AVTAR_URL = 'avtar_url';
const String IS_PAYING_CUSTOMER = 'is_paying_customer';
const String STATE = 'state';
const String PHONE = 'phone';
const String COUNTRY = 'country';
const String POSTCODE = 'postcode';
const String CITY = 'city';
const String SOCIAL_LOGIN_MODE = 'mode';
const String CATEGORY_ID = 'category_id';
const String PIC_URL = 'pic_url';
const String LOGIN_STATUS_TRUE = 'User Logged in Successfully';
const String PAY_METHOD_NOT_FOUND = 'please select payment method';
const String PRODUCT_BY = 'product_By';
const String CHOOSE_CATEGORY = 'Choose Category';

/*------------PriceRangeModel-------------------*/
const String MIN_PRICE = 'min_price';
const String MAX_PRICE = 'max_price';

/*------------Product Listing----------------------*/
const String DEFAULT = '0';
const String CATEGORY = '1';
const String PRICE = '2';
const String BRAND = '3';
const String FEATURED = '4';
const String ON_SALE = '5';
const String BYSEARCH = '6';

/*------------Product Sorting----------------------*/

/*----------Error Massage----------------------*/
const String NETWORK_ERROR = 'Something Went Wrong';
const String DATA_NOT_FOUND = 'Data Not Found';
const String LOGIN_STATUS_FALSE = 'User Login Failed';
const String EMAIL_NOT_FOUND = 'Email Id Not Found';
const String USER_NOT_FOUND = 'User Not Found';
const String ENTER_USER_NAME = 'Please Enter your name';
const String ENTER_USER_EMAIL = 'Please Enter your email';
const String USER_LOGOUT = 'Logout Successfully';
const String ENTER_USER_PASSWORD = 'Please Enter your password';
const String ACCEPT_TRMS = 'Please check Remember me to keep login';
const int HTTP_CODE_200 = 200;
const int HTTP_CODE_201 = 200;
const int HTTP_CODE_404 = 404;
const int HTTP_CODE_500 = 500;

/*----------------IC_SVG_Image-------------------------*/
const String Thumbnail_User =
    "https://secure.gravatar.com/avatar/0ebdca653970c966ce5e8bf84a1d0a5a?s=96&d=mm&r=g";

/*--------------------Woo App---------------------------*/
// const String CategoryThumbnailUrl="https://www.evnox.com/wp-content/uploads/2018/08/evnox-logo.jpg";
// const String BannerThumbnailUrl= "https://www.evnox.com/wp-content/uploads/2018/08/hompage-header-01.jpg";
/*------------------------evnox.com----------------------------*/
// const String CategoryThumbnailUrl =
//     "https://www.evnox.com/wp-content/uploads/2018/08/evnox-logo.jpg";
// const String BannerThumbnailUrl =
//     "https://www.evnox.com/wp-content/uploads/2018/08/hompage-header-01.jpg";

/*------------------------bizzon.com----------------------------*/
// const String CategoryThumbnailUrl="https://bizzon.in/wp-content/uploads/2021/01/lycs-architecture-U2BI3GMnSSE-unsplash-320x320.jpg?v=1610700194";
// const String BannerThumbnailUrl= "https://bizzon.in/wp-content/uploads/2020/09/BizzonSale-2-1024x858.jpg?v=1599248859";

// /*------------------------https://ecommerceshopindia.com/----------------------------*/
// const String CategoryThumbnailUrl="https://ecommerceshopindia.com/wp-content/uploads/2016/08/dummy-prod-1-4-500x500.jpg";
// const String BannerThumbnailUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuFt4g6oKhnuMGQ7uaUA6fvEHujf28PedLOQ&usqp=CAU";

/*------------------------https://ecommerceshopindia.com/----------------------------*/
const String CategoryThumbnailUrl="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjGcrB3L2RVYdjYnYoXmhIQjX5I3otbr6Yrw&usqp=CAU";
const String BannerThumbnailUrl = "https://www.paatisuttapalakaram.com/wp-content/uploads/2021/10/cropped-Logo-Main-8-1.jpg";

const String ic_facebook = "assets/icons/ic_facebook.svg";
const String ic_backpack = "assets/icons/ic_backpack.svg";
const String ic_bag = "assets/icons/ic_bag.svg";
const String ic_call = "assets/icons/ic_call.svg";
const String ic_categories = "assets/icons/ic_categories.svg";
const String ic_chat = "assets/icons/ic_chat.svg";
const String ic_cloth = "assets/icons/ic_cloth.svg";
const String ic_coupon = "assets/icons/ic_coupon.svg";
const String ic_drawer = "assets/icons/ic_drawer.svg";
const String ic_eyeglasses = "assets/icons/ic_eyeglasses.svg";
const String ic_filter = "assets/icons/ic_filter.svg";
const String ic_heart = "assets/icons/ic_heart.svg";
const String ic_home = "assets/icons/ic_home.svg";
const String ic_hoodie = "assets/icons/ic_hoodie.svg";
const String ic_location = "assets/icons/ic_location.svg";
const String ic_logout = "assets/icons/ic_logout.svg";
const String ic_order = "assets/icons/ic_order.svg";
const String ic_rating = "assets/icons/ic_rating.svg";
const String ic_remove = "assets/icons/ic_remove.svg";
const String ic_search = "assets/icons/ic_search.svg";
const String ic_shop = "assets/icons/ic_shop.svg";
const String ic_shoppingcart = "assets/icons/ic_shoppingcart.svg";
const String ic_skirt = "assets/icons/ic_skirt.svg";
const String ic_sneaker = "assets/icons/ic_sneaker.svg";
const String ic_sortby = "assets/icons/ic_sortby.svg";
const String ic_support = "assets/icons/ic_support.svg";
const String ic_trousers = "assets/icons/ic_trousers.svg";
const String ic_watch = "assets/icons/ic_watch.svg";
const String ic_likee = "assets/icons/ic_like.svg";
/*-----------------IC_Images_Assets--------------------*/
const String ic_bg_lock = "assets/images/bg_lock.png";
const String ic_bg_login = "assets/images/bg_login.png";
const String ic_drawer_png = "assets/images/ic_drawer.png";
const String ic_oops_png = "assets/images/ic_oops.png";
const String ic_google_png = "assets/images/ic_google.png";
const String ic_money = "assets/images/ic_money.png";
const String ic_nodata_png = "assets/images/ic_nodata.png";
const String ic_promocode_png = "assets/images/ic_promocode.png";
const String ic_more_png = "assets/images/ic_more.png";
const String ic_thumbnail_png = "assets/images/ic_thumbnail.png";

const String ic_address_png = "assets/images/ic_address.png";
const String ic_email_png = "assets/images/ic_email.png";
const String ic_globe_png = "assets/images/ic_globe.png";
const String ic_pass_png = "assets/images/ic_pass.png";
const String ic_phone_png = "assets/images/ic_phone.png";

//ic_thumbnail.png
/*-----------------SizeBuilder---------------------------*/
const double dp5 = 5.0;
const double dp10 = 10.0;
const double dp15 = 15.0;
const double dp20 = 20.0;
const double dp25 = 25.0;
const double dp30 = 30.0;
const double dp35 = 35.0;
const double dp40 = 40.0;
const double dp45 = 45.0;
const double dp50 = 50.0;
const double dp55 = 55.0;
const double dp60 = 60.0;
const double dp65 = 65.0;
const double dp70 = 70.0;
const double dp75 = 75.0;
const double dp80 = 80.0;
const double dp85 = 85.0;
const double dp90 = 90.0;
const double dp95 = 95.0;
const double dp100 = 100.0;

/*-------------------FontWeight-------------------------*/
const FontWeight thin = FontWeight.w100;
const FontWeight extraLight = FontWeight.w200;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semiBold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extraBold = FontWeight.w800;
const FontWeight dark = FontWeight.w900;

/*--------------------SortBy List-------------------------------*/

List<CityModel> countryList = [
  CityModel(id: "101", sortName: "IN", name: "India", code: "91")
];

List<CityModel> stateList = [
  CityModel(
      id: "1",
      sortName: "",
      name: "Andaman and Nicobar Islands",
      code: "91"),
  CityModel(id: "2", sortName: "", name: "Andhra Pradesh", code: "91"),
  CityModel(id: "3", sortName: "", name: "Arunachal Pradesh", code: "91"),
  CityModel(id: "4", sortName: "", name: "Assam", code: "91"),
  CityModel(id: "5", sortName: "", name: "Bihar", code: "91"),
  CityModel(id: "5", sortName: "", name: "Chandigarh", code: "91"),
  CityModel(id: "6", sortName: "", name: "Chhattisgarh", code: "91"),
  CityModel(
      id: "7", sortName: "", name: "Dadra and Nagar Haveli", code: "91"),
  CityModel(id: "8", sortName: "", name: "Daman and Diu", code: "91"),
  CityModel(id: "9", sortName: "", name: "Delhi", code: "91"),
  CityModel(id: "9", sortName: "", name: "Goa", code: "91"),
  CityModel(id: "10", sortName: "", name: "Gujarat", code: "91"),
  CityModel(id: "11", sortName: "", name: "Haryana", code: "91"),
  CityModel(id: "12", sortName: "", name: "Himachal Pradesh", code: "91"),
  CityModel(id: "13", sortName: "", name: "Jammu and Kashmir", code: "91"),
  CityModel(id: "14", sortName: "", name: "Jharkhand", code: "91"),
  CityModel(id: "15", sortName: "", name: "Karnataka", code: "91"),
  CityModel(id: "16", sortName: "", name: "Kenmore", code: "91"),
  CityModel(id: "17", sortName: "", name: "Kerala", code: "91"),
  CityModel(id: "18", sortName: "", name: "Lakshadweep", code: "91"),
  CityModel(id: "19", sortName: "", name: "Madhya Pradesh", code: "91"),
  CityModel(id: "20", sortName: "", name: "Maharashtra", code: "91"),
  CityModel(id: "21", sortName: "", name: "Manipur", code: "91"),
  CityModel(id: "22", sortName: "", name: "Meghalaya", code: "91"),
  CityModel(id: "23", sortName: "", name: "Mizoram", code: "91"),
  CityModel(id: "24", sortName: "", name: "Nagaland", code: "91"),
  CityModel(id: "25", sortName: "", name: "Narora", code: "91"),
  CityModel(id: "26", sortName: "", name: "Natwar", code: "91"),
  CityModel(id: "27", sortName: "", name: "Odisha", code: "91"),
  CityModel(id: "28", sortName: "", name: "Paschim Medinipu", code: "91"),
  CityModel(id: "29", sortName: "", name: "Pondicherry", code: "91"),
  CityModel(id: "30", sortName: "", name: "Punjab", code: "91"),
  CityModel(id: "31", sortName: "", name: "Rajasthan", code: "91"),
  CityModel(id: "32", sortName: "", name: "Sikkim", code: "91"),
  CityModel(id: "33", sortName: "", name: "Tamil Nadu", code: "91"),
  CityModel(id: "34", sortName: "", name: "Telangana", code: "91"),
  CityModel(id: "35", sortName: "", name: "Tripura", code: "91"),
  CityModel(id: "36", sortName: "", name: "Uttar Pradesh", code: "91"),
  CityModel(id: "37", sortName: "", name: "Uttarakhand", code: "91"),
  CityModel(id: "38", sortName: "", name: "Vaishali", code: "91"),
  CityModel(id: "39", sortName: "", name: "West Bengal", code: "91"),
];

/*-------------------------payment--------------------------------*/
const String paypalURL = "https://api.sandbox.paypal.com";
const String paypalClientId =
    "AQpctZmexFjg0jjRFncorRO5ZbOTlARoFdEMWc3A3Sh2qEKXkRoLcdPaaXfAuNxnQItCVFCQl5oUTkOf";
const String paypalSecretKey =
    "EIwYvq2epkKfi6df2ZBqU8Rh2lGNGYTPY-2cMDCesEegsmAo5WXPEhzK3fElsyqSiyPMwR8_QArOxKw5";
const String returnURL = "return.snippetcoder.com";
const String cancelURL = "cancel.snippetcoder.com";

/*-------------------------razor pay--------------------------------*/
const String RazorPayKey = "rzp_test_2akds9ynth1XSc";

/*-------------------------PayU Money--------------------------------*/
const String PayUmerchantKey = "Z9ZieeCK";
const String PayUmerchantID = "7In9PCvzd5";