import 'dart:core';
import 'dart:io';

void main(List<String> args) async {
  var location = Platform.script.toString();
  if (Platform.isWindows) {
    location = location.replaceFirst("file:///", "");
  } else {
    location = location.replaceFirst("file://", "");
  }
  location = location.replaceFirst("/bin/unzip_zoom_sdk.dart", "");

  // var filename =
  //     location + '/ios-sdk/MobileRTC${(args.length == 0) ? "" : "-dev"}.zip';

  await checkAndDownloadSDK(location);
  // print('Decompressing ' + filename);

  // final bytes = File(filename).readAsBytesSync();

  // final archive = ZipDecoder().decodeBytes(bytes);

  // var current = new File(location + '/ios/MobileRTC.framework/MobileRTC');
  // var exist = await current.exists();
  // if (exist) current.deleteSync();

  // for (final file in archive) {
  //   final filename = file.name;
  //   if (file.isFile) {
  //     final data = file.content as List<int>;
  //     File(location + '/ios/MobileRTC.framework/' + filename)
  //       ..createSync(recursive: true)
  //       ..writeAsBytesSync(data);
  //   }
  // }

  print('Complete');
}

Future<void> checkAndDownloadSDK(String location) async {
  var iosSDKFile = location + '/ios/MobileRTC.framework/MobileRTC';
  bool exists = await File(iosSDKFile).exists();

  if (!exists) {
    await downloadFile(
        Uri.parse(
            'https://www.dropbox.com/s/m8lcf3fmq5v87h3/MobileRTC.zip?dl=1'),
        iosSDKFile);
  }

  var iosSimulateSDKFile = location + '/ios/MobileRTC.framework/MobileRTC';
  exists = await File(iosSimulateSDKFile).exists();

  if (!exists) {
    await downloadFile(
        Uri.parse(
            'https://www.dropbox.com/s/p2od2gqo7m9gtiu/MobileRTC.zip?dl=1'),
        iosSimulateSDKFile);
  }

  var androidCommonLibFile = location + '/android/libs/commonlib.aar';
  exists = await File(androidCommonLibFile).exists();
  if (!exists) {
    await downloadFile(
        Uri.parse(
            'https://www.dropbox.com/s/cbmb4f7yt1m3jhw/commonlib.aar?dl=1'),
        androidCommonLibFile);
  }
  var androidRTCLibFile = location + '/android/libs/mobilertc.aar';
  exists = await File(androidRTCLibFile).exists();
  if (!exists) {
    await downloadFile(
        Uri.parse(
            'https://www.dropbox.com/s/ccp8asvz45kdomx/mobilertc.aar?dl=1'),
        androidRTCLibFile);
  }
}

Future<void> downloadFile(Uri uri, String savePath) async {
  print('Download ${uri.toString()} to $savePath');
  // var dio = Dio();
  // dio.options.connectTimeout = 1000000;
  // dio.options.receiveTimeout = 1000000;
  // dio.options.sendTimeout = 1000000;
  // await dio.downloadUri(uri, savePath);
  final request = await HttpClient().getUrl(uri);
  final response = await request.close();
  await response.pipe(File(savePath).openWrite());
}
