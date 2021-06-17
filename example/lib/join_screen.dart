import 'dart:async';

import 'package:custom_zoom_sdk_example/meeting_screen.dart';
import 'package:custom_zoom_sdk_example/start_meeting_screen.dart';
import 'package:flutter/material.dart';


class JoinWidget extends StatefulWidget {
  @override
  _JoinWidgetState createState() => _JoinWidgetState();
}

class _JoinWidgetState extends State<JoinWidget> {

  late TextEditingController meetingIdController ;
 late TextEditingController meetingPasswordController;
  @override
  void initState() {
    meetingIdController = TextEditingController();
    meetingPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // new page needs scaffolding!
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Phoeniixx Meeting'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    controller: meetingIdController,
                    decoration: InputDecoration(
                      labelText: 'Meeting ID',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    controller: meetingPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Meeting Password',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    // The basic Material Design action button.
                    return RaisedButton(
                      // If onPressed is null, the button is disabled
                      // this is my goto temporary callback.
                      onPressed: () {

                        joinMeeting(context);
                      },
                      child: Text('Join'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    // The basic Material Design action button.
                    return RaisedButton(
                      // If onPressed is null, the button is disabled
                      // this is my goto temporary callback.
                      onPressed: () => startMeeting(context),
                      child: Text('Start Meeting'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  joinMeeting(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MeetingWidget(meetingId: meetingIdController.text, meetingPassword: meetingPasswordController.text);
        },
      ),
    );
  }

  startMeeting(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return StartMeetingWidget(meetingId: meetingIdController.text);
        },
      ),
    );
  }
}