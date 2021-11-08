class Coupon {
  Coupon({
    this.code,
    this.discount,
  });

  String? code;
  String? discount;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    code: json["code"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "discount": discount,
  };
}