// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'WebApiServices.dart';
//
// // **************************************************************************
// // ChopperGenerator
// // **************************************************************************
//
// // ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
// class _$WebApiServices extends WebApiServices {
//   _$WebApiServices([ChopperClient client]) {
//     if (client == null) return;
//     this.client = client;
//   }
//
//   @override
//   final definitionType = WebApiServices;
//
//   @override
//   Future<Response<dynamic>> userLogin(Map<String, dynamic> body) {
//     final $url = '/wp-json/wc/v2/login';
//     final $body = body;
//     final $request = Request('POST', $url, client.baseUrl, body: $body);
//     return client.send<dynamic, dynamic>($request);
//   }
//
//   @override
//   Future<Response<dynamic>> userLogout(
//       Future<Response<dynamic>> Function(int) getPost) {
//     final $url = '/wp-json/wc/v2/logout';
//     final $request = Request('GET', $url, client.baseUrl);
//     return client.send<dynamic, dynamic>($request);
//   }
//
//   @override
//   Future<Response<dynamic>> userRegister(Map<String, dynamic> body) {
//     final $url = '/wp-json/wc/v2/register';
//     final $body = body;
//     final $request = Request('POST', $url, client.baseUrl, body: $body);
//     return client.send<dynamic, dynamic>($request);
//   }
//
//   @override
//   Future<Response<dynamic>> forgotPassword(int user_id) {
//     final $url = '/wp-json/wc/v2/forget-password';
//     final $request = Request('POST', $url, client.baseUrl);
//     return client.send<dynamic, dynamic>($request);
//   }
//
//   @override
//   Future<Response<dynamic>> changePassword(int user_id) {
//     final $url = '/wp-json/wc/v2/change-password';
//     final $request = Request('POST', $url, client.baseUrl);
//     return client.send<dynamic, dynamic>($request);
//   }
// }
