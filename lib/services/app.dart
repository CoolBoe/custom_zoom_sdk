import 'dart:convert';

import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/widgets/loading.dart';

class AppServices {
  // Future getPriceRange({String sort, String page, String per_page}) =>
  //     WebApiServices().getPriceRange().then((data) {
  //       if (data.statusCode == HTTP_CODE_200) {
  //         printLog("API getPriceRange200 =>", data.body.toString());
  //         if (data.body.isNotEmpty) {
  //           Map<String, dynamic> result = json.decode(data.body);
  //           return result;
  //         }
  //       } else {
  //         printLog("API getPriceRange Errorr Massage", data.body);
  //         toast(NETWORK_ERROR);
  //       }
  //     });
}
