import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/widgets/product.dart';
import 'package:wooapp/widgets/progress_bar.dart';

Widget featuredListBuilder(BuildContext context, List<ProductModel> items) {
  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height / 1.32 - kToolbarHeight - 34) / 2;
  final double itemWidth = size.width / 2;
  return SliverPadding(
    padding: EdgeInsets.all(8),
    sliver: SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: (itemWidth / itemHeight),
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return ProductWidget(
          productModel: items[index],
        );
      }, childCount: items.length),
    ),
  );
}
