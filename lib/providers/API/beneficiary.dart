import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qwid/assets/alert.dart';
import 'package:qwid/models/beneficiary.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/models/nig_bank.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/beneficiary.dart';

class BeneficiaryAPI extends ChangeNotifier {
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

  Future<List<Beneficiary>> getBeneficiary(
    int start,
    int limit,
    BuildContext context,
  ) async {
    AuthData auth = Provider.of<AuthData>(context, listen: false);
    BeneficiaryData beneficiaryData =
        Provider.of<BeneficiaryData>(context, listen: false);
    if (beneficiaryData.beneficiaries == null) {
      try {
        http.Response response = await http.post(
          Uri.parse('${url}api/beneficiary/user/${auth.user!.uid}'),
          body: {
            'start': start.toString(),
            'limit': limit.toString(),
          },
          headers: header,
        );
        debugPrint('getBeneficiary: ${response.body}');
        if (response.statusCode == 200) {
          List beneficiaries = jsonDecode(response.body)['content']?['data']
                  ?['beneficiary'] ??
              [];
          beneficiaryData.beneficiaries =
              beneficiaries.map((e) => Beneficiary.fromMap(e)).toList();
        } else {
          alert(
            context: context,
            content: jsonDecode(response.body)['message'] ??
                'There was an error getting your beneficiaries, please try again',
          );
        }
      } on Exception {
        // alert(context: context, content: 'Please check your network connection');
        // getBeneficiary(start, limit, context);
      } catch (e) {
        // getBeneficiary(start, limit, context);
      }
    }
    return beneficiaryData.beneficiaries ?? [];
  }

