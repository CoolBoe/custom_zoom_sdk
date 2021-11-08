
class PinCodeDelivery {
  PinCodeDelivery({
    this.delivery,
  });

  bool? delivery;

  factory PinCodeDelivery.fromJson(Map<String, dynamic> json) => PinCodeDelivery(
    delivery: json["delivery"],
  );

  Map<String, dynamic> toJson() => {
    "delivery": delivery,
  };
}