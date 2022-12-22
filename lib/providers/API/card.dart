import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qwid/assets/alert.dart';
import 'package:qwid/assets/confirm.dart';
import 'package:qwid/models/card_transaction.dart';
import 'package:qwid/models/virtual_card.dart';
import 'package:qwid/models/virtual_card_cur.dart';
import 'package:qwid/models/virtual_card_data.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/card.dart';

class CardAPI extends ChangeNotifier {
  var url = 'https://test-api.qwid.io/';
  var header = {
    "Authorization":
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODI5YTYwNGMyNTljZDZlODUxMDRlMTljMmQwZjEwMDg5YjhkNzkzZTE0YTg1YWE3M2E2NmYxNjhhN2Y4NzU5MDg1MDc2Y2JhNGI4MTVkOTMiLCJpYXQiOjE2NjQ5OTU3NjguOTA0NzY4LCJuYmYiOjE2NjQ5OTU3NjguOTA0NzcyLCJleHAiOjE2OTY1MzE3NjguODk5NzUsInN1YiI6IjIiLCJzY29wZXMiOltdfQ.AQMBLOQIa8ufn9K6nbyBanv8l6kTzz6pzoBBFdd4B_Osz-jRX-N6gxMvrk_roTPH0u-mHxErRdcWGWHoobR7C-DdkvpAGCAhaOhOiBqIXo6uSxDjHWdEoeEIvG3y_pppS5Ade01fSKnbu4BwFDkhyYCvYoAaHJt1VZzjcrTPwS9EyI4RMgKsz35G7mlwzFvO1lQs0pBR12AfL6-q5uhKnbr9IS1EA7BJGJ2JD6vjGIewA9d1qMOVCUeBpybTWC9yevV3qyRwQ8uK2fpieLmFqeqhDYSTPOjBUtCJ7Sfe0DT9OxTyixCsWvyhSJhyXH8TMcGdp4tPPru4sXpmGATWqOcoGkp2duK7pbf4UrMQmyQcU86O2VlAb729C8HNHdh7Ss9CdOWKmqpM5gUIhDhAtZ6D3IPJsYPekcVRySLS26dmwVaSbf8abpaDwzlY3Ku3Ph9VPT3h6Tb5N9Ks_8j98TCBM3ZIYUaZYTHhrqzInib-7vyN50GbXMRAN8HQWAIPqvztrnQDpFIIEyfs__KYPycNx8FfMPViSc0ZwgdsEIgvDjrNICCW_ClTzYORoWd1jW-pghzChroDigRGBbCs7Lqiyt7rp8KjwgldmCDVXeoC_K6PiytSklDZW42bzaxMa1lCkzAA5b52LhfhcpK345nZJ_YPwFqQ6MsGXodYVRU"
  };
  // var url = 'https://api.blinqremit.io/';
  // var header = {
  //   // 'api-key': 'j1NmarvxVFXz2tDNiM0k48b3OOrQ6kBK',
  //   "Authorization":
  //       "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNDhkOGFhYjRiZDQxNjZlM2Y1ZGEyODJjYjNmNDYzNDczZDhkZDM1M2E5MDZiNTJhY2U4MDhmYzMxY2IzMjNiZjk4ZTdjNzVlZWU0ZmY3YWIiLCJpYXQiOjE2NDYyNjEwMTEuMDE1MTU3LCJuYmYiOjE2NDYyNjEwMTEuMDE1MTYxLCJleHAiOjE2Nzc3OTcwMTEuMDA3MDg0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.mXOfJubTy3kKCo9dbbZfXKR83WNNPygyiC1xLA_txUqMBj8Uzmrn5LzBEsRi4EAIxkV2ptfano3xf2tf6427YVk0DhchVCSYWG-vujiiIzpVaGszDAxoaHXI4fXazfaoyKMR9Rt5aivAfn6ZYewfIB2x6tNIWJ5g7vyLCl9D0AYCX17Q5UJ5948uRDLuqirlpviRbGUf3HOmiFf4GwOiAhOWnzrWYfX9Tyn6qVlVfDZUM_UaxXIMSq8ad6xluT18peU_v2OblsaVGSBYQH9PnSorkCbeEsoXVkrEOtGjc9TclqbFfwf0s0ImLzA04Ac43dxyrzEiXWNa-FeMhZcVcSnhiM8jIPgmmaA0DxLARtVIhTocn1tfduo82IG4M2S7reXPFvaAcJP8yS4KXQ4lfZox7lWi3jRvbiygf-YFT42-VXOuGEMFfR6eYeqivNcdLzfEGLnvLIGuXws7Jm9gx18cDMHwWQV-zZB9lTckCERzItx764r8fbB3LJaRGAuBpwlLeTi4Bjj9w3CaSQqzP-5Z3XlZ6_HBuuWfZS9jxTh9KofbM2GCut0ZhSCzh5PEdZAFGqHRpIn2R7BqDbc3OX8z7lDfpVBqqBNETjurfM9LGBeaqxhjgavYDSbohl1ZVTR50-GOFEqDT9dbBe57we-7dUPCqfFlA7CBHysYQno"
  // };

