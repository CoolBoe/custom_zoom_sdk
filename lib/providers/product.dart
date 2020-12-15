import 'package:flutter/cupertino.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/services/product.dart';
import 'package:wooapp/widgets/loading.dart';

class ProductsProvider with ChangeNotifier{

  String sort = 'default';
  String page = '1';
  String per_page = '10';
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  ProductServices _productServices = ProductServices();

  ProductsProvider.initialize(){
    loadProducts(sort: sort, page: page, per_page: per_page);
  }

 Future loadProducts({String sort, String page, String per_page }) async{

    products = await _productServices.getProducts(sort: sort, page: page, per_page: per_page);
    notifyListeners();
  }
  Future loadProductsByCategory({String sort, String page, String per_pag, String category }) async{
    productsByCategory = await _productServices.getProductsByCategory();
    notifyListeners();
  }
}