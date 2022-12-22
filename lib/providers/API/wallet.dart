import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qwid/assets/alert.dart';
import 'package:qwid/models/bank.dart';
import 'package:qwid/models/charge.dart';
import 'package:qwid/models/statement.dart';
import 'package:qwid/models/transaction.dart';
import 'package:qwid/models/user.dart';
import 'package:qwid/models/wallet.dart';
import 'package:qwid/providers/brain/home_provider.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/vtn.dart';
import 'package:qwid/providers/data/wallet.dart';

class WalletAPI extends ChangeNotifier {
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

  Future getStatement({
    required String? cur,
    required String? year,
    required BuildContext context,
  }) async {
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      WalletData data = Provider.of<WalletData>(context, listen: false);
      http.Response response = await http.post(
        Uri.parse('${url}api/statement/user/${auth.user!.uid}'),
        body: {
          'cur': cur,
          'month': '',
          'year': year,
        },
        headers: header,
      );
      debugPrint('get statement: ${response.body}');
      if (response.statusCode == 200) {
        List statements = jsonDecode(response.body)['content']['data'];
        data.statements = statements.map((e) => Statement.fromMap(e)).toList();
        // Map<String, List<Statement>> entries = {};
        // entries.addEntries(statements.entries.map((e) {
        //   List statement = e.value;
        //   return MapEntry(
        //       e.key, statement.map((e) => Statement.fromMap(e)).toList());
        // }).toList());
        // data.statements = entries;
      }
    } on Exception {
      await getStatement(
        context: context,
        cur: cur,
        // month: month,
        year: year,
      );
    } catch (e) {
      debugPrint(e.toString());
      await getStatement(
        context: context,
        cur: cur,
        // month: month,
        year: year,
      );
    }
  }

  Future getUserWallet(BuildContext context) async {
    AuthData auth = Provider.of<AuthData>(context, listen: false);
    WalletData walletData = Provider.of<WalletData>(context, listen: false);
    HomeProvider homePro = Provider.of<HomeProvider>(context, listen: false);
    if (auth.user != null) {
      try {
        http.Response response = await http.get(
          Uri.parse('${url}api/wallet/${auth.user!.uid}'),
          headers: header,
        );
        List wallets = jsonDecode(response.body)['content']['data']['wallet'];
        walletData.wallets = wallets.map((element) {
          return Wallet.fromMap(
            userMap: element,
          );
        }).toList();
        walletData.wallet = walletData.wallets.first;
        homePro.displayedWallet = walletData.wallets.first;
      } on Exception {
        await getUserWallet(context);
      } catch (e) {
        debugPrint(e.toString());
        await getUserWallet(context);
      }
    }
  }

  Future getUserBank({required BuildContext context, String? cur}) async {
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.post(
        Uri.parse('${url}api/userStaticAccount'),
        body: {
          'cur': cur,
          'userId': auth.user!.uid.toString(),
        },
        headers: header,
      );
      debugPrint('get user bank: ${response.body}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Charge?> getCharge({
    String? transType,
    BuildContext? context,
    required BuildContext cont,
    required String from,
    required String to,
  }) async {
    Charge? charge;
    VTNData? vtn;
    if (context != null) {
      vtn = Provider.of<VTNData>(context, listen: false);
    }
    try {
      AuthData auth = Provider.of<AuthData>(cont, listen: false);
      http.Response response = await http.post(
        Uri.parse('${url}api/rate'),
        body: {
          'from': from,
          'to': to,
          'userId': auth.user!.uid.toString(),
          if (context != null && vtn?.country != null)
            'country': vtn!.country!.abbr,
        },
        headers: header,
      );
      debugPrint('get charge: ${response.body}');
      if (response.statusCode == 200) {
        charge = Charge(
          rate: jsonDecode(response.body)['content']['data']['rate'].toDouble(),
          charge: int.parse(
              jsonDecode(response.body)['content']['data']['fee'].toString()),
          chargesType: jsonDecode(response.body)['content']['data']['feeMode'],
          peer: jsonDecode(response.body)['content']['data']['peer'],
        );
      }
    } on Exception {
      await getCharge(
        transType: transType,
        cont: cont,
        context: context,
        from: from,
        to: to,
      );
    } catch (e) {
      debugPrint(e.toString());
      await getCharge(
        transType: transType,
        cont: cont,
        context: context,
        from: from,
        to: to,
      );
    }
    return charge;
  }

  Future<bool> convert(String? fromAmount, String? toAmount, String? charge,
      String fromCur, String toCur, BuildContext context) async {
    bool success = false;
    try {
      WalletData walletData = Provider.of<WalletData>(context, listen: false);
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.post(
        Uri.parse('${url}api/transaction/convert/${auth.user!.uid}'),
        body: {
          "transId": "",
          "purpose": "Convert",
          "desc": "",
          "fromCur": fromCur,
          "toCur": toCur,
          "fromAmount": fromAmount,
          "toAmount": toAmount,
          "charges": charge
        },
        headers: header,
      );
      debugPrint('convert: ${response.body}');
      if (response.statusCode == 200) {
        success = true;
        await getUserWallet(context);
        alert(context: context, content: 'Convert was successful');
        Navigator.pop(context);
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

  Future<List<Transaction>> getUserTransactions({
    int? start,
    int? limit,
    String? cur,
    bool save = true,
    required BuildContext context,
  }) async {
    AuthData auth = Provider.of<AuthData>(context, listen: false);
    WalletData data = Provider.of<WalletData>(context, listen: false);
    List<Transaction> transactions = [];

    if (auth.user != null) {
      try {
        http.Response response = await http.post(
          cur == null
              ? Uri.parse('${url}api/transaction/user/${auth.user!.uid}')
              : Uri.parse(
                  '${url}api/transaction/user/cur/${auth.user!.uid}',
                ),
          body: {
            if (start != null) 'start': start.toString(),
            if (limit != null) 'limit': limit.toString(),
            if (cur != null) 'cur': cur,
          },
          headers: header,
        );
        debugPrint('transactions: ${response.body}');
        if (response.statusCode == 200) {
          List trans = await jsonDecode(response.body)['content']['data']
                  ['transaction'] ??
              [];
          if (save) {
            data.transactions
                .addAll(trans.map((e) => Transaction().fromMap(e)).toList());
          }
          transactions = trans.map((e) => Transaction().fromMap(e)).toList();
          // .where((element) =>
          //     element.externalName != null && element.externalName.isNotEmpty)
          // .toList();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return transactions;
  }

  Future<String?> getTransactionId({required BuildContext context}) async {
    String? transId;
    try {
      http.Response response = await http.get(
        Uri.parse('${url}api/transId'),
        headers: header,
      );

      if (response.statusCode == 200) {
        transId = jsonDecode(response.body)['transId'];
      } else {
        debugPrint(response.reasonPhrase);
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      alert(context: context, content: 'There was an error, please try again');
    }
    return transId;
  }

  Future<bool> sendMoney(String? fromCur, String? toCur, String? fromAmount,
      String? toAmount, double charge, int id, BuildContext context, int type,
      {int? bankId, String? referenceNo}) async {
    bool success = false;
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    WalletData walletData = Provider.of<WalletData>(context, listen: false);
    VTNData vtn = Provider.of<VTNData>(context, listen: false);
    String? proof;
    if (walletData.purposeFile != null) {
      proof = base64Encode(await walletData.purposeFile!.readAsBytes());
    }
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.post(
        Uri.parse('${url}api/transaction/offshore/${auth.user!.uid}'),
        body: {
          if (bankId != null) 'bankId': bankId.toString(),
          'remittancePurpose': '${vtn.purpose!.id}-${vtn.purpose!.name}',
          'fundSource': '${vtn.source!.id}-${vtn.source!.name}',
          'paymentType': type.toString(),
          if (referenceNo != null) 'transId': referenceNo,
          if (referenceNo != null) 'referenceNo': referenceNo,
          'fromCur': fromCur,
          'toCur': toCur,
          'fromAmount': fromAmount,
          'toAmount': toAmount,
          'charges': charge.toString(),
          'beneficiaryId': id.toString(),
          if (proof != null) 'remittancePurposeFile': proof,
          if (proof != null)
            'extension': walletData.purposeFile!.path.split('.').last,
        },
        headers: header,
      );
      debugPrint('send money: ${response.body}');
      if (response.statusCode == 200) {
        success = true;
        await getUserWallet(context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Success(),
        //   ),
        // );
      } else if (response.statusCode == 500) {
        alert(context: context, content: 'Internal error, try again later');
      } else {
        alert(context: context, content: jsonDecode(response.body)['message']);
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      debugPrint(e.toString());
      alert(context: context, content: 'There was an error, please try again');
    }
    return success;
  }

  Future<bool> transfer(
    String? fromAmount,
    String? toAmount,
    String? charge,
    int id,
    BuildContext context,
  ) async {
    bool success = false;
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    WalletData walletData = Provider.of<WalletData>(context, listen: false);
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      print({
        'fromCur': walletData.wallet?.cur,
        'toCur': walletData.beneficiaryCur,
        'fromAmount': fromAmount,
        'toAmount': toAmount,
        'charges': charge,
        'receiver': id.toString(),
      });
      http.Response response = await http.post(
        Uri.parse('${url}api/transaction/transfer/${auth.user!.uid}'),
        body: {
          'fromCur': walletData.wallet?.cur,
          'toCur': walletData.beneficiaryCur,
          'fromAmount': fromAmount,
          'toAmount': toAmount,
          'charges': charge,
          'receiver': id.toString(),
        },
        headers: header,
      );
      debugPrint('transfer: ${response.body}');
      if (response.statusCode < 300) {
        success = true;
        await getUserWallet(context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Success(),
        //   ),
        // );
      } else if (response.statusCode < 500) {
        alert(context: context, content: jsonDecode(response.body)['message']);
      } else {
        alert(context: context, content: 'Internal error, try again later');
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      debugPrint(e.toString());
      alert(context: context, content: 'There was an error, please try again');
    }
    return success;
  }

  Future<bool> withdraw(
      String? amount, String? charge, String? cur, BuildContext context) async {
    bool success = false;
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.post(
        Uri.parse(
            '${url}api/transaction/initiate-withdrawal/${auth.user!.uid}'),
        body: {
          'cur': cur,
          'amount': amount,
          'charges': charge,
        },
        headers: header,
      );
      debugPrint(response.reasonPhrase);
      if (response.statusCode == 200) {
        success = true;
        await getUserWallet(context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Success(),
        //   ),
        // );
      } else if (response.statusCode == 500) {
        alert(context: context, content: 'Internal error, try again later');
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

  Future<bool> confirmDeposit({
    String? cur,
    String? amount,
    String? referenceNo,
    int? id,
    required BuildContext context,
  }) async {
    bool success = false;
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.post(
        Uri.parse(
            '${url}api/transaction/initiate-bank-transfer/${auth.user!.uid}'),
        body: {
          "transId": referenceNo,
          "cur": cur,
          "amount": amount,
          "bankId": id.toString(),
          "source": "virtual"
        },
        headers: header,
      );
      debugPrint(response.reasonPhrase);
      if (response.statusCode == 500) {
        alert(context: context, content: 'Internal error, please try again');
      } else if (response.statusCode == 200) {
        success = true;
        await getUserWallet(context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Success(),
        //   ),
        // );
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

  // Future<http.Response> confirmDeposit(String? transId) async {
  //   http.Response response = await http.patch(
  //     Uri.parse('${url}api/transaction/debit/confirm'),
  //     headers: header,
  //     body: {
  //       'transId': transId,
  //     },
  //   );
  //   debugPrint('confirm deposit: ${response.body}');
  //   return response;
  // }

  Future<List<Bank>> getAdminBank(String? cur, BuildContext context) async {
    List data = [];
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.get(
        Uri.parse('${url}api/adminbank/${auth.user!.uid}/$cur'),
        headers: header,
      );
      debugPrint('get admin bank: ${response.body}');

      if (response.statusCode == 200 &&
          jsonDecode(response.body)['content'] != null) {
        data = jsonDecode(response.body)['content']['data'];
      }
    } on Exception {
      // getAdminBank(cur, context);
    } catch (e) {
      // getAdminBank(cur, context);
    }
    return data.map((e) => Bank().fromMap(e)).toList();
  }

  Future<List<Bank>> getUserBanks(String? cur, BuildContext context) async {
    List data = [];
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.get(
        Uri.parse('${url}api/bank/${auth.user!.uid}/$cur'),
        headers: header,
      );
      debugPrint('user banks: ${response.body}');
      if (response.statusCode == 200) {
        data = jsonDecode(response.body)['content']['data'];
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      alert(context: context, content: 'There was an error, please try again');
    }
    return data.map((e) => Bank().fromMap(e)).toList();
  }

  Future<List<User>> searchUser(String email, BuildContext context) async {
    List<User> users = [];
    try {
      http.Response response = await http.get(
        Uri.parse('${url}api/endUsers/search/${email.toLowerCase()}'),
        headers: header,
      );
      debugPrint('search user: ${response.body}');
      if (response.statusCode == 200) {
        List _users = jsonDecode(response.body)['content']['data'];
        users = _users
            .map(
              (e) => User.fromMap(
                userMap: jsonDecode(response.body)['content']['data'][0],
                token: '',
              ),
            )
            .toList();
        if (users.isEmpty) {
          alert(
            context: context,
            content:
                'We found no users registered with the email you provided, crosscheck and try again',
          );
        }
      } else {
        alert(
            context: context,
            content: jsonDecode(response.body)['message'] ??
                'There was an error, try again');
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      alert(context: context, content: 'There was an error, please try again');
    }
    return users;
  }

  Future addTransaction({
    String? transType,
    String? fromCur,
    String? toCur,
    String? fromAmount,
    String? toAmount,
    String? charges,
    String? externalId,
    required BuildContext context,
  }) async {
    AuthData auth = Provider.of<AuthData>(context, listen: false);
    WalletData walletData = Provider.of<WalletData>(context, listen: false);
    Map<String, String> types = {
      'deposit': '1',
      'withdrawal': '2',
      'sending': '3',
      'transfer': '4',
    };
    http.Response response = await http.post(
      Uri.parse('${url}api/transaction/${auth.user!.uid}'),
      body: {
        "transId": '',
        "transType": types[transType],
        "purpose": transType,
        "desc": "",
        "walletData.fromCur": walletData.fromCur,
        "walletData.toCur": walletData.toCur,
        "fromAmount": fromAmount,
        "toAmount": toAmount,
        "charges": charges,
        if (externalId != null) "externalId": externalId,
        "confirmation": "0",
        "status": "0"
      },
      headers: header,
    );
    debugPrint('add transaction: ${response.body}');
  }

  // Stream confirm(String? transId) {
  //   bool? success = false;
  //   Stream stream = Stream.periodic(
  //       Duration(
  //         minutes: 3,
  //       ), (index) async {
  //     if (!success) {
  //       http.Response response = await confirmDeposit(transId);
  //       success = jsonDecode(response.body)['success'];
  //     }
  //     return success;
  //   });
  //   return stream;
  // }
  Future<bool?> getDocStats(BuildContext context) async {
    bool? status;
    try {
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.get(
        Uri.parse('${url}api/document/user/status/${auth.user!.uid}'),
        headers: header,
      );
      if (response.statusCode != 200) {
        alert(context: context, content: jsonDecode(response.body)['message']);
      } else {
        status = jsonDecode(response.body)['upload'];
        if (!status!) {
          alert(
              context: context, content: jsonDecode(response.body)['message']);
        }
      }
    } on Exception {
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    } catch (e) {
      alert(
        context: context,
        content: 'There was an error, please try again',
      );
    }
    return status;
  }
}
