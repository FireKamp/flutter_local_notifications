import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class Analytics {
  static logEvent(String eventName) {
    if (kReleaseMode) {
      FirebaseAnalytics().logEvent(name: eventName);
    } else {
      print("[FAKE ANALYTICS]: ${eventName}");
    }
  }

  static logEventWithParameter(
      String eventName, String parameterName, String parameterValue) {
    if (kReleaseMode) {
      FirebaseAnalytics()
          .logEvent(name: eventName, parameters: {parameterName: parameterValue});
    } else {
      print("[FAKE ANALYTICS]: ${eventName}, params:[${parameterName}, ${parameterValue}]");
    }
  }
}
