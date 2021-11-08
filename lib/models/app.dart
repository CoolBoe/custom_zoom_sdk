class AppModel {}

class PriceRangeModel {
  int? min;
  int? max;
  String? minWithSymbol;
  String? maxWithSymbol;

  PriceRangeModel({this.min, this.max, this.minWithSymbol, this.maxWithSymbol});

  PriceRangeModel.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
    minWithSymbol = json['min_with_symbol'];
    maxWithSymbol = json['max_with_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    data['min_with_symbol'] = this.minWithSymbol;
    data['max_with_symbol'] = this.maxWithSymbol;
    return data;
  }
}
