import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/models/product.dart';

class ProductWidget extends StatelessWidget {
  ProductModel productModel;

  ProductWidget({Key key, this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rating = double.parse(productModel.ratingCount.toString());
    return Container(
      height: 200,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(productModel.images[0].src),
                        fit: BoxFit.fill)),
                // child: Image.network(itemList[index].item_image, fit: BoxFit.fill)
              ),
              new Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/icons/ic_heart.svg',
                    color: red,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              productModel.name,
              style: TextStyle(
                color: black,
                fontFamily: 'Poppins',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            productModel.price,
            style: TextStyle(
              color: black,
              fontFamily: 'Poppins',
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RatingBar(
                  itemSize: 20,
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0),
                  ratingWidget: RatingWidget(
                      full: new Icon(
                        Icons.star,
                        color: amber,
                      ),
                      half: new Icon(
                        Icons.star_half,
                        color: amber,
                      ),
                      empty: new Icon(
                        Icons.star_border,
                        color: amber,
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
          )
        ],
      ),
    );
  }
}
