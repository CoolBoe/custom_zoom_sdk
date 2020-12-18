import 'package:flutter/cupertino.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/services/product.dart';
import 'package:wooapp/widgets/loading.dart';

class ProductsProvider with ChangeNotifier{
  String sort = 'default';
  String page = '1';
  String per_page = '10';
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByIdsList = [];
  ProductModel productsById;
  List<ProductModel> productsByPrice = [];
  List<ProductModel> productsByBrand = [];
  List<ProductModel> productsByFeatured = [];
  List<ProductModel> productsByOnSale = [];
  List<ProductModel> productsBySearch = [];
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
  Future loadProductsByBrand({String sort, String page, String per_page, String brand }) async{
    productsByBrand = await _productServices.getProductByBrand(sort: sort, page: page, per_page: per_page, brand: brand);
    notifyListeners();
  }
  Future loadProductsByFeatured({String sort, String page, String per_page, String featured }) async{
    productsByFeatured = await _productServices.getProductByFeatured(sort: sort, page: page, per_page: per_page, featured: featured);
    notifyListeners();
  }
  Future loadProductsByOnSale({String sort, String page, String per_page, String on_sale }) async{
    productsByOnSale = await _productServices.getProductByOnSale(sort: sort, page: page, per_page: per_page, on_sale: on_sale);
    notifyListeners();
  }
  Future loadProductsBySearch({String sort, String page, String per_page, String search }) async{
    productsBySearch = await _productServices.getProductBySearch(sort: sort, page: page, per_page: per_page, search: search);
    notifyListeners();
  }
  Future loadProductsBySorting({String sort, String page, String per_page}) async{
    productsByCategory = await _productServices.getProductBySearch(sort: sort, page: page, per_page: per_page);
    notifyListeners();
  }
  Future loadProductsById({String id}) async{
    productsById = await _productServices.getProductById(product_Id: id );
    productsByIdsList.add(productsById);
    notifyListeners();
  }
}