import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:metamap_plugin_flutter/metamap_plugin_flutter.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:qwid/assets/alert.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/models/user.dart';
import 'package:provider/provider.dart';
import 'package:qwid/providers/brain/account_provider.dart';
import 'package:qwid/providers/brain/home_provider.dart';
import 'package:qwid/providers/brain/notification_provider.dart';
import 'package:qwid/providers/brain/settings_provider.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/vtn.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/onboarding/loader.dart';
import 'package:qwid/screens/onboarding/login.dart';
import 'package:qwid/screens/onboarding/otp.dart';
import 'package:qwid/screens/onboarding/reset_password.dart';
import 'package:qwid/screens/onboarding/update/update.dart';
import 'package:qwid/screens/onboarding/waiting.dart';

class AuthAPI extends ChangeNotifier {
  var url = 'https://test-api.qwid.io/';
  var header = {
    "Authorization":
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODI5YTYwNGMyNTljZDZlODUxMDRlMTljMmQwZjEwMDg5YjhkNzkzZTE0YTg1YWE3M2E2NmYxNjhhN2Y4NzU5MDg1MDc2Y2JhNGI4MTVkOTMiLCJpYXQiOjE2NjQ5OTU3NjguOTA0NzY4LCJuYmYiOjE2NjQ5OTU3NjguOTA0NzcyLCJleHAiOjE2OTY1MzE3NjguODk5NzUsInN1YiI6IjIiLCJzY29wZXMiOltdfQ.AQMBLOQIa8ufn9K6nbyBanv8l6kTzz6pzoBBFdd4B_Osz-jRX-N6gxMvrk_roTPH0u-mHxErRdcWGWHoobR7C-DdkvpAGCAhaOhOiBqIXo6uSxDjHWdEoeEIvG3y_pppS5Ade01fSKnbu4BwFDkhyYCvYoAaHJt1VZzjcrTPwS9EyI4RMgKsz35G7mlwzFvO1lQs0pBR12AfL6-q5uhKnbr9IS1EA7BJGJ2JD6vjGIewA9d1qMOVCUeBpybTWC9yevV3qyRwQ8uK2fpieLmFqeqhDYSTPOjBUtCJ7Sfe0DT9OxTyixCsWvyhSJhyXH8TMcGdp4tPPru4sXpmGATWqOcoGkp2duK7pbf4UrMQmyQcU86O2VlAb729C8HNHdh7Ss9CdOWKmqpM5gUIhDhAtZ6D3IPJsYPekcVRySLS26dmwVaSbf8abpaDwzlY3Ku3Ph9VPT3h6Tb5N9Ks_8j98TCBM3ZIYUaZYTHhrqzInib-7vyN50GbXMRAN8HQWAIPqvztrnQDpFIIEyfs__KYPycNx8FfMPViSc0ZwgdsEIgvDjrNICCW_ClTzYORoWd1jW-pghzChroDigRGBbCs7Lqiyt7rp8KjwgldmCDVXeoC_K6PiytSklDZW42bzaxMa1lCkzAA5b52LhfhcpK345nZJ_YPwFqQ6MsGXodYVRU"
  };
  // var url = 'https://api.blinqremit.io/';
  // var header = {
  //   "Authorization":
  //       "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNDhkOGFhYjRiZDQxNjZlM2Y1ZGEyODJjYjNmNDYzNDczZDhkZDM1M2E5MDZiNTJhY2U4MDhmYzMxY2IzMjNiZjk4ZTdjNzVlZWU0ZmY3YWIiLCJpYXQiOjE2NDYyNjEwMTEuMDE1MTU3LCJuYmYiOjE2NDYyNjEwMTEuMDE1MTYxLCJleHAiOjE2Nzc3OTcwMTEuMDA3MDg0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.mXOfJubTy3kKCo9dbbZfXKR83WNNPygyiC1xLA_txUqMBj8Uzmrn5LzBEsRi4EAIxkV2ptfano3xf2tf6427YVk0DhchVCSYWG-vujiiIzpVaGszDAxoaHXI4fXazfaoyKMR9Rt5aivAfn6ZYewfIB2x6tNIWJ5g7vyLCl9D0AYCX17Q5UJ5948uRDLuqirlpviRbGUf3HOmiFf4GwOiAhOWnzrWYfX9Tyn6qVlVfDZUM_UaxXIMSq8ad6xluT18peU_v2OblsaVGSBYQH9PnSorkCbeEsoXVkrEOtGjc9TclqbFfwf0s0ImLzA04Ac43dxyrzEiXWNa-FeMhZcVcSnhiM8jIPgmmaA0DxLARtVIhTocn1tfduo82IG4M2S7reXPFvaAcJP8yS4KXQ4lfZox7lWi3jRvbiygf-YFT42-VXOuGEMFfR6eYeqivNcdLzfEGLnvLIGuXws7Jm9gx18cDMHwWQV-zZB9lTckCERzItx764r8fbB3LJaRGAuBpwlLeTi4Bjj9w3CaSQqzP-5Z3XlZ6_HBuuWfZS9jxTh9KofbM2GCut0ZhSCzh5PEdZAFGqHRpIn2R7BqDbc3OX8z7lDfpVBqqBNETjurfM9LGBeaqxhjgavYDSbohl1ZVTR50-GOFEqDT9dbBe57we-7dUPCqfFlA7CBHysYQno"
  // };