  Future<List<Beneficiary>> getCurBeneficiary(
    String? cur,
    int start,
    int limit,
    BuildContext context,
  ) async {
    AuthData auth = Provider.of<AuthData>(context, listen: false);
    BeneficiaryData beneficiaryData =
        Provider.of<BeneficiaryData>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('${url}api/beneficiary/currency/${auth.user!.uid}'),
        body: {
          'start': start.toString(),
          'limit': limit.toString(),
          'cur': cur,
        },
        headers: header,
      );
      debugPrint('get cur beneficiary: ${response.body}');
      if (response.statusCode == 200) {
        List beneficiaries =
            jsonDecode(response.body)['content']?['data']?['beneficiary'] ?? [];
        beneficiaryData.beneficiaries =
            beneficiaries.map((e) => Beneficiary.fromMap(e)).toList();
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error getting your $cur beneficiaries, please try again',
        );
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
      getCurBeneficiary(cur, start, limit, context);
    } catch (e) {
      getCurBeneficiary(cur, start, limit, context);
    }
    return beneficiaryData.beneficiaries ?? [];
  }

  Future<bool> addBeneficiary({
    // String? type,
    required BuildContext context,
    // required States state,
    // required City city,
    // required Country country,
    // required Currency currency,
  }) async {
    bool success = false;
    BeneficiaryData data = Provider.of<BeneficiaryData>(context, listen: false);
    AuthData auth = Provider.of<AuthData>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('${url}api/beneficiary/${auth.user!.uid}'),
        body: {
          "beneficiaryType": data.beneficiaryType,
          if (data.country?.name?.toLowerCase() == 'nigeria')
            "bankCode": data.bank?.bankCode,
          "bankName": data.country?.name?.toLowerCase() == 'nigeria'
              ? data.bank?.bankName
              : data.bankName.text,
          'accountName': data.accountName.text,
          'accountNo': data.accountNo.text,
          'mobile': data.mobile.text,
          // "bankRoutingNo": data.routingNo.text,
          'beneficiaryCountry': data.country?.abbr,
          'country': data.bankCountry?.abbr,
          'state': '${data.state?.name}-${data.state?.id}',
          'bankState': '${data.bankState?.name}-${data.bankState?.id}',
          // 'city': '${city.name}-${city.id}',
          'city': data.city,
          'bankCity': data.bankCity,
          'address': data.address.text,
          'bankAddress': data.bankAddress.text,
          'cur': data.currency?.cur,
          'accountType': data.accountType,
          'zipcode': data.zipcode.text,
          'bankZipcode': data.bankZipcode.text,
          'swift': data.swift.text,
          if (data.beneficiaryType == '2') 'beneficiaryEmail': data.email.text,
          if (data.country?.name?.toLowerCase() == 'russia')
            'cpf': data.cpf.text,
          if (data.country?.name?.toLowerCase() == 'argentina')
            'IDNumber': data.idType.text,
        },
        headers: header,
      );
      debugPrint('add beneficiary: ${response.body}');
      if (response.statusCode == 200) {
        await alert(
          context: context,
          content: jsonDecode(response.body)['message'],
        );
        success = true;
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error adding this beneficiary, please try again',
        );
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      alert(context: context, content: 'There was an error, please try again');
    }

    return success;
  }

  Future<bool> updateBeneficiary({
    // String? type,
    required BuildContext context,
    required Beneficiary beneficiary,
    // required States state,
    // required City city,
    // required Country country,
    // required Currency currency,
  }) async {
    bool success = false;
    BeneficiaryData data = Provider.of<BeneficiaryData>(context, listen: false);
    AuthData auth = Provider.of<AuthData>(context, listen: false);
    try {
      http.Response response = await http.patch(
        Uri.parse('${url}api/beneficiary/${beneficiary.id}'),
        body: {
          "beneficiaryType": data.beneficiaryType,
          if (data.bankCountry?.name?.toLowerCase() == 'nigeria')
            "bankCode": data.bank?.bankCode,
          "bankName": data.bankCountry?.name?.toLowerCase() == 'nigeria'
              ? data.bank?.bankName
              : data.bankName.text,
          'accountName': data.accountName.text,
          'accountNo': data.accountNo.text,
          'mobile': data.mobile.text,
          // "bankRoutingNo": data.routingNo.text,
          'beneficiaryCountry': data.country?.abbr,
          'country': data.bankCountry?.abbr,
          'state': '${data.state?.name}-${data.state?.id}',
          'bankState': '${data.bankState?.name}-${data.bankState?.id}',
          // 'city': '${city.name}-${city.id}',
          'city': data.city,
          'bankCity': data.bankCity,
          'address': data.address.text,
          'bankAddress': data.bankAddress.text,
          'cur': data.currency?.cur,
          'accountType': data.accountType,
          'zipcode': data.zipcode.text,
          'bankZipcode': data.bankZipcode.text,
          'swift': data.swift.text,
          if (data.beneficiaryType == '2') 'beneficiaryEmail': data.email.text,
          if (data.country?.name?.toLowerCase() == 'russia')
            'cpf': data.cpf.text,
          if (data.country?.name?.toLowerCase() == 'argentina')
            'IDNumber': data.idType.text,
        },
        headers: header,
      );
      debugPrint('update beneficiary: ${response.body}');
      if (response.statusCode == 200) {
        await alert(
          context: context,
          content: jsonDecode(response.body)['message'],
        );
        success = true;
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error adding this beneficiary, please try again',
        );
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      alert(context: context, content: 'There was an error, please try again');
    }

    return success;
  }

  Future<bool> deleteBeneficiary({
    // String? type,
    required BuildContext context,
    required Beneficiary beneficiary,
    // required States state,
    // required City city,
    // required Country country,
    // required Currency currency,
  }) async {
    bool success = false;
    try {
      http.Response response = await http.delete(
        Uri.parse('${url}api/beneficiary/${beneficiary.id}'),
        headers: header,
      );
      debugPrint('delete beneficiary: ${response.body}');
      if (response.statusCode == 200) {
        await alert(
          context: context,
          content: jsonDecode(response.body)['message'],
        );
        success = true;
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error deleting this beneficiary, please try again',
        );
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      alert(context: context, content: 'There was an error, please try again');
    }

    return success;
  }

  Future<bool> addBank({
    required BuildContext context,
  }) async {
    bool success = false;
    try {
      BeneficiaryData data =
          Provider.of<BeneficiaryData>(context, listen: false);
      AuthData auth = Provider.of<AuthData>(context, listen: false);
      http.Response response = await http.post(
        Uri.parse('${url}api/bank/${auth.user!.uid}'),
        body: {
          if (data.bankCountry?.name?.toLowerCase() == 'nigeria')
            "bankCode": data.bank?.bankCode,
          "bankName": data.bankCountry?.name?.toLowerCase() == 'nigeria'
              ? data.bank?.bankName
              : data.bankName.text,
          'accountName': data.accountName.text,
          'accountNo': data.accountNo.text,
          // "bankRoutingNo": data.routingNo.text,
          'country': data.bankCountry?.abbr,
          'state': '${data.bankState?.name}-${data.bankState?.id}',
          // 'city': '${city.name}-${city.id}',
          'city': data.bankCity,
          'address': data.bankAddress.text,
          'cur': data.currency?.cur,
          'accountType': data.accountType,
          'zipcode': data.bankZipcode.text,
          'swift': data.swift.text,
          if (data.country?.name?.toLowerCase() == 'russia')
            'cpf': data.cpf.text,
          if (data.country?.name?.toLowerCase() == 'argentina')
            'IDNumber': data.idType.text,
          "bankRoutingNo": data.routingNo.text,
        },
        headers: header,
      );
      debugPrint('add bank: ${response.body}');
      if (response.statusCode == 200) {
        alert(context: context, content: 'Bank added successfully');
        success = true;
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error adding this bank, please try again',
        );
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      alert(context: context, content: 'There was an error, please try again');
    }
    return success;
  }

  Future<List<NigBank>> getBanks(BuildContext context) async {
    BeneficiaryData beneficiaryData =
        Provider.of<BeneficiaryData>(context, listen: false);
    try {
      if (beneficiaryData.nigBanks.isEmpty) {
        http.Response response = await http.get(
          Uri.parse('${url}api/nigBanks'),
          headers: header,
        );
        debugPrint('get nigerian banks: ${response.body}');
        if (response.statusCode == 200) {
          List data = await jsonDecode(response.body)['content']['data'];
          beneficiaryData.nigBanks =
              data.map((e) => NigBank.fromMap(e)).toList();
        } else {
          alert(
            context: context,
            content:
                'There was an error getting the list of banks, please try again',
          );
        }
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      debugPrint(e.toString());
      // getBanks(context);
    }
    return beneficiaryData.nigBanks;
  }

  Future<bool> verifyBank({
    required BuildContext context,
    required Country country,
  }) async {
    bool success = false;
    BeneficiaryData beneficiaryData =
        Provider.of<BeneficiaryData>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('${url}api/bank-verify'),
        headers: header,
        body: {
          "country": country.abbr,
          "accountNo": beneficiaryData.accountNo.text,
          if (country.name?.toLowerCase() == 'nigeria')
            "bankCode": beneficiaryData.bank?.bankCode
        },
      );
      debugPrint('verify bank: ${response.body}');
      if (response.statusCode == 200) {
        success = true;
        if (country.name?.toLowerCase() != 'nigeria') {
          beneficiaryData.zipcode.text =
              jsonDecode(response.body)['content']['data']['zipcode'];
          beneficiaryData.bankName.text =
              jsonDecode(response.body)['content']['data']['bankName'];
          beneficiaryData.address.text =
              jsonDecode(response.body)['content']['data']['address'];
        }
        beneficiaryData.accountName.text =
            jsonDecode(response.body)['content']['data']['accountName'];
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error verifying this bank account, please check the account number and try again',
        );
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      alert(context: context, content: 'There was an error, please try again');
    }
    return success;
  }

  Future verifySwift(BuildContext context) async {
    BeneficiaryData beneficiaryData =
        Provider.of<BeneficiaryData>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('${url}api/swift-iban-verify'),
        headers: header,
        body: {
          "account": beneficiaryData.swift.text,
          "mode": 'SWIFT',
        },
      );
      if (response.statusCode == 200) {
        beneficiaryData.bankName.text =
            jsonDecode(response.body)['content']['data']['bankName'];
        beneficiaryData.address.text =
            jsonDecode(response.body)['content']['data']['address'];
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error with this verification, please try again',
        );
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
    } catch (e) {
      alert(context: context, content: 'There was an error, please try again');
    }
  }
}
