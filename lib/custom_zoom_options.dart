
class ZoomInitilaizedWithToken {
  String? domain;
  String? jwtToken;

  ZoomInitilaizedWithToken({
    this.domain,
    this.jwtToken
  });
}
class ZoomInitilaizedWithOutToken {
  String? domain;
  String? appKey;
  String? appSecret;

  ZoomInitilaizedWithOutToken({
    this.domain,
    this.appKey,
    this.appSecret,
  });
}


class CustomZoomMeetingOptions {

  String? userId;
  String? displayName;
  String? meetingId;
  String? meetingPassword;
  String? zoomToken;
  String? zoomAccessToken;
  String? disableDialIn;
  String? disableDrive;
  String? disableInvite;
  String? disableShare;
  String? disableTitlebar;
  String? noDisconnectAudio;
  String? noAudio;
  String? viewOptions;

  CustomZoomMeetingOptions({
    this.userId,
    this.displayName,
    this.meetingId,
    this.meetingPassword,
    this.zoomToken,
    this.zoomAccessToken,
    this.disableDialIn,
    this.disableDrive,
    this.disableInvite,
    this.disableShare,
    this.disableTitlebar,
    this.noDisconnectAudio,
    this.noAudio,
    this.viewOptions
  });
}
class CustomZoomScheduleOptions {
  String? setMeetingTopic;
  String? setStartTime;
  String? durationMinute;
  String? canJoinBeforeHost;
  String? setPassword;
  String? setHostVideoOff;
  String? setAttendeeVideoOff;
  String? setTimeZoneId;
  String? setEnableMeetingToPublic;
  String? setEnableLanguageInterpretation;
  String? setEnableWaitingRoom;
  String? setUsePmiAsMeetingID;
  String? enableAutoRecord;
  String? autoLocalRecord;
  String? autoCloudRecord;

  CustomZoomScheduleOptions({
    this.setMeetingTopic,
    this.setStartTime,
    this.durationMinute,
    this.canJoinBeforeHost,
    this.setPassword,
    this.setHostVideoOff,
    this.setAttendeeVideoOff,
    this.setTimeZoneId,
    this.setEnableMeetingToPublic,
    this.setEnableLanguageInterpretation,
    this.setEnableWaitingRoom,
    this.setUsePmiAsMeetingID,
    this.enableAutoRecord,
    this.autoLocalRecord,
    this.autoCloudRecord
  });
}
