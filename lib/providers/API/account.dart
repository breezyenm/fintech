import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qwid/assets/alert.dart';
import 'package:qwid/models/virtual_account.dart';
import 'package:qwid/models/virtual_accounts.dart';
import 'package:qwid/providers/brain/account_provider.dart';
import 'package:qwid/providers/data/auth.dart';

class AccountAPI extends ChangeNotifier {
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

  Future getUsersVirtualWallets(BuildContext context) async {
    AuthData auth = Provider.of<AuthData>(context, listen: false);
    AccountProvider accountProvider =
        Provider.of<AccountProvider>(context, listen: false);
    try {
      var response = await http.get(
        Uri.parse('${url}api/virtualAccount/users/${auth.user?.uid}'),
        headers: header,
      );

      debugPrint('virtual wallets: ${response.body}');
      if (response.statusCode == 200) {
        List virtualAccount =
            jsonDecode(response.body)['content']['data'] ?? [];
        accountProvider.virtualAccounts = virtualAccount
            .map((e) => VirtualAccount.fromMap(userData: e))
            .toList();
      } else {
        debugPrint(response.reasonPhrase);
      }
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

  Future<List<VirtualAccounts>> getAllVirtualWallets(
      BuildContext context) async {
    AuthData auth = Provider.of<AuthData>(context, listen: false);
    AccountProvider accountProvider =
        Provider.of<AccountProvider>(context, listen: false);
    try {
      // var request = http.Request('GET', Uri.parse('${url}api/virtualAccount'));
      // request.bodyFields = {'year': '2021', 'month': ''};
      var response = await http.get(
        Uri.parse('${url}api/virtualAccount/available/${auth.user?.uid}'),
        headers: header,
      );

      // http.StreamedResponse response = await request.send();

      debugPrint('virtual accounts: ${response.body}');
      if (response.statusCode == 200) {
        List virtualAccounts = jsonDecode(response.body)['content']['data'];
        accountProvider.virtualAccountsToBeAdded = virtualAccounts
            .map((e) => VirtualAccounts.fromMap(userData: e))
            .toList();
      } else {
        debugPrint(response.reasonPhrase);
      }
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
    return accountProvider.virtualAccountsToBeAdded;
  }

  Future<bool> requestVirtualAccount(BuildContext context, String cur) async {
    bool success = false;
    AuthData auth = Provider.of<AuthData>(context, listen: false);
    try {
      // var request = http.Request('GET', Uri.parse('${url}api/virtualAccount'));
      // request.bodyFields = {'year': '2021', 'month': ''};
      var response = await http.post(
        Uri.parse('${url}api/virtualAccount'),
        body: {
          'userId': auth.user?.uid.toString(),
          'cur': cur,
          'email': auth.user?.email,
        },
        headers: header,
      );

      // http.StreamedResponse response = await request.send();

      debugPrint('request virtual accounts: ${response.body}');
      if (response.statusCode == 200) {
        await getUsersVirtualWallets(context);
        success = true;
      } else {
        // Navigation.pop(context);
        alert(
          context: context,
          content:
              response.reasonPhrase ?? 'Something went wrong, please try again',
        );
        debugPrint(response.reasonPhrase);
      }
    } on Exception {
      // Navigation.pop(context);
      alert(
        context: context,
        content: 'Please check your network connection',
      );
    } catch (e) {
      debugPrint(e.toString());
      // Navigation.pop(context);
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
    return success;
  }
}
