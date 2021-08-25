import 'dart:async';
import 'dart:io';

import 'package:custom_zoom_sdk/custom_zoom_options.dart';
import 'package:custom_zoom_sdk/custom_zoom_view.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StartMeetingWidget extends StatelessWidget {

  late CustomZoomOptions zoomOptions;
  late CustomZoomMeetingOptions meetingOptions;

  late Timer timer;

  StartMeetingWidget({Key? key, meetingId}) : super(key: key) {
    this.zoomOptions = new CustomZoomOptions(
        domain: "zoom.us",
        appKey: "0hOLo5oUgjNtcy0keTNDc6hfoNumJs2eebOk",
        appSecret: "RLqYcfqrzkWp3Xm4TW1isJpybnVv9683yH0q",
    );
    this.meetingOptions = new CustomZoomMeetingOptions(
        userId: 'prashantinagdeve@gmail.com',
        displayName: 'Rahul Sharma ',
        meetingId: "89482898887",
        zoomToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ5LWE5MEk3alFSYTlqdzNDYkphZlNRIiwiZXhwIjoxNjI5ODY1OTA2fQ.SFBddK9T2X_fMkVGtQfuLp_vVzZfjZ4qaeAUib2gCt8",
        zoomAccessToken: "W7-buFfTKvNoCC47DjeGjxfAwMTqFZqomunRsdDxBTo.BgYsM0M0K2JaVm9ub0syTjlSSjNFU2RRc0w0ckk5Q0FXS21qZndzMVZQSmVDST1AMmE2ZDI3NDZjM2FkYWM2NGY5NTMwMzBiYzVhMzQxNTAxOWMwNTRiZmM1YjY2NTI1ZmQ4NDQ4MTAwMmE3NTA4ZgAgMGZBeEY1YVV2ODZoZE4vR2N2eUhGZTZ1SEJCQjlRV0cAAAAAAXt7kyfAABJ1AAAA",
        disableDialIn: "true",
        disableDrive: "true",
        disableInvite: "true",
        disableShare: "true",
        noAudio: "false",
        noDisconnectAudio: "false"
    );
  }

  bool _isMeetingEnded(String status) {
    var result = false;

    if (Platform.isAndroid)
      result = status == "MEETING_STATUS_DISCONNECTING" || status == "MEETING_STATUS_FAILED";
    else
      result = status == "MEETING_STATUS_IDLE";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
          title: Text('Loading meeting '),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: CustomZoomView(onViewCreated: (controller) {

          print("Created the view");

          controller.initZoom(this.zoomOptions)
              .then((results) {

            print("initialised");
            print(results);

            if(results[0] == 0) {

              controller.zoomStatusEvents.listen((status) {
                print("Meeting Status Stream: " + status[0] + " - " + status[1]);
                if (_isMeetingEnded(status[0])) {
                  Navigator.pop(context);
                  timer.cancel();
                }
              });

              print("listen on event channel");

              controller.startMeeting(this.meetingOptions)
                  .then((joinMeetingResult) {

                timer = Timer.periodic(new Duration(seconds: 2), (timer) {
                  controller.meetingStatus(this.meetingOptions.meetingId!)
                      .then((status) {
                    print("Meeting Status Polling: " + status[0] + " - " + status[1]);
                  });
                });

              });
            }

          }).catchError((error) {

            print("Error");
            print(error);
          });
        })
      ),
    );
  }

}
