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
}