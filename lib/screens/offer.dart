import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/coupons.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/screens/basePage.dart';
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
          Container(
            height: 160,
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: coupons.length,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                      onTap: () {
                        printLog("coupons", coupons[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Item_Coupon_Trending(
                          coupon: coupons[index],
                        ),
                      ));
                }
            ),
          ),
        ],
      ),
    );
  }
}