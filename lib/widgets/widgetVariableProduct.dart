import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/widgets/loading.dart';

class VariableProduct extends StatefulWidget{

  List<Attribute> attributeList;
   ValueChanged<String> onchanged;
  VariableProduct({Key key, this.attributeList, @required this.onchanged}) : super(key: key);

  @override
  VariableProductState createState()=>VariableProductState();

}
class VariableProductState extends State<VariableProduct>{
  int colorIndex = 0;
  int sizeIndex = 0;
  int logoIndex = 0;
  var colorVarible;
  var logovariable;
  var sizevarible;
  dynamic get data=> "$sizevarible+$logovariable$sizevarible";
  @override
  void initState() {
   widget.onchanged= colorVarible;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index){
            return  Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: variableBuilder(widget.attributeList[index])
            );
          }, itemCount: widget.attributeList.length,)
    );
    }

    Widget variableBuilder(Attribute attribute){
    switch (attribute.name){
      case Name.COLOR:
        printLog("fyagygay", attribute.options);
        Iterable l = attribute.options;
        List<OptionClass> model = List<OptionClass>.from(l.map((model)=> OptionClass.fromJson(model)));
     return Row(
       mainAxisAlignment: MainAxisAlignment.start,
       children: <Widget>[
         Text("Color :",
             style: TextStyle(
                 fontFamily: 'Poppins',
                 fontSize: 12.0,
                 fontWeight: FontWeight.w500,
                 color: Colors.black)),
         Padding(
           padding: const EdgeInsets.only(left:10.0),
           child: Container(
             width: 200,
             height: 20,
             child:  ListView.builder(
               padding: EdgeInsets.zero,
               physics: ClampingScrollPhysics(),
               scrollDirection: Axis.horizontal,
               shrinkWrap: true,
               itemBuilder: (context, index) {
                 return Padding(
                   padding: const EdgeInsets.only(left:8.0, ),
                   child: GestureDetector(onTap: (){
                     setState(() {
                       colorIndex= index;
                      colorVarible = Product(taxonomy: "pa_color", slug: model[index].slug.toString());
                     });
                   },
                       child:  Container(
                         width: 50,
                         decoration: BoxDecoration(
                             color:  colorIndex==index ? Colors.orange : Colors.white,
                             borderRadius: BorderRadius.all(Radius.circular(5.0))
                         ),
                         child: Center(
                           child: Text(
                            model[index].name, style: TextStyle(color:  colorIndex==index ?  Colors.white: Colors.black, fontWeight: medium, fontSize: 12), textAlign: TextAlign.center,
                             overflow: TextOverflow.ellipsis,
                           ),
                         ),
                       )),
                 );
               },itemCount: attribute.options.length,
             ),
           ),
         )
       ],
     );
      break;
      case Name.LOGO:
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("Logo :",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Container(
              width: 200,
              height: 20,
              child:  ListView.builder(
                padding: EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(onTap: (){
                    setState(() {
                      logoIndex= index;
                      logovariable=  Product(taxonomy: "pa_logo", slug: attribute.options[index]);

                    });
                  },
                      child:  Container(
                        width: 50,
                        decoration: BoxDecoration(
                            color:  logoIndex==index ? Colors.orange : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                        ),
                        child: Center(
                          child: Text(
                            attribute.options[index], style: TextStyle(color:  logoIndex==index ?  Colors.white: Colors.black, fontWeight: medium, fontSize: 12), textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ));
                },itemCount: attribute.options.length,
              ),
            ),
          )
        ],
      );
        break;
      case Name.SIZE:
        printLog("fyagygay", attribute.options);
        Iterable l = attribute.options;
        List<OptionClass> model = List<OptionClass>.from(l.map((model)=> OptionClass.fromJson(model)));
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Size :",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Container(
                width: 200,
                height: 20,
                child:  ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(onTap: (){
                      setState(() {
                      sizeIndex = index;
                      sizevarible = Product(taxonomy: "pa_logo", slug: model[index].slug);
                      });
                    },
                        child:  Container(
                          width: 60,
                          decoration: BoxDecoration(
                              color:  sizeIndex==index ? Colors.orange : Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                          child: Center(
                            child: Text(
                              model[index].name, style: TextStyle(color:  sizeIndex==index ?  Colors.white: Colors.black, fontWeight: medium, fontSize: 12), textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ));
                  },itemCount: attribute.options.length,
                ),
              ),
            )
          ],
        );
        break;
    }
    }

  }
  class Product {
    String slug;
    String taxonomy;

    Product({this.taxonomy, this.slug});

    factory Product.fromJson(Map<String, dynamic> json) => Product(
      taxonomy: json["taxonomy"],
      slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
      "taxonomy": taxonomy,
      "slug": slug,
    };
}

