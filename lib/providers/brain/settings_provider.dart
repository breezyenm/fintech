import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:qwid/assets/alert.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SettingsProvider extends ChangeNotifier {
  bool? _fingerprint;
  bool? get fingerprint => _fingerprint;
  set fingerprint(bool? val) {
    _fingerprint = val;
    notifyListeners();
  }

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

  Future<bool> auth() async {
    LocalAuthentication localAuth = LocalAuthentication();
    bool? auth = await localAuth.authenticate(
      localizedReason: 'Please authenticate to enable',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
      ),
    );
    return auth;
  }

  Future<bool> toggleFingerprint(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      LocalAuthentication localAuth = LocalAuthentication();
      if (!(fingerprint ?? false)) {
        bool? canCheckBiometrics = await localAuth.canCheckBiometrics;
        if (canCheckBiometrics) {
          fingerprint = await localAuth.authenticate(
            localizedReason: 'Please authenticate to enable easy login',
            options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: true,
            ),
          );

          if (!(fingerprint ?? false)) {
            alert(context: context, content: 'Fingerprint not set');
          }

          preferences.setBool('fingerprint', fingerprint!);
        }
      } else {
        bool? didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Please authenticate to disable biometrics login',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
        fingerprint = !didAuthenticate;
        preferences.setBool('fingerprint', fingerprint!);
      }
    } on Exception {
      alert(
        context: context,
        content: 'Required security features not available',
      );
    }
    return fingerprint!;
  }

  Future<bool> checkFingerprint() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    fingerprint = preferences.getBool('fingerprint');
    fingerprint ??= false;
    // Create storage
    const storage = FlutterSecureStorage();

    // Read value
    String? value = await storage.read(key: 'login');
    if (value == null) {
      fingerprint = false;
    }
    await preferences.setBool('fingerprint', fingerprint ?? false);
    return fingerprint!;
  }

  Future<Map<String, String>> createGoogleAuth(
    BuildContext context,
  ) async {
    Map<String, String>? googleAuth;
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.post(
          Uri.parse('${url}api/googleAuth/${auth.user!.uid}'),
          headers: header,
          body: {
            'platform': 'Mobile',
          });
      if (response.statusCode == 200) {
        // if (jsonDecode(response.body)['success']) {
        googleAuth = {
          'code': jsonDecode(response.body)['content']['data']
                  ['googleAuthDetails']
              .first['googleAuthCode'],
          'qrCode': jsonDecode(response.body)['content']['data']
              ['googleAuthQRDisplay'],
        };
        // }
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'Please check your network connection',
        );
        // googleAuth = await getGoogleAuth(context);
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
      // getCountries(context);
    } catch (e) {
      debugPrint(e.toString());
      // getCountries(context);
    }
    return googleAuth!;
  }

  // Future<Map<String, String>> getGoogleAuth(
  //   BuildContext context,
  // ) async {
  //   Map<String, String>? googleAuth;
  //   try {
  //     AuthData auth = Provider.of<AuthData>(context, listen: false);
  //     http.Response response = await http.get(
  //       Uri.parse('${url}api/googleAuth/${auth.user!.uid}'),
  //       headers: header,
  //     );
  //     if (response.statusCode == 200) {
  //       // if (jsonDecode(response.body)['success']) {
  //       googleAuth = {
  //         'code': jsonDecode(response.body)['content']['data']
  //                 ['googleAuthDetails']
  //             .first['googleAuthCode'],
  //         'qrCode': jsonDecode(response.body)['content']['data']
  //             ['googleAuthQRDisplay'],
  //       };
  //       // }
  //     }
  //   } on Exception {
  //     alert(context: context, content: 'Please check your network connection');
  //     // getCountries(context);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     // getCountries(context);
  //   }
  //   return googleAuth!;
  // }

  Future<Map<String, String>?> getGoogleAuthStatus(
    BuildContext context,
  ) async {
    Map<String, String>? googleAuth;
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.get(
        Uri.parse('${url}api/googleAuth/status/${auth.user!.uid}'),
        headers: header,
      );
      debugPrint('get auth status: ${response.body}');
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['content']['data']['status']
                .toString()
                .toLowerCase() !=
            'active') {
          googleAuth = await createGoogleAuth(context);
        }
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      debugPrint(e.toString());
    }
    return googleAuth;
  }

  Future<Map<String, String>> deactivateGoogleAuth(
    BuildContext context,
  ) async {
    Map<String, String>? auth;
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.get(
        Uri.parse('${url}api/googleAuth/status/deactivate/${auth.user!.uid}'),
        headers: header,
      );
      if (response.statusCode == 200) {
        debugPrint('deactivate auth: ${response.body}');
        // if (jsonDecode(response.body)['content']['data']['status']
        //         .toString()
        //         .toLowerCase() !=
        //     'active') {
        //   auth = await createGoogleAuth(context);
        // }
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
      // getCountries(context);
    } catch (e) {
      debugPrint(e.toString());
      // getCountries(context);
    }
    return auth!;
  }

  Future<Map<String, String>> updateGoogleAuth(
    BuildContext context,
    String? code,
  ) async {
    Map<String, String>? auth;
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.patch(
          Uri.parse('${url}api/googleAuth/${auth.user!.uid}'),
          headers: header,
          body: {
            'platform': 'Mobile',
            'googleAuthCode': code,
          });
      debugPrint('update google auth: ${response.body}');
      // if (response.statusCode == 200) {
      //   // if (jsonDecode(response.body)['success']) {
      //   auth = {
      //     'code': jsonDecode(response.body)['content']['data']
      //             ['googleAuthDetails']
      //         .first['googleAuthCode'],
      //     'qrCode': jsonDecode(response.body)['content']['data']
      //         ['googleAuthQRDisplay'],
      //   };
      //   // }
      // } else {
      //   auth = await getGoogleAuth(context);
      // }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
      // getCountries(context);
    } catch (e) {
      debugPrint(e.toString());
      // getCountries(context);
    }
    return auth!;
  }
}
