import 'package:flutter/material.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';

class PrivacyScreen extends BasePage{
  PrivacyScreen({Key key}) : super(key: key);
  @override
  PrivacyScreenState createState() => PrivacyScreenState();
}
class PrivacyScreenState extends BasePageState<PrivacyScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget _CustomScrollView() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                  size: 10, color: Theme.of(context).accentColor,),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Collection of your information',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10, color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'use if demographic / profile data / your information',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10, color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Cookies',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10, color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Sharing of personal information',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10,color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'links to other sites',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10, color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'security precautions',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10, color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Choice / opt-Out',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10, color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'advertisements on platform',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10,color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Children information',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10, color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'data retention',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10, color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'your contest',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10,color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'changes to this privacy policy',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                    size: 10, color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'grievance officer',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Icon(Icons.circle,
                  size: 10,),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Queries',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),


        ],
      ),
    );
  }
  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
      appBar: BaseAppBar(context, "Privacy", suffixIcon: Container()),
      body:Container(
        color: Theme.of(context).backgroundColor,
        height: MediaQuery.of(context).size.height,
        child:  SingleChildScrollView(
          child: _CustomScrollView(),
        ),
      ),
    );
  }

}