  Future<List<VirtualCard>?> getVirtualCards(BuildContext context) async {
    List cards = [];
    CardData cardData = Provider.of<CardData>(context, listen: false);
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    try {
      http.Response response = await http.post(
          Uri.parse('${url}api/virtualCard/user'),
          headers: header,
          body: {
            'userId': authData.user?.uid.toString(),
          });
      debugPrint('cards: ${jsonDecode(response.body)['content']['data']}');
      if (response.statusCode == 200) {
        await listVirtualCards(context);
        cardData.cur = cardData.virtualCardCurs?.first.cur;
        cards = jsonDecode(response.body)['content']['data'] ?? [];
        cardData.virtualCards = cards.map((e) {
          Map<String, dynamic>? virtualCardData = e['virtualCardData'] == null
              ? null
              : jsonDecode(e['virtualCardData']);
          return VirtualCard.fromMap(
              details: e,
              virtualCardData: virtualCardData == null
                  ? null
                  : VirtualCardData.fromMap(
                      data: virtualCardData,
                    ));
        }).toList();
        if ((cardData.virtualCards
                    ?.where((element) => element.virtualCardData != null) ??
                [])
            .isNotEmpty) {
          cardData.virtualCard = cardData.virtualCards!
              .firstWhere((element) => element.virtualCardData != null);
        }
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error getting your virtual cards, please try again',
        );
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
      // getCountries(context);
    } catch (e) {
      debugPrint(e.toString());
      // getCountries(context);
    }

    return cardData.virtualCards;
  }

  Future<List<CardTransaction>?> getVirtualCardTransactions(
      BuildContext context, String virtualCardId) async {
    List transactions = [];
    CardData cardData = Provider.of<CardData>(context, listen: false);
    try {
      http.Response response = await http.post(
          Uri.parse('${url}api/virtualCard/retrieve'),
          headers: header,
          body: {
            'virtualCardId': virtualCardId,
          });
      debugPrint(
          'transactions: ${jsonDecode(response.body)['content']['data']['transaction']}');
      if (response.statusCode == 200) {
        transactions =
            jsonDecode(response.body)['content']['data']['transaction'] ?? [];
        cardData.transactions = transactions.map((e) {
          return CardTransaction.fromMap(e);
        }).toList();
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error getting your virtual cards, please try again',
        );
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
      // getCountries(context);
    } catch (e) {
      debugPrint(e.toString());
      // getCountries(context);
    }

    return cardData.transactions;
  }

  Future<List<VirtualCard>?> getVirtualCardsWithCur(
      BuildContext context, String cur) async {
    List cards = [];
    CardData cardData = Provider.of<CardData>(context, listen: false);
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    try {
      http.Response response = await http.post(
          Uri.parse('${url}api/virtualCard/user-currency'),
          headers: header,
          body: {
            'userId': authData.user?.uid.toString(),
            'cur': cur,
          });
      debugPrint('cards: ${jsonDecode(response.body)['content']['data']}');
      if (response.statusCode == 200) {
        cards = jsonDecode(response.body)['content']['data'] ?? [];
        cardData.virtualCards = cards.map((e) {
          Map<String, dynamic>? virtualCardData =
              jsonDecode(e['virtualCardData']);
          return VirtualCard.fromMap(
              details: e,
              virtualCardData: VirtualCardData.fromMap(
                data: virtualCardData,
              ));
        }).toList();
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error getting your virtual cards, please try again',
        );
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
      // getCountries(context);
    } catch (e) {
      debugPrint(e.toString());
      // getCountries(context);
    }

    return cardData.virtualCards;
  }

  Future<List<VirtualCardCur>?> listVirtualCards(BuildContext context) async {
    List cards = [];
    CardData cardData = Provider.of<CardData>(context, listen: false);
    try {
      http.Response response = await http.get(
        Uri.parse('${url}api/virtualCard/currency'),
        headers: header,
      );
      debugPrint('cards: ${response.statusCode}');
      debugPrint('cards: ${response.body}');
      debugPrint('cards: ${jsonDecode(response.body)['content']['data']}');
      if (response.statusCode < 300) {
        cards = jsonDecode(response.body)['content']['data'] ?? [];
        cardData.virtualCardCurs = cards
            .map((e) => VirtualCardCur.fromMap(
                  data: e,
                ))
            .toList();
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error getting your virtual cards, please try again',
        );
      }
    } on Exception {
      alert(context: context, content: 'Please check your network connection');
      // getCountries(context);
    } catch (e) {
      debugPrint(e.toString());
      // getCountries(context);
    }

