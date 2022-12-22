import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qwid/assets/alert.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/models/currency.dart';
import 'package:qwid/models/purpose.dart';
import 'package:qwid/models/source.dart';
import 'package:qwid/models/state.dart';
import 'package:qwid/providers/data/vtn.dart';

class VTNAPI extends ChangeNotifier {
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
  Future<List<Country>> getCountries(BuildContext context) async {
    VTNData vtnData = Provider.of<VTNData>(context, listen: false);
    if (vtnData.countries.isEmpty) {
      try {
        http.Response response = await http.post(
          Uri.parse('${url}api/countryCur'),
          headers: header,
        );
        debugPrint('country: ${response.body}');
        List countries = jsonDecode(response.body);
        vtnData.countries = countries.map((e) {
          List currencies = e['CURR'];
          List<Currency> curr =
              currencies.map((e) => Currency().fromMap(e)).toList();

          return Country().fromMap(e, curr);
        }).toList();
      } on Exception {
        alert(
            context: context, content: 'Please check your network connection');
        // getCountries(context);
      } catch (e) {
        // debugPrint(e);
        // getCountries(context);
      }
    }
    return vtnData.countries;
  }

  Future<List<States>> getState(BuildContext context, String countryAbbr,
      {bool save = true}) async {
    List<States> states = [];
    VTNData vtnData = Provider.of<VTNData>(context, listen: false);
    if (!save || vtnData.states.isEmpty) {
      try {
        http.Response response = await http.post(
          Uri.parse('${url}api/vtn/listState'),
          headers: header,
          body: {
            'country': countryAbbr,
          },
        );
        debugPrint('state: ${response.body}');
        List _states = jsonDecode(response.body)['content']['data'] ?? [];
        if (save) {
          vtnData.states = _states.map((e) => States.fromMap(e)).toList();
        } else {
          states = _states.map((e) => States.fromMap(e)).toList();
        }
      } on Exception {
        alert(
            context: context, content: 'Please check your network connection');
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return save ? vtnData.states : states;
  }

  Future<List<String>> getCity(
      BuildContext context, String country, String state,
      {bool save = true}) async {
    List<String> cities = [];
    VTNData vtnData = Provider.of<VTNData>(context, listen: false);
    debugPrint(vtnData.cities.toString());
    if (!save || vtnData.cities.isEmpty) {
      try {
        http.Response response = await http.post(
          Uri.parse('${url}api/vtn/listCity'),
          headers: header,
          body: {
            'country': country,
            'state': state,
          },
        );
        debugPrint('city: ${response.body}');
        List _cities = jsonDecode(response.body)['content']['data'];
        if (save) {
          vtnData.cities = _cities.map((e) => e.toString()).toList();
        } else {
          cities = _cities.map((e) => e.toString()).toList();
        }
      } on Exception {
        alert(
            context: context, content: 'Please check your network connection');
      } catch (e) {
        // debugPrint(e);
      }
    }
    return save ? vtnData.cities : cities;
  }

  Future<List<Purpose>> getPurpose(
    BuildContext context,
  ) async {
    VTNData vtnData = Provider.of<VTNData>(context, listen: false);
    if (vtnData.purposes.isEmpty) {
      try {
        http.Response response = await http.get(
          Uri.parse('${url}api/vtn/remittancePurpose/CA'),
          headers: header,
        );
        debugPrint('purpose: ${response.body}');
        List purposes =
            jsonDecode(response.body)['content']['data']['RemittancePurposes'];
        vtnData.purposes = purposes.map((e) => Purpose.fromMap(e)).toList();
      } on Exception {
        alert(
            context: context, content: 'Please check your network connection');
      } catch (e) {
        // debugPrint(e);
      }
    }
    return vtnData.purposes;
  }

  Future<List<Source>> getSources(
    BuildContext context,
  ) async {
    VTNData vtnData = Provider.of<VTNData>(context, listen: false);
    if (vtnData.sources.isEmpty) {
      try {
        http.Response response = await http.get(
          Uri.parse('${url}api/vtn/fundSource'),
          headers: header,
        );
        debugPrint('source: ${response.body}');
        List sources =
            jsonDecode(response.body)['content']['data']['SourcesOfFunds'];
        vtnData.sources = sources.map((e) => Source.fromMap(e)).toList();
      } on Exception {
        alert(
            context: context, content: 'Please check your network connection');
      } catch (e) {
        // debugPrint(e);
      }
    }
    return vtnData.sources;
  }
}
