import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:wooapp/models/cart.dart';

Widget widgetShippingCart({List<ShippingMethod> shippingMethod, String choosenMethod}){
  int value = 0;
  String chosen_shipping_method= choosenMethod;
  return ListView.builder(
      itemCount: shippingMethod.length,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {

        return Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 70,
                child: Text(shippingMethod[index].shippingMethodName,
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
                          parse(shippingMethod[index].shippingMethodPrice)
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
                          // printLog("onChanged", val);
                          // setState(() {
                          //   value = val;
                          // });
                          // printLog("onSetChanged", val);
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
