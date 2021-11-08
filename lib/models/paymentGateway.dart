// To parse this JSON data, do
//
//     final paymentGateway = paymentGatewayFromJson(jsonString);

import 'dart:convert';

List<PaymentGateway> paymentGatewayFromJson(String str) => List<PaymentGateway>.from(json.decode(str).map((x) => PaymentGateway.fromJson(x)));

String paymentGatewayToJson(List<PaymentGateway> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentGateway {
  PaymentGateway({
    this.gatewayTitle,
    this.gatewayId,
    this.gatewayOrderButtonText,
    this.gatewayChosen,
    this.gatewayIcon,
    this.gatewayDescription,
  });

  String? gatewayTitle;
  String? gatewayId;
  String? gatewayOrderButtonText;
  dynamic gatewayChosen;
  String? gatewayIcon;
  String? gatewayDescription;

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
    gatewayTitle: json["gateway_title"],
    gatewayId: json["gateway_id"],
    gatewayOrderButtonText: json["gateway_order_button_text"],
    gatewayChosen: json["gateway_chosen"],
    gatewayIcon: json["gateway_icon"],
    gatewayDescription: json["gateway_description"],
  );

  Map<String, dynamic> toJson() => {
    "gateway_title": gatewayTitle,
    "gateway_id": gatewayId,
    "gateway_order_button_text": gatewayOrderButtonText,
    "gateway_chosen": gatewayChosen,
    "gateway_icon": gatewayIcon,
    "gateway_description": gatewayDescription,
  };
}
