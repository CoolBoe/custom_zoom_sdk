import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/product.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class WidgetRelatedProducts extends StatefulWidget{
  String labelName;
  List<int> products;
  @override
  _WidgetRelatedProductsState createState()=>_WidgetRelatedProductsState();

  WidgetRelatedProducts({this.labelName,this.products});
}
class _WidgetRelatedProductsState extends State<WidgetRelatedProducts>{
  int _page =1;
  @override
  void initState() {
    var productList = Provider.of<ProductsProvider>(context, listen: false);
    productList.fetchProductByRelated(productIDs: widget.products );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Related Product", style: TextStyle( color: Colors.black,
          fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 15),),
          Container(
              height: 300,
              child: _productByRelated())
        ],
      ),
    );
  }

  Widget _productByRelated(){
    return new Consumer<ProductsProvider>(builder: (context, productModel, child){
      if(productModel.allproductListByRelated!=null &&
          productModel.allproductListByRelated.length>0){
        printLog("hjghghjgh",productModel.allproductListByRelated);
        return _buildproductList(productModel.allproductListByRelated);
      }else{if(productModel.loader){
        return ShimmerList(listType: "List",);
      }else {
        return Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Container(),
        );
      } }
    });
  }

  Widget _buildproductList(List<ProductModel> productList) {
    return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
                onTap: () {
                  changeScreen(
                      context, ProductScreen(productModel: productList[index]));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productModel: productList[index],
                    width: 150,
                  ),
                ));
          }
      );

  }


}