import 'package:custom_zoom_sdk_example/join_screen.dart';
import 'package:custom_zoom_sdk_example/meeting_screen.dart';
import 'package:custom_zoom_sdk_example/start_meeting_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';


void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Example Zoom SDK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [ ],
      initialRoute: '/',
      routes: {
        '/': (context) => JoinWidget(),
        '/meetingjoin': (context) => MeetingWidget(),
        '/meetingstart': (context) => StartMeetingWidget(),
      },
    );
  }
}
