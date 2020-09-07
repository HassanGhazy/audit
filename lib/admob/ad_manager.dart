import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9776955865735092~5846034149";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9776955865735092~1906789134";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9776955865735092/7444403886";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9776955865735092/8280625791";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
