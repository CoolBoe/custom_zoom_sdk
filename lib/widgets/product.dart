import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/widgets/loading.dart';

class ProductWidget extends StatelessWidget {
  ProductModel productModel;
  double width;

  ProductWidget({Key key, this.productModel, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rating = double.parse(productModel.ratingCount.toString());
    return Container(
      height: 200,
      decoration: BoxDecoration(
          border: Border.all(
            width: 0.15,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 180,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight: Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(productModel.images[0].src),
                        fit: BoxFit.fill)),
                // child: Image.network(itemList[index].item_image, fit: BoxFit.fill)
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(visible:productModel.calculateDiscount()!=null && productModel.calculateDiscount()>0,
                child: new Align(
                  alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.all(dp5),
                      decoration: BoxDecoration(
                        color: pink_50,
                        borderRadius: BorderRadius.circular(dp50),
                      ),
                      child: Text(
                        '${productModel.calculateDiscount()}% OFF',
                        style: TextStyle(
                          color: white,
                          fontFamily: 'Poppins',
                          fontSize: 8.0,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                ),),
              ),
            ],
          ),
          Container(
            width: width,
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Text(
              productModel.name,
              maxLines: 2,
              style: TextStyle(
                color: black,
                fontFamily: 'Poppins',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Row(
              children: [
                Visibility(visible: productModel.regularPrice != productModel.price && productModel.regularPrice!="",
                    child: Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: Text(
                  "₹ "+productModel.regularPrice,
                  style: TextStyle(
                      color: accent_color,
                      fontFamily: 'Poppins',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600, decoration: TextDecoration.lineThrough,decorationThickness: 2.85
                  ),
                ),
                    )),
                Text(
                  "₹ "+productModel.price,
                  style: TextStyle(
                    color: black,
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RatingBar(
                    itemSize: 20,
                    initialRating: rating,
                    minRating: 1,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0),
                    ratingWidget: RatingWidget(
                        full: new Icon(
                          Icons.star,
                          color: accent_color_50,
                        ),
                        half: new Icon(
                          Icons.star_half,
                          color: accent_color_50,
                        ),
                        empty: new Icon(
                          Icons.star_border,
                          color: accent_color_50,
                        )),
                    onRatingUpdate: (rating) {
                      print(rating);
                    }),
                Text(
                  " {" + productModel.ratingCount.toString() + "}",
                  style: TextStyle(
                    color: black,
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
