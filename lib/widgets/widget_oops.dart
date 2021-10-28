import 'package:flutter/cupertino.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/utils/widget_helper.dart';

Widget popupBuilder(String image, String title) {
  return Container(
    child: Column(
      children: [
        Text(title, style: styleProvider(fontWeight: semiBold, size: 14),)
      ],
    ),
  );
}