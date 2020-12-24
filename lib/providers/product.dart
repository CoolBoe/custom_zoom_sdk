import 'package:flutter/cupertino.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:wooapp/services/product.dart';
import 'package:wooapp/widgets/loading.dart';
import 'dart:convert';
import 'package:wooapp/rest/WebApiServices.dart';

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
   loadProducts(sort: WebRequestConstants.SORT_BY_DEFAULT, per_page: "10", page: "1");
  }

  Future<List<ProductModel>>loadProducts({String sort, String page, String per_page}) => WebApiServices().getProducts(sort,page, per_page ).then((data){
    if(data.statusCode==HTTP_CODE_200){
      printLog("API getProduct200 =>", data.body.toString());
      List<dynamic> values = new List<dynamic>();
      if(data.body.isNotEmpty){
        values =json.decode(data.body);
        if(values.length>0){
          products.clear();
          for(int i=0; i<values.length; i++ ){
            if(values[i]!=null){
              Map<String,dynamic> map = values[i];
              products.add(ProductModel.fromJson(map));
            }
          }
        }
      }
    }else{
      printLog("API getProduct Errorr Massage", data.body);
      toast(NETWORK_ERROR);
    }
    return products;
  });

 Future<List<ProductModel>>loadProductsByCategory({String sort, String page, String per_page, String category}) => WebApiServices().getProductByCategory(sort,page, per_page, category ).then((data){
    if(data.statusCode==HTTP_CODE_200){
      productsByCategory=null;
      printLog("API getProductByCategory200 =>", data.body.toString());
      List<dynamic> values = new List<dynamic>();
      if(data.body.isNotEmpty){
        products.clear();
        values =json.decode(data.body);
        if(values.length>0){
          for(int i=0; i<values.length; i++ ){
            if(values[i]!=null){
              Map<String,dynamic> map = values[i];
              products.add(ProductModel.fromJson(map));
            }
          }
        }
      }
    }else{
      printLog("API getProduct Errorr Massage", data.body);
      toast(NETWORK_ERROR);
    }
    notifyListeners();
    return products;
  });

  Future<List<ProductModel>>loadProductsByPrice({String sort, String page, String per_page, String min_price, String max_price}) => WebApiServices().getProductByPrice(sort,page, per_page, min_price, max_price ).then((data){
    if(data.statusCode==HTTP_CODE_200){
      productsByPrice=null;
      printLog("API getProductByPrice200 =>", data.body.toString());
      List<dynamic> values = new List<dynamic>();
      if(data.body.isNotEmpty){
        products.clear();
        values =json.decode(data.body);
        if(values.length>0){
          for(int i=0; i<values.length; i++ ){
            if(values[i]!=null){
              Map<String,dynamic> map = values[i];
              products.add(ProductModel.fromJson(map));
            }
          }
        }
      }
    }else{
      printLog("API getProduct Errorr Massage", data.body);
      toast(NETWORK_ERROR);
    }
    notifyListeners();
    return products;
  });

  Future<List<ProductModel>>loadProductsByBrand({String sort, String page, String per_page, String brand}) => WebApiServices().getProductByBrand(sort,page, per_page, brand ).then((data){
    if(data.statusCode==HTTP_CODE_200){
      printLog("API getProductByBrand200 =>", data.body.toString());
      List<dynamic> values = new List<dynamic>();
      if(data.body.isNotEmpty){
        products.clear();
        values =json.decode(data.body);
        if(values.length>0){
          for(int i=0; i<values.length; i++ ){
            if(values[i]!=null){
              Map<String,dynamic> map = values[i];
              products.add(ProductModel.fromJson(map));
            }
          }
        }
      }
    }else{
      printLog("API getProduct Errorr Massage", data.body);
      toast(NETWORK_ERROR);
    }
    notifyListeners();
    return products;
  });

  Future<List<ProductModel>>loadProductsByFeatured({String sort, String page, String per_page, String featured}) =>
      WebApiServices().getProductByFeatured(sort,page, per_page, featured ).then((data){
        if(data.statusCode==HTTP_CODE_200){
          printLog("API getProductByFeatured200 =>", data.body.toString());
          List<dynamic> values = new List<dynamic>();
          if(data.body.isNotEmpty){
            products.clear();
            values =json.decode(data.body);
            if(values.length>0){
              for(int i=0; i<values.length; i++ ){
                if(values[i]!=null){
                  Map<String,dynamic> map = values[i];
                  products.add(ProductModel.fromJson(map));
                }
              }
            }
          }
        }else{
          printLog("API getProductByFeatured Errorr Massage", data.body);
          toast(NETWORK_ERROR);
        }
        notifyListeners();
        return products;
      });

  Future<List<ProductModel>>loadProductsByOnSale({String sort, String page, String per_page, String on_sale}) =>
      WebApiServices().getProductByOnSale(sort,page, per_page, on_sale ).then((data){
        if(data.statusCode==HTTP_CODE_200){
          printLog("API getProductByOnSale200 =>", data.body.toString());
          List<dynamic> values = new List<dynamic>();
          if(data.body.isNotEmpty){
            products.clear();
            values =json.decode(data.body);
            if(values.length>0){
              for(int i=0; i<values.length; i++ ){
                if(values[i]!=null){
                  Map<String,dynamic> map = values[i];
                  products.add(ProductModel.fromJson(map));
                }
              }
            }
          }
        }else{
          printLog("API getProductByOnSale Errorr Massage", data.body);
          toast(NETWORK_ERROR);
        }
        notifyListeners();
        return products;
      });

  Future<List<ProductModel>>getProductBySearch({String sort, String page, String per_page, String search}) =>
      WebApiServices().getProductBySearch(sort,page, per_page, search ).then((data){
        if(data.statusCode==HTTP_CODE_200){
          printLog("API getProductBySearch200 =>", data.body.toString());
          List<dynamic> values = new List<dynamic>();
          if(data.body.isNotEmpty){
            products.clear();
            values =json.decode(data.body);
            if(values.length>0){
              for(int i=0; i<values.length; i++ ){
                if(values[i]!=null){
                  Map<String,dynamic> map = values[i];
                  products.add(ProductModel.fromJson(map));
                }
              }
            }
          }
        }else{
          printLog("API getProductBySearch Errorr Massage", data.body);
          toast(NETWORK_ERROR);
        }
        notifyListeners();
        return products;
      });
  Future loadProductsBySorting({String sort, String page, String per_page}) async{
    productsByCategory = await _productServices.getProductBySearch(sort: sort, page: page, per_page: per_page);
    notifyListeners();
  }

  Future<ProductModel>loadProductsById({String product_Id}) =>
      WebApiServices().getProductById(product_Id ).then((data){
        if(data.statusCode==HTTP_CODE_200){
          printLog("API getProductById200 =>", data.body.toString());

          if(data.body.isNotEmpty){
            productsByIdsList.clear();
            productsById = ProductModel.fromJson(json.decode(data.body));
          }
        }else{
          printLog("API getProductById Errorr Massage", data.body);
          toast(NETWORK_ERROR);
        }
        return productsById;
      });

  Future<ProductModel>loadProductsByRelatedId({String product_Id}) =>
      WebApiServices().getProductById(product_Id ).then((data){
        if(data.statusCode==HTTP_CODE_200){
          printLog("API getProductById200 =>", data.body.toString());

          if(data.body.isNotEmpty){
            productsById = ProductModel.fromJson(json.decode(data.body));
            productsByIdsList.add(productsById);
          }
        }else{
          printLog("API getProductById Errorr Massage", data.body);
          toast(NETWORK_ERROR);
        }

        return productsById;
      });
}