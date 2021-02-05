import 'package:flutter/cupertino.dart';
import 'package:wooapp/models/filter.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/models/sort_by.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/rest/WebApiServices.dart';

enum LoadMoreStatus{INITIAL, LOADING, STABLE}
enum ProductBy {DEFAULT, CATEGORY, FEATURED, SELLER, SALE, RATED }
class ProductsProvider with ChangeNotifier {
  String sort = 'default';
  String page = '1';
  String per_page = '10';
  WebApiServices _webApiServices;
  List<ProductModel> _productList ;
  List<ProductModel> get allProducts => _productList;
  List<ProductModel> _productListByRelated;
  List<ProductModel> get allproductListByRelated =>_productListByRelated;
  SortBy _sortBy;
  bool loader= false;


  List<ProductModel> _productListByFeatured ;
  List<ProductModel> get allProductsByFeature => _productListByFeatured;
  List<ProductModel> _productListBySale ;
  List<ProductModel> get allProductsBySale => _productListBySale;

  ProductsProvider.initialize(){
    _productList = List<ProductModel>();
    _webApiServices= WebApiServices();
    _sortBy = SortBy("default", "Default", "asc");
    fetchProducts(1);

  }
  void resetStreams() {
    _webApiServices = WebApiServices();
    _productList = List<ProductModel>();
  }
  setLoadingState(LoadMoreStatus loadMoreStatus){
    // _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }
  setLoadingStateByFeature(LoadMoreStatus loadMoreStatus){
    // _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }
  setSortOrder(SortBy sortBy){
    _sortBy = sortBy;
    notifyListeners();
  }
  fetchProducts(pageNumber, {String sortBy, String str_search, String brand, String max_price, String min_price,
    bool on_sale, bool featured, String category_id, String colorList, String sizelist }) async{
    loader= true;
    printLog("fetchProducts", str_search);
    List<ProductModel> itemModel = await _webApiServices.getProducts(sort: this._sortBy.value, category_id: category_id, page: this.page, per_page: this.per_page, str_search: str_search, brand: brand,
        featured: featured, on_sale: on_sale, max_price: max_price, min_price: min_price, sizeList: sizelist, colorList: colorList,);
    if(itemModel.length>0){
      _productList.addAll(itemModel);
    }
    loader= false;
    notifyListeners();
  }

  fetchProductByRelated({String id, List<int> productIDs }) async{
    loader = true;
    List<ProductModel> itemModel = await _webApiServices.getProductByRelatedIds(
     productIDs: productIDs
    );
    loader = false;
    _productListByRelated = [];
    printLog("fetchProductByRelated", itemModel);
    // setLoadingStateByFeature(LoadMoreStatus.STABLE);
    notifyListeners();
    if(itemModel.length>0){
      _productListByRelated.addAll(itemModel);
    }
  }

  fetchProductByPageId({String page_id})async{
    var data = _webApiServices.getAppPageById(page_id: page_id);
    notifyListeners();
  }

  fetchProductByFeatured(pageNumber, {String sortBy, bool featured,}) async{
    List<ProductModel> itemModel = await _webApiServices.getProducts(
      sort: this._sortBy.value,
      page: this.page,
      per_page: this.per_page,
    );
    _productListByFeatured=[];
    notifyListeners();
    if(itemModel.length>0){
      _productListByFeatured.addAll(itemModel);
    }
  }

  fetchProductBySale(pageNumber, {String sortBy, bool sale,}) async{
    List<ProductModel> itemModel = await _webApiServices.getProducts(
      sort: this._sortBy.value,
      page: this.page,
      per_page: this.per_page,
      on_sale: sale,
    );
    _productListBySale=[];
    notifyListeners();
    if(itemModel.length>0){
      _productListBySale.addAll(itemModel);
    }
  }


}
