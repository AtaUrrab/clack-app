import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  FirebaseMessaging message = FirebaseMessaging.instance;

  firebaseInit() async {
    FirebaseMessaging.onMessage.listen((event) {
      print("Notification Title: ${event.notification!.title}");
      print("Notification Body: ${event.notification!.body}");
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await message.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permisison");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User Granted Provisional Permision");
    } else {
      print("User Decline Permision");
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await message.getToken();
    return token!;
  }
}
