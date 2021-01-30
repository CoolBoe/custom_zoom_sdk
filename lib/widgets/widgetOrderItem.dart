import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/order.dart';

class widgetOrderItem extends StatefulWidget{

  OrderModel orderItem;
  widgetOrderItem({this.orderItem});
  @override
  widgetOrderItemState createState()=>widgetOrderItemState();

}
class widgetOrderItemState extends State<widgetOrderItem>{

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
                    child: Image.network(widget.orderItem.lineItems !=null && widget.orderItem.lineItems.length>0?
                    widget.orderItem.lineItems[0].img_src : ""),
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
                              widget.orderItem.lineItems !=null && widget.orderItem.lineItems.length>0 ? widget.orderItem.lineItems[0].name : "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            )),
                            Visibility(
                              visible: widget.orderItem.lineItems.length>1,
                              child: Text(
                                "one more Item",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins'),
                              ),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "₹ ${widget.orderItem.total.toString()}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins'),
                        ),
                        SizedBox(height: 5,),
                        Text(
                        widget.orderItem.orderStatus!=null ?  "Order Status:- ${widget.orderItem.orderStatus}" :  "Order Status:- Pending",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins'),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.orderItem.billing.firstName!=null ?  "Order By:- ${widget.orderItem.billing.firstName}" :  "",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
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