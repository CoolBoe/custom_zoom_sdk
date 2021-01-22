import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/order.dart';
import 'package:wooapp/widgets/loading.dart';

class WidgetLineItem extends StatefulWidget{

  LineItems lineItems;
  WidgetLineItem({this.lineItems});
  @override
  WidgetLineItemState createState()=>WidgetLineItemState();

}
class WidgetLineItemState extends State<WidgetLineItem>{

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widgetBuilder();
  }
  Widget widgetBuilder() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(color: pink_10,
                border: Border.all(
                    color: grey_400, width: 1.0),
                borderRadius:
                BorderRadius.all(Radius.circular(dp10))
            ),
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 90,
                    child: Image.network(widget.lineItems !=null?
                    widget.lineItems.img_src : ""),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text(
                              widget.lineItems !=null ? widget.lineItems.name : "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            )),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text(
                          widget.lineItems.sku.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins'),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "₹ ${widget.lineItems.total.toString()}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,color: black, size: 15)
                ],
              ),
            ),
          ),
        )
    );
  }
}