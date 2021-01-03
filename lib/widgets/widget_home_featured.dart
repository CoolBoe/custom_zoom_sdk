// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:wooapp/helper/color.dart';
// import 'package:wooapp/models/product.dart';
// import 'package:wooapp/rest/WebRequestConstants.dart';
// import 'package:wooapp/services/product.dart';
// import 'package:wooapp/widgets/product.dart';
// import 'package:wooapp/widgets/progress_bar.dart';
//
// class WidgetFeatured extends StatefulWidget{
//   @override
//   _WidgetFeaturedState createState()=>_WidgetFeaturedState();
// }
// class _WidgetFeaturedState extends State<WidgetFeatured> with AutomaticKeepAliveClientMixin<WidgetFeatured>{
//
//   @override
//   void initState() {
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(left: 30, right: 30),
//           child:  Container(
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     GestureDetector(
//                         child: Text("Featured",
//                             style: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontSize: 12.0,
//                                 fontWeight: FontWeight.w600,
//                                 color: black))),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           "See More",
//                           style: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontSize: 10.0,
//                               fontWeight: FontWeight.w500,
//                               color: black),
//                         ),
//                         Icon(
//                           Icons.arrow_right_alt_rounded,
//                           color: black,
//                           size: 20,
//                         )
//                       ],
//                     )
//                   ]),
//           ),
//         ),
//         _featuredList()
//       ],
//     );
//   }
//   Widget _featuredList(){
//     return new FutureBuilder(
//         future: future,
//         builder: (BuildContext context,
//             AsyncSnapshot<List<ProductModel>> model){
//           if(model.hasData){
//             return _buildCategoryList(model.data);
//           }
//           return progressBar(context, orange);
//          }
//     );
// }
//   Widget _buildCategoryList(List<ProductModel> items) {
//     var size = MediaQuery.of(context).size;
//     final double itemHeight = (size.height / 1.32 - kToolbarHeight - 34) / 2;
//     final double itemWidth = size.width / 2;
//     return Padding(
//       padding: EdgeInsets.all(8),
//       child:GridView.builder(
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: 200.0,
//           mainAxisSpacing: 10.0,
//           crossAxisSpacing: 10.0,
//           childAspectRatio: (itemWidth / itemHeight),
//         ),
//         itemBuilder: (BuildContext context, int index){
//           return ProductWidget(
//             productModel: items[index],
//           );
//
//         },
//         itemCount: items.length,
//       )
//     );
//   }
//
//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }