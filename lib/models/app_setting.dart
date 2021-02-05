// To parse this JSON data, do
//
//     final appSetting = appSettingFromJson(jsonString);

import 'dart:convert';

AppSetting appSettingFromJson(String str) => AppSetting.fromJson(json.decode(str));

String appSettingToJson(AppSetting data) => json.encode(data.toJson());

class AppSetting {
  AppSetting({
    this.secondaryTextColor,
    this.primaryTextColor,
    this.accentColor,
    this.primaryColorText,
    this.primaryColorLight,
    this.primaryColorDark,
    this.primaryColor,
    this.contactEmail,
    this.contactPhone,
    this.googleAnalyticsTrackerId,
    this.directTawkId,
    this.oneSignalAppId,
    this.currentAppVersion,
    this.appStatus,
    this.googleProjectNumber,
    this.referearn,
    this.walletActive,
    this.pincodeActive,
    this.price,
    this.enableTermCondition,
    this.enableFaq,
  });

  String secondaryTextColor;
  String primaryTextColor;
  String accentColor;
  String primaryColorText;
  String primaryColorLight;
  String primaryColorDark;
  String primaryColor;
  String contactEmail;
  String contactPhone;
  String googleAnalyticsTrackerId;
  String directTawkId;
  String oneSignalAppId;
  String currentAppVersion;
  String appStatus;
  String googleProjectNumber;
  bool referearn;
  bool walletActive;
  bool pincodeActive;
  Price price;
  bool enableTermCondition;
  bool enableFaq;

  factory AppSetting.fromJson(Map<String, dynamic> json) => AppSetting(
    secondaryTextColor: json["secondary_text_color"],
    primaryTextColor: json["primary_text_color"],
    accentColor: json["accent_color"],
    primaryColorText: json["primary_color_text"],
    primaryColorLight: json["primary_color_light"],
    primaryColorDark: json["primary_color_dark"],
    primaryColor: json["primary_color"],
    contactEmail: json["contact_email"],
    contactPhone: json["contact_phone"],
    googleAnalyticsTrackerId: json["google_analytics_tracker_id"],
    directTawkId: json["direct_tawk_id"],
    oneSignalAppId: json["one_signal_app_id"],
    currentAppVersion: json["current_app_version"],
    appStatus: json["app_status"],
    googleProjectNumber: json["google_project_number"],
    referearn: json["referearn"],
    walletActive: json["wallet_active"],
    pincodeActive: json["pincode_active"],
    price: Price.fromJson(json["price"]),
    enableTermCondition: json["enable_term_condition"] is bool ? json["enable_term_condition"] : false,
    enableFaq: json["enable_faq"],
  );

  Map<String, dynamic> toJson() => {
    "secondary_text_color": secondaryTextColor,
    "primary_text_color": primaryTextColor,
    "accent_color": accentColor,
    "primary_color_text": primaryColorText,
    "primary_color_light": primaryColorLight,
    "primary_color_dark": primaryColorDark,
    "primary_color": primaryColor,
    "contact_email": contactEmail,
    "contact_phone": contactPhone,
    "google_analytics_tracker_id": googleAnalyticsTrackerId,
    "direct_tawk_id": directTawkId,
    "one_signal_app_id": oneSignalAppId,
    "current_app_version": currentAppVersion,
    "app_status": appStatus,
    "google_project_number": googleProjectNumber,
    "referearn": referearn,
    "wallet_active": walletActive,
    "pincode_active": pincodeActive,
    "price": price.toJson(),
    "enable_term_condition": enableTermCondition,
    "enable_faq": enableFaq,
  };
}

class Price {
  Price({
    this.min,
    this.max,
    this.minWithSymbol,
    this.maxWithSymbol,
  });

  int min;
  int max;
  String minWithSymbol;
  String maxWithSymbol;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    min: json["min"],
    max: json["max"],
    minWithSymbol: json["min_with_symbol"],
    maxWithSymbol: json["max_with_symbol"],
  );

  Map<String, dynamic> toJson() => {
    "min": min,
    "max": max,
    "min_with_symbol": minWithSymbol,
    "max_with_symbol": maxWithSymbol,
  };
}
