import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/widgets/loading.dart';

List<ProductModel> productList(BuildContext context) {
  BasePrefs.init();
  final productProvider = Provider.of<ProductsProvider>(context, listen: false);

  List<ProductModel> list = [];
  var productBy = BasePrefs.getString(PRODUCT_BY);
  if (productBy != null) return list = productProvider.products;
  switch (productBy) {
    case "1":
      list = productProvider.productsByCategory;
      break;
    case "2":
      list = productProvider.productsByPrice;
      printLog("productsByPrice", list.toString());
      break;
    case "3":
      list = productProvider.productsByBrand;
      break;
    case "4":
      list = productProvider.productsByFeatured;
      break;
    case "5":
      list = productProvider.productsByOnSale;
      break;
    case "6":
      list = productProvider.productsBySearch;
      break;
    default:
      list = productProvider.products;
      break;
  }
  return list;
}