  Future<bool> logout(BuildContext context) async {
    bool success = false;
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    try {
      var response = await http.patch(
        Uri.parse(
            '${url}api/login/${authData.user?.uid}/${authData.user?.token}'),
        headers: header,
      );
      debugPrint('logout: ${response.body}');
      if (response.statusCode != 200) {
        debugPrint(response.reasonPhrase);
        debugPrint(response.request.toString());
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error, please try again',
        );
      } else {
        // Create storage
        const storage = FlutterSecureStorage();
// Delete all
        await storage.deleteAll();
        success = true;
        // String? pix =
        //     jsonDecode(response.body)['content']['data']['enduser'][0]['pix'];
        // if (pix != null && pix.startsWith('data')) {
        //   pix = pix.split('base64,')[1];
        // }
        await Navigation.replaceAll(
          const LoginPage(),
          context,
        );
      }
    } on Exception {
      alert(
        context: context,
        content: 'Please check your network connection',
      );
    } catch (e) {
      debugPrint(e.toString());
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
    return success;
  }

  Future<bool> setNotificationToken(BuildContext context) async {
    bool success = false;
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    NotificationProvider notif =
        Provider.of<NotificationProvider>(context, listen: false);
    await notif.getPushToken(context: context);
    String? deviceId = await PlatformDeviceId.getDeviceId;
    try {
      Map<String, String> _header = {};
      _header.addAll(header);
      _header['Content-Type'] = 'application/json';
      var response = await http.post(
        Uri.parse('${url}api/set-noty-token'),
        body: jsonEncode({
          "platform": Platform.isAndroid ? "Android" : 'iOS',
          'deviceId': deviceId,
          'notificationId': notif.fcmToken,
          'topic': "io.blinqpay.qwid",
          'userId': authData.user?.uid,
        }),
        headers: _header,
      );
      debugPrint('set notification: ${response.body}');
      if (response.statusCode != 200) {
      } else {
        success = true;
        // Create storage
//         const storage = FlutterSecureStorage();
// // Write value
//         await storage.write(
//           key: 'login',
//           value: jsonEncode(
//             {
//               "email": authData.email.text.toLowerCase().trim(),
//               "password": authData.password.text.trim(),
//             },
//           ),
//         );
        // String? pix =
        //     jsonDecode(response.body)['content']['data']['enduser'][0]['pix'];
        // if (pix != null && pix.startsWith('data')) {
        //   pix = pix.split('base64,')[1];
        // }
        // authData.user = User.fromMap(
        //   userMap: jsonDecode(response.body)['content']['data']['enduser'][0],
        //   token: jsonDecode(response.body)['content']['data']['loginSession'][0]
        //       ['loginToken'],
        // );
        // debugPrint('profile Pic: ${authData.user?.pix}');
        // authData.clear();
        // await loginCheck(context);
      }
    } on Exception {
      alert(
        context: context,
        content: 'Please check your network connection',
      );
    } catch (e) {
      debugPrint('set notification error: $e');
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
    return success;
  }

  Future<bool> loginUser(BuildContext context) async {
    bool success = false;
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    WalletData walletData = Provider.of<WalletData>(context, listen: false);
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    AccountProvider accountProvider =
        Provider.of<AccountProvider>(context, listen: false);
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    // NotificationProvider notif =
    //     Provider.of<NotificationProvider>(context, listen: false);
    // await notif.getPushToken(context: context);
    // String? deviceId = await PlatformDeviceId.getDeviceId;
    try {
      authData.user = null;
      walletData.wallet = null;
      walletData.wallets.clear();
      walletData.transactions.clear();
      accountProvider.virtualAccounts = null;
      accountProvider.wallet = null;
      homeProvider.selectedIndex = 0;
      var response = await http.post(
        Uri.parse('${url}api/login'),
        body: {
          "email": authData.email.text.toLowerCase().trim(),
          "password": authData.password.text.trim(),
          "platform": Platform.isAndroid ? "Android" : 'iOS',
          // 'deviceId': deviceId,
          // 'notification': notif.fcmToken,
          // 'topic': "io.blinqpay.qwid",
        },
        headers: header,
      );
      debugPrint(response.request.toString());
      debugPrint('login: ${response.body}');
      // debugPrint(jsonDecode(response.body)['content']['data'].keys.toString());
      // debugPrint(response.statusCode.toString());
      if (response.statusCode != 200) {
        debugPrint(response.reasonPhrase);
        debugPrint(response.request.toString());
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error, please try again',
        );
      } else {
        success = true;
        // Create storage
        const storage = FlutterSecureStorage();
// Write value
        await storage.write(
          key: 'login',
          value: jsonEncode(
            {
              "email": authData.email.text.toLowerCase().trim(),
              "password": authData.password.text.trim(),
            },
          ),
        );
        // String? pix =
        //     jsonDecode(response.body)['content']['data']['enduser'][0]['pix'];
        // if (pix != null && pix.startsWith('data')) {
        //   pix = pix.split('base64,')[1];
        // }
        authData.user = User.fromMap(
          userMap: jsonDecode(response.body)['content']['data']['enduser'][0],
          token: jsonDecode(response.body)['content']['data']['loginSession'][0]
              ['loginToken'],
        );
        debugPrint('profile Pic: ${authData.user?.pix}');
        authData.clear();
        await setNotificationToken(context);
        await loginCheck(context);
      }
    } on Exception {
      alert(
        context: context,
        content: 'Please check your network connection',
      );
    } catch (e) {
      debugPrint(e.toString());
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
    return success;
  }

  Future loginCheck(BuildContext context) async {
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    if (authData.user?.emailVerify == 0) {
      await resendEmail(context: context).whenComplete(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OTPPage(),
          ),
        );
      });
    } else if ((authData.user?.firstName ?? '').isEmpty) {
      // bool status = await getDocumentStatus(context);
      // await getSupportedDocuments(context: context);
      await Navigation.push(
        const UpdateProfile(),
        context,
      );
    } else {
      // await getDocumentStatus(context).then((value) async {
      //   if (value ?? false) {
      await checkKYC(context: context);
      await Navigation.replaceAll(
        (authData.user?.kycList?.isNotEmpty ?? false)
            ? const Loader()
            : const Waiting(),
        context,
      );
      // } else {
      //   await getSupportedDocuments(context: context).whenComplete(() {
      //     Navigation.replaceAll(
      //       const Verification(),
      //       context,
      //     );
      //   });
      // }
      // });
    }
  }

  Future loginWithBiometrics(BuildContext context) async {
    bool success = false;
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    // FocusScopeNode currentFocus = FocusScope.of(context);

    // if (!currentFocus.hasPrimaryFocus) {
    //   currentFocus.unfocus();
    // }
    // NotificationProvider notif =
    //     Provider.of<NotificationProvider>(context, listen: false);
    SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    bool? biometrics = await settingsProvider.auth();
    if (biometrics) {
      // var url = 'https://test-api.qwid.io/';
      // var header = {
      //   "Authorization":
      //       "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODI5YTYwNGMyNTljZDZlODUxMDRlMTljMmQwZjEwMDg5YjhkNzkzZTE0YTg1YWE3M2E2NmYxNjhhN2Y4NzU5MDg1MDc2Y2JhNGI4MTVkOTMiLCJpYXQiOjE2NjQ5OTU3NjguOTA0NzY4LCJuYmYiOjE2NjQ5OTU3NjguOTA0NzcyLCJleHAiOjE2OTY1MzE3NjguODk5NzUsInN1YiI6IjIiLCJzY29wZXMiOltdfQ.AQMBLOQIa8ufn9K6nbyBanv8l6kTzz6pzoBBFdd4B_Osz-jRX-N6gxMvrk_roTPH0u-mHxErRdcWGWHoobR7C-DdkvpAGCAhaOhOiBqIXo6uSxDjHWdEoeEIvG3y_pppS5Ade01fSKnbu4BwFDkhyYCvYoAaHJt1VZzjcrTPwS9EyI4RMgKsz35G7mlwzFvO1lQs0pBR12AfL6-q5uhKnbr9IS1EA7BJGJ2JD6vjGIewA9d1qMOVCUeBpybTWC9yevV3qyRwQ8uK2fpieLmFqeqhDYSTPOjBUtCJ7Sfe0DT9OxTyixCsWvyhSJhyXH8TMcGdp4tPPru4sXpmGATWqOcoGkp2duK7pbf4UrMQmyQcU86O2VlAb729C8HNHdh7Ss9CdOWKmqpM5gUIhDhAtZ6D3IPJsYPekcVRySLS26dmwVaSbf8abpaDwzlY3Ku3Ph9VPT3h6Tb5N9Ks_8j98TCBM3ZIYUaZYTHhrqzInib-7vyN50GbXMRAN8HQWAIPqvztrnQDpFIIEyfs__KYPycNx8FfMPViSc0ZwgdsEIgvDjrNICCW_ClTzYORoWd1jW-pghzChroDigRGBbCs7Lqiyt7rp8KjwgldmCDVXeoC_K6PiytSklDZW42bzaxMa1lCkzAA5b52LhfhcpK345nZJ_YPwFqQ6MsGXodYVRU"
      // };

      try {
        // await notif.getPushToken(context: context);
        // String? deviceId = await PlatformDeviceId.getDeviceId;
        // Create storage
        const storage = FlutterSecureStorage();

// Read value
        String? value = await storage.read(key: 'login');
        Map<String, dynamic> login = jsonDecode(value!);
        authData.email.text = login['email'];
        authData.password.text = login['password'];
        http.Response response = await http.post(
          Uri.parse('${url}api/login'),
          body: {
            "email": authData.email.text.toLowerCase().trim(),
            "password": authData.password.text.trim(),
            "platform": Platform.isAndroid ? "Android" : 'iOS',
            // 'deviceId': deviceId,
            // 'notification': notif.fcmToken,
            // 'topic': "io.blinqpay.qwid",
          },
          headers: header,
        );
        if (response.statusCode != 200) {
          alert(
            context: context,
            content: jsonDecode(response.body)['message'] ??
                'There was an error, please try again',
          );
        } else {
          success = true;
          // await preferences.setString(
          //   'login',
          //   jsonEncode(
          //     jsonDecode(response.body)['content'],
          //   ),
          // );
          // String? pix = jsonDecode(
          //         response.body)['content']
          //     ['data']['enduser'][0]['pix'];
          // if (pix != null &&
          //     pix.startsWith('data')) {
          //   pix = pix.split('base64,')[1];
          // }
          authData.user = User.fromMap(
            userMap: jsonDecode(response.body)['content']['data']['enduser'][0],
            token: jsonDecode(response.body)['content']['data']['loginSession']
                [0]['loginToken'],
          );
          authData.clear();
          await setNotificationToken(context);
          await loginCheck(context);
        }
      } on Exception {
        alert(
          context: context,
          content: 'Please check your network connection',
        );
      } catch (e) {
        debugPrint(e.toString());
        alert(
          context: context,
          content: 'There was an error, please try again',
        );
      }
    }
    return success;
  }

  Future<bool> createUser(BuildContext context) async {
    bool success = false;
    VTNData vtn = Provider.of<VTNData>(context, listen: false);
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    // NotificationProvider notif =
    //     Provider.of<NotificationProvider>(context, listen: false);
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    // await notif.getPushToken(context: context);
    // String? deviceId = await PlatformDeviceId.getDeviceId;
    try {
      var response = await http.post(
        Uri.parse('${url}api/endUsers'),
        body: {
          "username": "",
          "email": authData.email.text.toLowerCase().trim(),
          "password": authData.password.text.toLowerCase().trim(),
          "platform": Platform.isAndroid ? "Android" : 'iOS',
          "level": "2",
          "country": vtn.country?.name,
          if (authData.companyName.text.isNotEmpty)
            "companyName": authData.companyName.text.trim(),
          if (authData.referral.text.isNotEmpty)
            "referral": authData.referral.text,
          // 'deviceId': deviceId,
          // 'notification': notif.fcmToken,
          // 'topic': "io.blinqpay.qwid",
          // 'userId': "",
        },
        headers: header,
      );
      debugPrint('register: ${response.body}');

      if (response.statusCode != 200) {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'].toString(),
        );
      } else {
        success = true;
        // await preferences.setString(
        //   'login',
        //   jsonEncode(jsonDecode(response.body)['content']),
        // );

        authData.user = User.fromMap(
          userMap: jsonDecode(response.body)['content']['data']['endUser'][0],
          token: jsonDecode(response.body)['content']['data']['loginSession'][0]
              ['loginToken'],
        );
        await setNotificationToken(context);
        await loginCheck(context);
        authData.clear();
      }
    } on Exception {
      alert(
        context: context,
        content: 'Please check your network connection',
      );
    } catch (e) {
      debugPrint(e.toString());
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
    return success;
  }

  Future verify(BuildContext context) async {
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    bool error = false;
    try {
      authData.supportedFiles.forEach((id, file) async {
        if (!error) {
          List<int> bytes = await file.readAsBytes();
          http.Response response = await http.post(
            Uri.parse('${url}api/document/${authData.user!.uid}'),
            body: {
              "supportedId": jsonEncode(int.parse(id)),
              "file": base64Encode(bytes),
              'extension': file.path.split('.').last,
            },
            headers: header,
          );
          debugPrint('verify: ${response.body}');
          if (response.statusCode != 200) {
            debugPrint(jsonDecode(response.body)['message']);
            await alert(
              context: context,
              content: jsonDecode(response.body)['message'].toString(),
            );
            error = true;
          }
        }
      });
      if (!error) {
        Navigation.replaceAll(
          const Waiting(),
          context,
        );
      } else {}
    } on Exception {
      alert(
        context: context,
        content: 'Please check your network connection',
      );
    } catch (e) {
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
  }

  Future kycVerification(BuildContext context) async {
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    bool success = false;
    try {
      final metaData = {
        "user_id": authData.user?.email,
        'userType': authData.user?.userType,
      };
      MetaMapFlutter.showMetaMapFlow(
        "629a22873eb640001c5dc1e0",
        authData.user?.userType == 1
            ? '62ebce4b06f1e1001c505dc7'
            : '62fa8597864767001d5c5662',
        metaData,
      );
      await MetaMapFlutter.resultCompleter.future.then((result) async {
        if (result is ResultSuccess) {
          await alert(
            content: 'KYC Verification is successful',
            context: context,
          );
          await loginCheck(context);
        } else {
          alert(
            content: 'KYC Verification failed',
            context: context,
          );
        }
      });
      // }) => Fluttertoast.showToast(
      //     msg: result is ResultSuccess ? "Success ${result.verificationId}" : "Cancelled",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM));
    } on Exception {
      alert(
        context: context,
        content: 'Please check your network connection',
      );
    } catch (e) {
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
  }

  Future checkKYC({required BuildContext context}) async {
    try {
      AuthData authData = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http
          .post(Uri.parse('${url}api/get-user-kyc'), headers: header, body: {
        'userId': authData.user?.uid.toString(),
      });
      debugPrint('check KYC: ${response.body}');
      if (response.statusCode != 200) {
        // alert(
        //   context: context,
        //   content: jsonDecode(response.body)['message'].toString(),
        // );
      } else {
        authData.user?.kycList =
            jsonDecode(response.body)['content']['data']['kycList'];
        authData.user?.kycStatus =
            jsonDecode(response.body)['content']['data']['kycStatus'];
      }
    } on Exception {
      alert(
        context: context,
        content: 'Please check your network connection',
      );
    } catch (e) {
      debugPrint(e.toString());
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
  }

  // Future getSupportedDocuments({required BuildContext context}) async {
  //   try {
  //     AuthData authData = Provider.of<AuthData>(context, listen: false);
  //     http.Response response = await http.get(
  //       Uri.parse('${url}api/supported/user/${authData.user?.uid}'),
  //       headers: header,
  //     );
  //     if (response.statusCode != 200) {
  //       // alert(
  //       //   context: context,
  //       //   content: jsonDecode(response.body)['message'].toString(),
  //       // );
  //     } else {
  //       List documents = jsonDecode(response.body)['content']['data'];
  //       authData.documents = documents
  //           .map(
  //             (e) => Document(
  //               id: e['id'].toString(),
  //               name: e['name'],
  //             ),
  //           )
  //           .toList();
  //     }
  //   } on Exception {
  //     alert(
  //       context: context,
  //       content: 'Please check your network connection',
  //     );
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     alert(
  //       context: context,
  //       content: 'There was an error, please try again',
  //     );
  //   }
  // }

  Future<bool> verifyEmail({
    required BuildContext context,
  }) async {
    bool success = false;
    try {
      AuthData authData = Provider.of<AuthData>(context, listen: false);
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      var response = await http.post(
        Uri.parse('${url}api/confirmEmailVerify'),
        body: {
          'userId': authData.user!.uid!.toString(),
          'code': authData.code.text,
        },
        headers: header,
      );
      debugPrint('verify email: ${response.body}');
      if (response.statusCode == 200) {
        success = true;
        authData.user!.emailVerify = 1;
        await loginCheck(context);
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error, please try again',
        );
      }
    } on Exception {
      alert(
        context: context,
        content: 'Please check your network connection',
      );
    } catch (e) {
      debugPrint(e.toString());
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
    return success;
  }

  // Future<bool?> getDocumentStatus(BuildContext context) async {
  //   AuthData authData = Provider.of<AuthData>(context, listen: false);
  //   bool? status;
  //   try {
  //     http.Response response = await http.get(
  //       Uri.parse('${url}api/document/user/status/${authData.user!.uid}'),
  //       headers: header,
  //     );
  //     if (response.statusCode == 200) {
  //       debugPrint('status: ${response.body}');
  //       status = jsonDecode(response.body)['upload'];
  //       if (!(status ?? true)) {
  //         await alert(
  //           context: context,
  //           content: jsonDecode(response.body)['message'],
  //         );
  //       }
  //     } else {
  //       await alert(
  //         context: context,
  //         content: jsonDecode(response.body)['message'] ??
  //             'Internal error, try again later',
  //       );
  //     }
  //   } on Exception {
  //     getDocumentStatus(context);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     alert(
  //       context: context,
  //       content: 'There was an error, please try again',
  //     );
  //   }
  //   return status;
  // }

  Future resendEmail({required BuildContext context}) async {
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    try {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      var response = await http.post(
        Uri.parse('${url}api/resendEmailVerify'),
        body: {
          'userId': authData.user!.uid!.toString(),
        },
        headers: header,
      );
      debugPrint('resend email: ${response.body}');
      authData.verificationCode =
          jsonDecode(response.body)['content']['data']['code'];
    } on Exception {
      alert(
        context: context,
        content: 'Please check your network connection',
      );
    } catch (e) {
      debugPrint(e.toString());
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
  }

  Future forgotPassword(BuildContext context) async {
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('${url}api/forgetpassword'),
        body: {
          'email': authData.email.text,
        },
        headers: header,
      );
      debugPrint('forgot password: ${response.body}');
      if (response.statusCode == 200) {
        Navigation.replaceAll(
          const ResetPassword(),
          context,
        );
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message']?.first ??
              'Internal error, try again later',
        );
      }
    } on Exception {
      alert(
        context: context,
        content: 'Check your internet connection and try again',
      );
    } catch (e) {
      debugPrint(e.toString());
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
  }

  Future<bool> resetPassword(BuildContext context) async {
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    bool status = false;
    try {
      http.Response response = await http.post(
        Uri.parse('${url}api/forgetpassword/confirm'),
        body: {
          'password': authData.newPassword.text,
          'code': authData.resetCode.text,
        },
        headers: header,
      );
      debugPrint('reset password: ${response.body}');
      if (response.statusCode < 300) {
        await alert(context: context, content: 'Password Reset Successfully');
        Navigation.replaceAll(
          const LoginPage(),
          context,
        );
        status = true;
      } else if (response.statusCode > 500) {
        alert(context: context, content: 'Internal error, try again later');
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error saving your new password, try again',
        );
      }
    } on Exception {
      alert(
        context: context,
        content: 'Check your internet connection and try again',
      );
    } catch (e) {
      debugPrint(e.toString());
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
    return status;
  }

  Future<bool> update(
    BuildContext context,
  ) async {
    bool success = false;
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    try {
      http.Response response = await http.patch(
        Uri.parse('${url}api/endUsers/profile/${authData.user!.uid}'),
        body: {
          "firstName": authData.firstName,
          "lastName": authData.lastName,
          "dob": authData.dob,
          "address": authData.address,
          "mobile": authData.phone,
          // "userType": authData.user?.userType,
        },
        headers: header,
      );
      if (response.statusCode == 200) {
        success = true;
        alert(context: context, content: jsonDecode(response.body)['message']);
        authData.user = User.fromMap(
          userMap: jsonDecode(response.body)['content']['data'][0],
          token: jsonDecode(response.body)['content']['data']['loginSession'][0]
              ['loginToken'],
        );
      } else {
        alert(context: context, content: jsonDecode(response.body)['message']);
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      alert(context: context, content: 'There was an error, please try again');
    }
    return success;
  }
}
