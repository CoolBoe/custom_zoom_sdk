import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
typedef void RatingChangeCallback(double rating);
class StarRating extends StatelessWidget{
  final int startCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating({this.startCount =5, this.rating=.0, this.onRatingChanged, this.color});


  Widget buildStar(BuildContext context, int index){
    Icon icon;
    if(index>=rating){
      icon= new Icon(
          Icons.star_border,
          color: Theme.of(context).buttonColor);
    }else if(index>rating -1 && index<rating){
      icon = new Icon(
          Icons.star_half,
          color: Theme.of(context).buttonColor);
    }else{
      icon = new Icon(
        Icons.star,
        color: Theme.of(context).buttonColor,
      );
    }return new InkResponse(
      onTap: onRatingChanged== null?null:()=>onRatingChanged(index+1.0),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Row(children: new List.generate(startCount, (index) => buildStar(context, index)),);
  }
  
}