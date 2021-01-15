import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  final int stepValue;
  final double iconSize;
  int value;
  final ValueChanged<dynamic> onchanged;

  CustomStepper(
      {@required this.stepValue,
      @required this.iconSize,
      @required this.value,
      @required this.onchanged});
  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 8, right: 10),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  setState(() {
                    widget.value = widget.value -= widget.stepValue;
                    widget.onchanged(widget.value);
                  });
                },
                child: CircleAvatar(
                  radius: 10.0,
                  backgroundColor: Colors.orange[100],
                  child: Icon(
                    Icons.remove,
                    color: Colors.red,
                    size: widget.iconSize,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                '${widget.value}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: widget.iconSize,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins'),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.value = widget.value += widget.stepValue;
                  widget.onchanged(widget.value);
                });
              },
              child: CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.orange[100],
                child: Icon(
                  Icons.add,
                  color: Colors.red,
                  size: widget.iconSize,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


