import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/category.dart';
import 'package:wooapp/models/cityModel.dart';
import 'package:wooapp/models/item_categories.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/loading.dart';

class cityDropList extends StatefulWidget {
  List<CityModel> cityList;
  final ValueChanged<CityModel> onChanged;
  String defaultValue;
  String hint;
  String selectedItem;
  cityDropList(
      {Key key,
        this.hint,
        this.defaultValue,
        this.cityList,
        this.onChanged,
        this.selectedItem})
      : super(key: key);

  @override
  cityDropListState createState() => cityDropListState();
}

class cityDropListState extends State<cityDropList> {
  List<CityModel> cityList;
  CityModel selectedItem;

  List<DropdownMenuItem<CityModel>> _dropdownMenuItems;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.grey[300], width: 0.5),
      ),
      child: SizedBox(
        height: 30,
        child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: DropdownButton<CityModel>(
              hint: Text(widget.hint, style: styleProvider(fontWeight: regular, size: 10, color: grey),),
              items: widget.cityList.map((model) {
                return new DropdownMenuItem<CityModel>(
                  value: model,
                  child: SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            model.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              value:
              selectedItem == null ? widget.defaultValue : selectedItem,
              isExpanded: true,
              onChanged: (CityModel model) {
                setState(() {
                  selectedItem = model;
                });
                printLog("datahh", model.id.toString());
                widget.onChanged(model);
              },
              underline: Container(),
            )),
      ),
    );
  }
}
