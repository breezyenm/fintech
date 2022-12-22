import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qwid/assets/alert.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/models/state.dart';
import 'package:qwid/models/user.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/settings.dart';
import 'package:qwid/providers/data/vtn.dart';

class ProfileAPI extends ChangeNotifier {
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
  Future<bool> update(
    BuildContext context,
  ) async {
    bool success = false;
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    VTNData vtnData = Provider.of<VTNData>(context, listen: false);
    try {
      http.Response? response = await http.patch(
        Uri.parse('${url}api/endUsers/profile/${authData.user!.uid}'),
        body: {
          if ((authData.firstName.text).isNotEmpty)
            "firstName": authData.firstName.text,
          if ((authData.lastName.text).isNotEmpty)
            "lastName": authData.lastName.text,
          if ((authData.dob.text).isNotEmpty) "dob": authData.dob.text,
          if ((authData.gender)?.isNotEmpty ?? false) "sex": authData.gender,
          if ((authData.address.text).isNotEmpty)
            "address": authData.address.text,
          if ((vtnData.city)?.isNotEmpty ?? false) "city": vtnData.city,
          if ((vtnData.state?.name)?.isNotEmpty ?? false)
            "state": vtnData.state?.name,
          if ((vtnData.country?.abbr)?.isNotEmpty ?? false)
            "countryCode": vtnData.country?.abbr,
          if ((authData.zipcode.text).isNotEmpty)
            "zipcode": authData.zipcode.text,
          if ((vtnData.country?.name)?.isNotEmpty ?? false)
            "country": vtnData.country?.name,
          if ((authData.phone.text).isNotEmpty) "mobile": authData.phone.text,
          if ((authData.user?.userType?.toString() ?? '').isNotEmpty)
            "userType": authData.user?.userType?.toString() ?? '',
          if ((authData.companyName.text).isNotEmpty)
            "companyName": authData.companyName.text,
          if ((authData.tradingName.text).isNotEmpty)
            "tradingName": authData.tradingName.text,
          if ((authData.businessCategory)?.isNotEmpty ?? false)
            "businessCategory": authData.businessCategory,
          if ((authData.website.text).isNotEmpty)
            "website": authData.website.text,
          if ((authData.businessRegistrationNumber.text).isNotEmpty)
            "businessRegistrationNumber":
                authData.businessRegistrationNumber.text,
          if ((authData.businessRegisteredDate.text).isNotEmpty)
            "businessRegisteredDate": authData.businessRegisteredDate.text,
          if ((authData.businessRegisteredCountry) != null)
            "businessRegisteredCountry":
                authData.businessRegisteredCountry?.name,
          if ((authData.businessAddress.text).isNotEmpty)
            "businessAddress": authData.businessAddress.text,
          if ((authData.businessState) != null)
            "businessState": authData.businessState?.name,
          if ((authData.businessCity)?.isNotEmpty ?? false)
            "businessCity": authData.businessCity,
          if ((authData.businessZipcode.text).isNotEmpty)
            "businessZipcode": authData.businessZipcode.text,
          if ((authData.businessCountry) != null)
            "businessCountry": authData.businessCountry?.name,
          if ((authData.businessMobileCode.text).isNotEmpty)
            "businessMobileCode": authData.businessMobileCode.text,
          if ((authData.businessMobile.text).isNotEmpty)
            "businessMobile": authData.businessMobile.text,
          if ((authData.stakeholder1LastName.text).isNotEmpty)
            "stakeholder1LastName": authData.stakeholder1LastName.text,
          if ((authData.stakeholder1FirstName.text).isNotEmpty)
            "stakeholder1FirstName": authData.stakeholder1FirstName.text,
          if ((authData.stakeholder1Email.text).isNotEmpty)
            "stakeholder1Email": authData.stakeholder1Email.text,
          if ((authData.stakeholder1Designation.text).isNotEmpty)
            "stakeholder1Designation": authData.stakeholder1Designation.text,
          if ((authData.stakeholder1ShareVolume.text).isNotEmpty)
            "stakeholder1ShareVolume": authData.stakeholder1ShareVolume.text,
          if ((authData.stakeholder1Address.text).isNotEmpty)
            "stakeholder1Address": authData.stakeholder1Address.text,
          if ((authData.stakeholder1DOB.text).isNotEmpty)
            "stakeholder1DOB": authData.stakeholder1DOB.text,
          if ((authData.stakeholder1Nationality) != null)
            "stakeholder1Nationality": authData.stakeholder1Nationality?.name,
          if ((authData.stakeholder1MobileCode.text).isNotEmpty)
            "stakeholder1MobileCode": authData.stakeholder1MobileCode.text,
          if ((authData.stakeholder1City)?.isNotEmpty ?? false)
            "stakeholder1City": authData.stakeholder1City,
          if ((authData.stakeholder1State) != null)
            "stakeholder1State": authData.stakeholder1State?.name,
          if ((authData.stakeholder1Zipcode.text).isNotEmpty)
            "stakeholder1Zipcode": authData.stakeholder1Zipcode.text,
          if ((authData.stakeholder1TaxCountry) != null)
            "stakeholder1TaxCountry": authData.stakeholder1TaxCountry?.name,
          if ((authData.stakeholder1TaxNumber.text).isNotEmpty)
            "stakeholder1TaxNumber": authData.stakeholder1TaxNumber.text,
          if ((authData.stakeholder1PostStartDate.text).isNotEmpty)
            "stakeholder1PostStartDate":
                authData.stakeholder1PostStartDate.text,
          if ((authData.stakeholder1PostEndDate.text).isNotEmpty)
            "stakeholder1PostEndDate": authData.stakeholder1PostEndDate.text,
          if ((authData.stakeholder1AddtionalInfo.text).isNotEmpty)
            "stakeholder1AddtionalInfo":
                authData.stakeholder1AddtionalInfo.text,
          if ((authData.stakeholder1IsPep)?.isNotEmpty ?? false)
            "stakeholder1IsPep": authData.stakeholder1IsPep,
          if ((authData.otherBusinessLicenceNumberPresent.text).isNotEmpty)
            "otherBusinessLicenceNumberPresent":
                authData.otherBusinessLicenceNumberPresent.text,
          if ((authData.otherBusinessLicenceNumber.text).isNotEmpty)
            "otherBusinessLicenceNumber":
                authData.otherBusinessLicenceNumber.text,
          if ((authData.totalEmployees.text).isNotEmpty)
            "totalEmployees": authData.totalEmployees.text,
          if ((authData.businessScale.text).isNotEmpty)
            "businessScale": authData.businessScale.text,
          if ((authData.annualTurnover.text).isNotEmpty)
            "annualTurnover": authData.annualTurnover.text,
          if ((authData.industrySector.text).isNotEmpty)
            "industrySector": authData.industrySector.text,
          if ((authData.countryOfOperation.text).isNotEmpty)
            "countryOfOperation": authData.countryOfOperation.text,
          if ((authData.reason.text).isNotEmpty) "reason": authData.reason.text,
          if ((authData.paymentFlowDescription.text).isNotEmpty)
            "paymentFlowDescription": authData.paymentFlowDescription.text,
          if ((authData.monthlyVolume.text).isNotEmpty)
            "monthlyVolume": authData.monthlyVolume.text,
          if ((authData.additionalInfo.text).isNotEmpty)
            "additionalInfo": authData.additionalInfo.text,
          if ((authData.businessActivityDescription.text).isNotEmpty)
            "businessActivityDescription":
                authData.businessActivityDescription.text,
          if ((authData.businessApplicantPosition.text).isNotEmpty)
            "businessApplicantPosition":
                authData.businessApplicantPosition.text,
          if ((authData.businessApplicantPositionStartDate.text).isNotEmpty)
            "businessApplicantPositionStartDate":
                authData.businessApplicantPositionStartDate.text,
          if ((authData.businessApplicantPositionEndDate.text).isNotEmpty)
            "businessApplicantPositionEndDate":
                authData.businessApplicantPositionEndDate.text,
          // if ((authData.businessApplicantDocumentExtension.text).isNotEmpty)
          // "businessApplicantDocumentExtension":
          //     authData.businessApplicantDocumentExtension.text,
          if ((authData.businessApplicantDocument.text).isNotEmpty)
            "businessApplicantDocument":
                authData.businessApplicantDocument.text,
          if ((authData.businessApplicantDocumentType)?.isNotEmpty ?? false)
            "businessApplicantDocumentType":
                authData.businessApplicantDocumentType,
          if ((authData.businessApplicantDocumentNumber.text).isNotEmpty)
            "businessApplicantDocumentNumber":
                authData.businessApplicantDocumentNumber.text,
          if ((authData.businessApplicantDocumentIssueCountry) != null)
            "businessApplicantDocumentIssueCountry":
                authData.businessApplicantDocumentIssueCountry?.name,
          if ((authData.businessApplicantDocumentHolderName.text).isNotEmpty)
            "businessApplicantDocumentHolderName":
                authData.businessApplicantDocumentHolderName.text,
          if ((authData.businessApplicantDocumentExpiryDate.text).isNotEmpty)
            "businessApplicantDocumentExpiryDate":
                authData.businessApplicantDocumentExpiryDate.text,
          if ((authData.businessApplicantDocumentIssuedDate.text).isNotEmpty)
            "businessApplicantDocumentIssuedDate":
                authData.businessApplicantDocumentIssuedDate.text,
          if ((authData.businessApplicantAdditionalInfo.text).isNotEmpty)
            "businessApplicantAdditionalInfo":
                authData.businessApplicantAdditionalInfo.text,
          if ((authData.businessApplicantisPep)?.isNotEmpty ?? false)
            "businessApplicantisPep": authData.businessApplicantisPep,
          if ((authData.businessApplicantbusinessExtractCoveredStakeholder.text)
              .isNotEmpty)
            "businessApplicantbusinessExtractCoveredStakeholder": authData
                .businessApplicantbusinessExtractCoveredStakeholder.text,
          if ((authData.businessProductDetails.text).isNotEmpty)
            "businessProductDetails": authData.businessProductDetails.text,
          if ((authData.businessProductType.text).isNotEmpty)
            "businessProductType": authData.businessProductType.text,
          if ((authData.businessProgram)?.isNotEmpty ?? false)
            "businessProgram": authData.businessProgram,
        },
        headers: header,
      );
      debugPrint('update: ${response.body}');
      if (response.statusCode == 200) {
        success = true;
        await alert(
          context: context,
          content: jsonDecode(response.body)['message'],
        );
        authData.user = User.fromMap(
          userMap: jsonDecode(response.body)['content']['data'][0],
          token: authData.user!.token!,
        );
      } else {
        alert(
          context: context,
          content: jsonDecode(response.body)['message'],
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

  Future<bool> updateProfile(
    File? image,
    Country? country,
    States? state,
    String city,
    String address,
    String dob,
    String zipcode,
    String phone,
    String firstName,
    String lastName,
    String gender,
    BuildContext context,
  ) async {
    bool success = false;
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    try {
      if (image != null) {
        String? pix = base64Encode(await image.readAsBytes());
        // pix = 'data:image/jpg;base64,' + pix;
        http.Response response = await http.patch(
          Uri.parse('${url}api/endUsers/pix/${authData.user!.uid}'),
          body: {
            "pix": pix,
            'extension': image.path.split('.').last,
          },
          headers: header,
        );
        if (response.statusCode == 200) {
          authData.user = User.fromMap(
            userMap: jsonDecode(response.body)['content']['data'][0],
            token: authData.user!.token!,
          );
          if (address.isEmpty &&
              dob.isEmpty &&
              city.isEmpty &&
              zipcode.isEmpty &&
              phone.isEmpty &&
              firstName.isEmpty &&
              lastName.isEmpty &&
              gender.isEmpty &&
              country == null &&
              state == null) {
            await alert(
              context: context,
              content: 'Profile picture updated successfully',
            );
          }
          success = true;
          if (address.isNotEmpty ||
              dob.isNotEmpty ||
              city.isNotEmpty ||
              zipcode.isNotEmpty ||
              phone.isNotEmpty ||
              firstName.isNotEmpty ||
              lastName.isNotEmpty ||
              gender.isNotEmpty ||
              country != null ||
              state != null) {
            success = await update(
              context,
            );
          }
        }
      } else if (address.isNotEmpty ||
          dob.isNotEmpty ||
          city.isNotEmpty ||
          zipcode.isNotEmpty ||
          phone.isNotEmpty ||
          firstName.isNotEmpty ||
          lastName.isNotEmpty ||
          gender.isNotEmpty ||
          country != null ||
          state != null) {
        success = await update(
          context,
        );
      } else {
        await alert(
          context: context,
          content: 'No changes were made',
        );
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
    return success;
  }

  Future<bool> updatePassword(BuildContext context) async {
    bool success = false;
    AuthData authData = Provider.of<AuthData>(context, listen: false);
    SettingsData settingsData =
        Provider.of<SettingsData>(context, listen: false);
    try {
      http.Response response = await http.patch(
        Uri.parse('${url}api/endUsers/password/${authData.user!.uid}'),
        body: {
          "old": settingsData.currentPassword.text,
          "new": settingsData.newPassword.text,
          "new_confirmation": settingsData.confirmPassword.text,
        },
        headers: header,
      );
      if (response.statusCode == 200) {
        await alert(
          context: context,
          content: jsonDecode(response.body)['message'],
        );
        success = true;
      } else {
        await alert(
          context: context,
          content: jsonDecode(response.body)['message'] ??
              'There was an error changing your password, try again',
        );
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
    return success;
  }
}
