import 'package:flutter/cupertino.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/models/sort_by.dart';
import 'package:wooapp/rest/WebApiServices.dart';

enum LoadMoreStatus{INITIAL, LOADING, STABLE}
enum ProductBy {DEFAULT, CATEGORY, FEATURED, SELLER, SALE, RATED }
class ProductsProvider with ChangeNotifier {
  late String sort;
  late int page ;
  late String perPage;
  late WebApiServices _webApiServices;
  late List<ProductModel> _productList ;
  List<ProductModel> get allProducts => _productList;
  late List<ProductModel> _productListByRelated;
  List<ProductModel> get allProductListByRelated =>_productListByRelated;
  late SortBy _sortBy;
  late bool loader;
  late LoadMoreStatus _loadMoreStatus;
  LoadMoreStatus get getLoadMoreStatus => _loadMoreStatus;
  late List<ProductModel> _productListByFeatured ;
  List<ProductModel> get allProductsByFeature => _productListByFeatured;
  late List<ProductModel> _productListBySale ;
  List<ProductModel> get allProductsBySale => _productListBySale;

  ProductsProvider.initialize(){
    sort = 'default';
    page = 1;
    perPage = '10';
    loader= false;
    _webApiServices= WebApiServices();
    _sortBy = SortBy("default", "Default", "asc");

  }
  void resetStreams() {
    _webApiServices = WebApiServices();
  }
  setLoadingStatus(LoadMoreStatus loadMoreStatus){
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  setSortOrder(SortBy sortBy){
    _sortBy = sortBy;
    notifyListeners();
  }
  fetchProducts(pageNumber, {required String sortBy,required String strSearch, required String brand,
    required String maxPrice, required String minPrice, required bool onSale, required bool featured,
    required String categoryId, required String colorList, required String sizeList }) async{
    loader= true;
    setLoadingStatus(LoadMoreStatus.LOADING);
    List<ProductModel> itemModel = await _webApiServices.getProducts(sort: this._sortBy.value,
      category_id: categoryId, page: pageNumber, per_page: this.perPage, str_search: strSearch,
      brand: brand, featured: featured, on_sale: onSale, max_price: maxPrice, min_price: minPrice,
      sizeList: sizeList, colorList: colorList,);
    if(itemModel.length>0){
      _productList.addAll(itemModel);
    }
    loader= false;
    setLoadingStatus(LoadMoreStatus.STABLE);
    notifyListeners();
  }

  fetchProductByRelated({required String id, required List<int> productIds }) async{
    loader = true;
    List<ProductModel> itemModel = await _webApiServices.getProductByRelatedIds(
     productIDs: productIds
    );
    loader = false;
    _productListByRelated = [];
    notifyListeners();
    if(itemModel.length>0){
      _productListByRelated.addAll(itemModel);
    }
  }

  fetchProductByPageId({required String pageId})async{
    _webApiServices.getAppPageById(page_id: pageId);
    notifyListeners();
  }

  fetchProductByFeatured(pageNumber, {required String sortBy, required bool featured,}) async{
    List<ProductModel> itemModel = await _webApiServices.getProducts(
      sort: this._sortBy.value,
      page: this.page,
      per_page: this.perPage,
    );
    _productListByFeatured=[];
    notifyListeners();
    if(itemModel.length>0){
      _productListByFeatured.addAll(itemModel);
    }
  }

  fetchProductBySale(pageNumber, {required String sortBy, required bool sale}) async{
    List<ProductModel> itemModel = await _webApiServices.getProducts(
      sort: this._sortBy.value,
      page: this.page,
      per_page: this.perPage,
      on_sale: sale,
    );
    _productListBySale=[];
    notifyListeners();
    if(itemModel.length>0){
      _productListBySale.addAll(itemModel);
    }
  }


}
