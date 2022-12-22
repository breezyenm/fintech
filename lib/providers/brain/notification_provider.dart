import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/toast.dart';
import 'package:qwid/providers/API/wallet.dart';

class NotificationProvider extends ChangeNotifier {
  Future getPushToken({required BuildContext context}) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    fcmToken = await _firebaseMessaging.getToken();
    debugPrint(fcmToken);
  }

  String? fcmToken;

  Future<void> setupInteractedMessage(BuildContext context) async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    debugPrint(initialMessage?.data.toString());

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   _handleMessage(message, context);
    // });
    FirebaseMessaging.onMessage.listen((event) async {
      WalletAPI wallet = Provider.of<WalletAPI>(context, listen: false);
      await wallet.getUserWallet(context);
      await wallet.getUserTransactions(
        context: context,
        save: true,
        start: 0,
        limit: 5,
      );
      Functions.toast(
        event.data.values.first,
        context,
      );
    });
  }
}
