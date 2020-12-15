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
  List<ProductModel> productsByPrice = [];
  List<ProductModel> productsByAttribute = [];
  ProductServices _productServices = ProductServices();

  ProductsProvider.initialize(){
    loadProducts(sort: sort, page: page, per_page: per_page);
  }

 Future loadProducts({String sort, String page, String per_page }) async{
    products = await _productServices.getProducts(sort: sort, page: page, per_page: per_page);
    notifyListeners();
  }
  Future loadProductsByCategory({String sort, String page, String per_page, String category }) async{
    productsByCategory=null;
    productsByCategory = await _productServices.getProductsByCategory(sort: sort, page: page, per_page: per_page, category: category);
    printLog("productsByCategory.length", productsByCategory.length);
    notifyListeners();
  }
  Future loadProductsByPrice({String sort, String page, String per_page, String min_price , String max_price}) async{
    productsByPrice=null;
    productsByPrice = await _productServices.getProductsByPrice(sort:sort, page:page, per_page:per_page, min_price: min_price, max_price: max_price);
    notifyListeners();
  }
  Future loadProductsByAttribute({String sort, String page, String per_pag, String category }) async{
    productsByAttribute = await _productServices.getProductsByCategory();
    notifyListeners();
  }
}