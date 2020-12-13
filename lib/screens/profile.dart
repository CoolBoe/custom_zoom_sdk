import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/models/mockdata/item_categories.dart';

class ProfileView extends StatefulWidget {

  const ProfileView({Key key}) : super(key: key);
  @override
  ProfileState createState()=>ProfileState();
}
class ProfileState extends State<ProfileView>{
  Widget _CustomScrollView(){
    List<ByCatgories> sortBy = [

      ByCatgories("Account Details", 0,'assets/icons/ic_home.svg'),
      ByCatgories("Offers", 1, 'assets/icons/ic_shop.svg'),
      ByCatgories("Notifications", 2, 'assets/icons/ic_categories.svg'),
      ByCatgories("Delivery information", 3, 'assets/icons/ic_chat.svg'),
      ByCatgories("Payment Information", 4, 'assets/icons/ic_call.svg'),
      ByCatgories("Language", 5, 'assets/icons/ic_support.svg'),
      ByCatgories("Privacy Settings", 6, 'assets/icons/ic_rating.svg'),
    ];
    return Column(
      children: <Widget>[
        AppBar(
          elevation: 0.0,
          title: Text("Account",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          centerTitle: true,
          leading: GestureDetector(
              onTap: (){
                // Navigator.of(context).pushNamed(routes.MainPage_Route);
              },
              child: Icon(
                Icons.arrow_back, color: Colors.black,
              )
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:20.0, right: 15),
              child: Card(
                elevation: 10,
                shape: CircleBorder(
                    side: BorderSide.none
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80'),
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(),
                  child:Text("Phoeniixx Design",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child:Text("Member since 2019",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black)),
                ),
                Container(
                    width: 150,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color:  Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:30.0, right: 30, top: 5, bottom: 5),
                          child: Center(
                            child: Text('EDIT ACCOUNT', style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 8)),
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: SvgPicture.asset('assets/icons/ic_order.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0, right: 20),
                      child: Text('Orders', style: TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      height: 20,
                      child: VerticalDivider(color: Colors.black, width: 2,),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: SvgPicture.asset('assets/icons/ic_location.svg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 20),
                    child: Text('My Address', style: TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500),),
                  ),
                  Container(
                    height: 20,
                    child: VerticalDivider(color: Colors.black, width: 2,),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right:20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: SvgPicture.asset('assets/icons/ic_support.svg', height: 15,width: 15,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0, right: 20),
                      child: Text('Settings', style: TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w500),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:30.0, left: 30, right:20),
          child: Container(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: sortBy.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(onTap: (){},
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top:25.0),
                          child: Text(sortBy[index].name, style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 16),),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, color: Colors.black,),
                      ],
                    ),
                  ),);
                }),
          ),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: RefreshIndicator(
            onRefresh: () async {
              await Future.value({});
            },
            child:  Center(child: _CustomScrollView())),
      ),
      );
  }
}