    return cardData.virtualCardCurs;
  }

  Future<bool> createVirtualCard(
    BuildContext context,
  ) async {
    CardData cardData = Provider.of<CardData>(context, listen: false);
    bool yes = await confirm(
      context: context,
      content:
          'This will cost ${double.parse(cardData.virtualCardCur!.amount!) + double.parse(cardData.virtualCardCur!.fee!)} ${cardData.virtualCardCur?.cur}, do you want to continue?',
    );
    bool success = false;
    if (yes) {
      AuthData authData = Provider.of<AuthData>(context, listen: false);
      CardData data = Provider.of<CardData>(context, listen: false);
      try {
        http.Response response = await http.post(
            Uri.parse('${url}api/virtualCard/create'),
            headers: header,
            body: {
              'userId': authData.user?.uid.toString(),
              'cur': data.virtualCardCur?.cur,
              'virtualCardColor': data.color,
            });
        debugPrint('card: ${response.body}');
        if (response.statusCode == 200) {
          await alert(
            context: context,
            content: 'Virtual card created successfully',
          );
          success = true;
        } else {
          alert(
            context: context,
            content: jsonDecode(response.body)['message'] ??
                'There was an error creating your virtual cards, please try again',
          );
        }
        // List cards = jsonDecode(response.body);
        // cardData.virtualCards = cards.map((e) => VirtualCard.fromMap(details: e)
        // ).toList();
      } on Exception {
        alert(
          context: context,
          content: 'Please check your network connection',
        );
        // getCountries(context);
      } catch (e) {
        debugPrint(e.toString());
        // getCountries(context);
      }
    }

    return success;
  }

  Future<bool> fundVirtualCard(
    BuildContext context,
    String amount,
    String cardID,
    String cur,
  ) async {
    bool yes = await confirm(
      context: context,
      content: 'This will cost $amount $cur, do you want to continue?',
    );
    bool success = false;
    if (yes) {
      try {
        http.Response response = await http.post(
            Uri.parse('${url}api/virtualCard/topup'),
            headers: header,
            body: {
              'virtualCardId': cardID,
              'amount': amount,
            });
        debugPrint('card: ${response.body}');
        if (response.statusCode == 200) {
          success = true;
          alert(
            context: context,
            content: 'Virtual Card funded successfully',
          );
        } else {
          alert(
            context: context,
            content: jsonDecode(response.body)['message'] ??
                'There was an error creating your virtual cards, please try again',
          );
        }
        // List cards = jsonDecode(response.body);
        // cardData.virtualCards = cards.map((e) => VirtualCard.fromMap(details: e)
        // ).toList();
      } on Exception {
        alert(
          context: context,
          content: 'Please check your network connection',
        );
        // getCountries(context);
      } catch (e) {
        debugPrint(e.toString());
        // getCountries(context);
      }
    }

    return success;
  }

  Future<bool> toggleActivation(
    BuildContext context,
    String mode,
  ) async {
    CardData data = Provider.of<CardData>(context, listen: false);
    bool success = false;
    try {
      http.Response response = await http.put(
          Uri.parse('${url}api/virtualCard/freeze-and-activate'),
          headers: header,
          body: {
            'virtualCardId': data.virtualCard?.virtualCardId,
            'mode': mode,
            if (mode == 'freeze')
              'status': !data.virtualCard!.virtualCardFreeze! ? '2' : '1',
            if (mode == 'activate')
              'status': data.virtualCard?.virtualCardStatus == 1 ? '2' : '1',
          });
      debugPrint('freeze card: ${response.body}');
      if (response.statusCode == 200) {
        success = true;
        // int index = data.virtualCards?.indexWhere((element) =>
        //         element.virtualCardId == data.virtualCard?.virtualCardId) ??
        //     0;
        // data.virtualCards
        //     // ?.where((element) => element.virtualCardData != null)
        //     // .toList()
        //     ?.replaceRange(index, index + 1, [
        //   VirtualCard.fromMap(
        //       details: jsonDecode(response.body)['content']['data'])
        // ]);
        // // data.virtualCards?.where((element) =>
        // //         element.virtualCardId == data.virtualCard?.virtualCardId) ??
        // //     []);
        // // data.virtualCards?.insert(
        // //     index,
        // //     VirtualCard.fromMap(
        // //         details: jsonDecode(response.body)['content']['data']));
        // data.virtualCard = data.virtualCards?[index];
        alert(
          context: context,
          content: jsonDecode(response.body)['message'],
        );
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error, please try again',
        );
      }
      // List cards = jsonDecode(response.body);
      // cardData.virtualCards = cards.map((e) => VirtualCard.fromMap(details: e)
      // ).toList();
    } on Exception {
      alert(
        context: context,
        content: 'Please check your network connection',
      );
      // getCountries(context);
    } catch (e) {
      debugPrint(e.toString());
      // getCountries(context);

    }

    return success;
  }
}
