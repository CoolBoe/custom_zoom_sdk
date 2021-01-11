import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/coupons.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/cart.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/item_coupon_trending.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class OfferScreen extends BasePage{
  OfferScreen({Key key}) : super(key: key);
  @override
  OfferScreenState createState() => OfferScreenState();
}
class OfferScreenState extends BasePageState{
  int checkedIndex ;
  bool checked = false;
  String cartItemKey ;
  @override
  void initState() {
    var cart =Provider.of<CartProvider>(context, listen: false);
    cart.getOfferData();
    super.initState();
  }
  @override
  Widget pageUi() {
    return Scaffold(
      appBar:BaseAppBar(context, "My Offers", suffixIcon: Container()),
      body: _myOffers(),
      bottomNavigationBar:customButton(title: "Apply Coupons", color: orange,onPressed: (){
                 if(cartItemKey!=null){
                   printLog("cartItemKey", cartItemKey);
                   var loader = Provider.of<LoaderProvider>(context, listen: false);
                   loader.setLoadingStatus(true);
                   var cart  = Provider.of<CartProvider>(context, listen: false);
                   cart.getApplyCoupons(coupon_code: cartItemKey, onCallBack: (value){
                     loader.setLoadingStatus(false);
                     toast("Coupon Applied Successfully");
                     changeScreen(context, CartScreen());
                   });
                 }else{
                   toast("please select your coupons");
                 }
      }),
    );
  }
  Widget _myOffers(){
    return new Consumer<CartProvider>(builder: (context, couponsModel, child){
      if(couponsModel.getCoupons!=null){
        return _myOffersBuilder(couponsModel.getCoupons);
      }else{
        return progressBar(context, orange);
      }
    });
  }
  Widget _myOffersBuilder(List<Coupons> coupons) {
    return Container(
      color: white,
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
                            cursorColor: orange,
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
          Column(),
          Padding(
            padding: const EdgeInsets.only(left:13.0),
            child: Text("Trending", style: styleProvider(fontWeight: semiBold, size: 14, color: black),),
          ),
          listBuilder(coupons)
        ],
      ),
    );
  }
  Widget listBuilder(List<Coupons> coupons){
     var size = MediaQuery.of(context).size;
     final double itemHeight = (size.height / 1.32 - kToolbarHeight - 80) / 3;
     final double itemWidth = size.width / 2;
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
                                       color: orange,
                                       fontSize: dp20,
                                       fontFamily: fontName,
                                       fontWeight: bold),
                                   children: <TextSpan>[
                                     TextSpan(text: '\n Check the best deals for today',
                                       style: TextStyle(
                                         color: orange_300,
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
}