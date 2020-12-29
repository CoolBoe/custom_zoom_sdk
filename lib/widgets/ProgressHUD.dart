import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  ProgressHUD(
      {Key key,
      @required this.child,
      @required this.inAsyncCall,
      this.opacity,
      this.color,
      this.valueColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: false,
              color: color,
            ),
          ),
          new Center(
            child: progressBar(context, orange),
          )
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
