import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/models/WebResponseModel.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/utils/custom_stepper.dart';
import 'package:wooapp/widgets/loading.dart';

class WidgetCartItem extends StatefulWidget{
  CartDatum cartItem;
  @override
  _WidgetCartItemState createState()=>_WidgetCartItemState();

  WidgetCartItem({this.cartItem});
}
class _WidgetCartItemState extends State<WidgetCartItem>{

  LoaderProvider loader;
  WebResponseModel webResponseModel;
  CartProvider cart;
  @override
  void initState() {
    loader = Provider.of<LoaderProvider>(context, listen: false);
    cart = Provider.of<CartProvider>(context, listen: false);
    webResponseModel = new WebResponseModel();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  _buildproductList(widget.cartItem);
  }
  Widget _buildproductList(CartDatum cartItem) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(color: grey_50),
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 0),
                    child: Image.network(cartItem.image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    width: 180,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 8, right: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(child: Text(
                                cartItem.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins'),
                              )),
                              GestureDetector(onTap: (){
                                printLog("onClick", "");
                                loader.setLoadingStatus(true);

                                cart.getRemoveToCart(cartItemKey: cartItem.cartItemKey, onCallBack: (value){
                                  loader.setLoadingStatus(false);
                                });
                              },
                              child:  CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.red[200],
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 8, right: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                parse(cartItem.price)
                                    .documentElement
                                    .text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                        ),
                        CustomStepper(stepValue: 1, iconSize: 14, value: int.parse(widget.cartItem.quantity), onchanged: (value){
                          var loader = Provider.of<LoaderProvider>(context, listen: false);
                          loader.setLoadingStatus(true);
                          cart.getUpdateToCart(cartItem.cartItemKey, value, (val){
                            loader.setLoadingStatus(false);
                          });
                        }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}