import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/coupons.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/cart.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/ProgressHUD.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/item_coupon_trending.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class OfferScreen extends StatefulWidget{
  List<Coupon> list;
  OfferScreen({Key key, this.list}) : super(key: key);
  @override
  OfferScreenState createState() => OfferScreenState();
}
class OfferScreenState extends State<OfferScreen>{
  int checkedIndex ;
  bool checked = false;
  String cartItemKey ;
  bool inApiProcess = false;
  @override
  void initState() {
    var cart =Provider.of<CartProvider>(context, listen: false);
    cart.getOfferData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(inAsyncCall: inApiProcess, child: pageUi(), opacity: 0.3,);
  }
  Widget pageUi() {
    return Scaffold(
      appBar:BaseAppBar(context, "My Offers", suffixIcon: couponRemover()),
      body: pageBuilder(),
      bottomNavigationBar:customButton(title: "Apply Coupons", color: accent_color,onPressed: (){
        if(cartItemKey!=null){
          setState(() {
            inApiProcess = true;
          });
          printLog("cartItemKey", cartItemKey);
          var cart  = Provider.of<CartProvider>(context, listen: false);
          cart.getApplyCoupons(coupon_code: cartItemKey, onCallBack: (value){
            setState(() {
              toast("Coupon Applied");
              inApiProcess = false;
            });
            changeScreen(context, CartScreen());
          });
        }else{
          toast("please select your coupons");
        }
      }),
    ) ;
  }
  Widget _myOffers(){
    return new Consumer<CartProvider>(builder: (context, couponsModel, child){
      if(couponsModel.getCoupons!=null){
        return listBuilder(couponsModel.getCoupons);
      }else if (couponsModel.loader){
        return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 500,child: ShimmerList(listType: "Order",));
      }else{
        return Container(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: somethingWentWrong());
      }
    });
  }
  Widget pageBuilder() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: dp30, left: dp30, right: dp30, bottom: dp10),
              child:Container(
                height: 40,
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(
                        color: grey_200, width: 1.0),
                    borderRadius:
                    BorderRadius.all(Radius.circular(dp10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        ic_search,
                        color: grey_400,
                      ),
                      SizedBox(width: 10),
                      Expanded(child:Padding(
                        padding: const EdgeInsets.only(top:5.0),
                        child: TextFormField(
                            cursorColor: accent_color,
                            decoration: InputDecoration(
                            hintText: "Search For Offers",
                            hintStyle:styleProvider(fontWeight: regular, size: dp15, color: grey_400) ,
                            border: InputBorder.none),
                            textAlignVertical: TextAlignVertical.bottom,
                            style: styleProvider(fontWeight: regular, size: dp15, color: black),
                        ),
                      ))
                    ],
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left:13.0),
            child: Text("Trending", style: styleProvider(fontWeight: semiBold, size: 14, color: black),),
          ),
          _myOffers()
        ],
      ),
    );
  }
  Widget listBuilder(List<Coupons> coupons){
     return Container(
       padding: EdgeInsets.only(left: 10, right: 10, top: 10),
         child: GridView.builder(
                 shrinkWrap: true,
                  itemCount: coupons.length,
                 padding: EdgeInsets.zero,
                 physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                  checked = index == checkedIndex;
               return GestureDetector(
                 onTap: (){
                   setState(() {
                     printLog("cartItemKey", cartItemKey);
                     checkedIndex = index;
                     cartItemKey = coupons[index].code;
                   });
                 },
                 child: Stack(
                   children: [
                     Container(
                       width: 200,
                       decoration: BoxDecoration(
                           color:checked ? pink_50 : pink_10,
                           border: Border.all(
                               color: grey_200, width: 1.0),
                           borderRadius:
                           BorderRadius.all(Radius.circular(dp10))),
                       child: Padding(
                         padding: const EdgeInsets.all(30.0),
                         child: Column(
                           children: [
                             RichText(
                               text: TextSpan(
                                   text:"₹ "+coupons[index].amount+" Off ",
                                   style: TextStyle(
                                       color: accent_color,
                                       fontSize: dp20,
                                       fontFamily: fontName,
                                       fontWeight: bold),
                                   children: <TextSpan>[
                                     TextSpan(text: '\n Check the best deals for today',
                                       style: TextStyle(
                                         color: accent_color,
                                         fontSize: dp15,
                                         fontWeight:regular,
                                       ),
                                     ),
                                   ]
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                     Positioned(
                       top: 12,
                       right: 12,
                       child: Offstage(
                         offstage: !checked,
                         child: Container(
                           decoration: BoxDecoration(
                               color: white,
                               border: Border.all(width: 2),
                               shape: BoxShape.circle),
                           child: Icon(
                             Icons.check,
                             color: Colors.green,
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               );
           },
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 2,
             crossAxisSpacing: 10,
             mainAxisSpacing: 10
           ),
     ));
  }

  Widget couponRemover() {
    return GestureDetector(onTap: (){
      if(widget.list!=null && widget.list.length>0){
        setState(() {
          inApiProcess = true;
        });
        var loader = Provider.of<LoaderProvider>(context, listen: false);
        loader.setLoadingStatus(true);
        var cart = Provider.of<CartProvider>(context, listen: false);
        cart.getRemoveCoupons(coupon_code: widget.list[0].code, onCallBack: (value){
          setState(() {
            inApiProcess = false;
            widget.list.removeAt(0);
          });
          loader.setLoadingStatus(false);
          toast("Coupon Removed");
        });
      }
    },
    child: Stack(
      children: <Widget>[
        new Align(
          child: Icon(Icons.delete_sharp, color: Colors.red[300], size: 30,),
        ),
        cartItem()
      ],
    ),);
  }
  Widget cartItem() {
    return new Consumer<CartProvider>(builder:(context, cartModel, child){
      if(widget.list!=null && widget.list.length>0){
        return new Positioned(
            right: 0,
            child: Padding(
                padding: const EdgeInsets.all(0.0),
                child:  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      color: green_400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(widget.list.length.toString(), style: styleProvider(fontWeight: medium, size: 8, color: white),))
            ));
      }else{
        return Container();
      }
    });
  }


}