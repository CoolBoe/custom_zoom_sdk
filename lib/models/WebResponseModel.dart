class WebResponseModel{
  String code;
  String message;

  WebResponseModel({this.code, this.message});

  factory WebResponseModel.fromJson(Map<String, dynamic>jsonMap){
    return WebResponseModel(
        code: jsonMap['code'],
        message: jsonMap['message']
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.code;
    data['message'] = this.message;
    return data;
  }
}