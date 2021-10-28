import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/widgets/loading.dart';

class ProgressHUD extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset offset;
  final bool dismissible;
  final Widget child;

  ProgressHUD({
    Key key,
    this.inAsyncCall,
    this.opacity = 0.3,
    this.color = grey,
    this.progressIndicator = const CircularProgressIndicator(),
    this.offset,
    this.dismissible = false,
    this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    printLog("inAsyncCall", inAsyncCall);
    if (!inAsyncCall) return child;

    Widget layOutProgressIndicator;
    if (offset == null)
      layOutProgressIndicator = Center(child: progressIndicator);
    else {
      layOutProgressIndicator = Positioned(
        child: progressIndicator,
        left: offset.dx,
        top: offset.dy,
      );
    }

    return new Stack(
      children: [
        child,
        new Opacity(
          child: new ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        layOutProgressIndicator,
      ],
    );
  }
}