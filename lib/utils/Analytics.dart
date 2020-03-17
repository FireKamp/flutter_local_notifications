import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  static logEvent(String eventName) {
    FirebaseAnalytics().logEvent(name: eventName);
  }

  static logEventWithParameter(
      String eventName, String parameterName, String parameterValue) {
    FirebaseAnalytics()
        .logEvent(name: eventName, parameters: {parameterName: parameterValue});
  }
}
