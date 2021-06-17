
class CustomZoomOptions {

  String? domain;
  String? appKey;
  String? appSecret;
  String? jwtToken;

  CustomZoomOptions({
    this.domain,
    this.appKey,
    this.appSecret,
    this.jwtToken
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
  String? noDisconnectAudio;
  String? noAudio;

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
    this.noDisconnectAudio,
    this.noAudio
  });
}
