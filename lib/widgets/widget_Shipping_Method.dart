import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:wooapp/services/product.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/product.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class WidgetShippingMethod extends StatefulWidget{
  List<ShippingMethod> shippingMethod;
  WidgetShippingMethod({Key key, this.shippingMethod}) : super(key: key);
  @override
  _WidgetShippingMethodState createState()=>_WidgetShippingMethodState();
}
class _WidgetShippingMethodState extends State<WidgetShippingMethod> {

  @override
  Widget build(BuildContext context) {
    int value = 0;
    return  ListView.builder(
        itemCount: widget.shippingMethod.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70,
                  child: Text(widget.shippingMethod[index].shippingMethodName,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 10)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                            parse(widget.shippingMethod[index].shippingMethodPrice)
                                .documentElement
                                .text,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 10)),
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Radio(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          value: index,
                          activeColor: Colors.black,
                          groupValue: value,
                          onChanged: (val) {
                            printLog("onChanged", val);
                            setState(() {
                              value = val;
                            });
                            printLog("onSetChanged", val);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}