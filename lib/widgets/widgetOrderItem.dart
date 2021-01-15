import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/widgets/loading.dart';

class OrderItem extends StatefulWidget{

  @override
  OrderItemState createState()=>OrderItemState();

}
class OrderItemState extends State<OrderItem>{

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  widgetBuilder();
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 90,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_7_front-600x600.jpg"),
                            fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Expanded(child: Text(
                              "Women Pink Top",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                                )),
                          ),
                          SizedBox(
                            child: Expanded(child:  Text(
                              "₹ 920.00",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            )),
                          ),
                          SizedBox(
                            child: Expanded(child:  Text(
                              "Delivered on Dec 10",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins'),
                            )),
                          ),
                        ],
                      ),
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