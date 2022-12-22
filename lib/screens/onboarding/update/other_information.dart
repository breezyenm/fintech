import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/vtn.dart';

class OtherInfo extends StatefulWidget {
  const OtherInfo({Key? key}) : super(key: key);

  @override
  State<OtherInfo> createState() => _OtherInfoState();
}

class _OtherInfoState extends State<OtherInfo> {
  String? address, dob, phone, firstName, lastName, gender, zipcode;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthData, VTNAPI, VTNData>(
        builder: (context, auth, vtn, vtnData, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: const [
              SizedBox(
                height: 48,
              ),
              Text(
                'Other Information',
                style: CustomTextStyle(
                  color: CustomColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.purpose,
            onChanged: (value) {
              firstName = value;
            },
            label: 'PURPOSE OF USING QWID',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.totalEmployees,
            onChanged: (value) {
              lastName = value;
            },
            label: 'TOTAL EMPLOYEES',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.businessScale,
            onChanged: (value) {
              firstName = value;
            },
            label: 'BUSINESS SCALE (OPTIONAL)',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.monthlyVolume,
            onChanged: (value) {
              lastName = value;
            },
            label: 'MONTHLY ESTIMATED VALUE',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.annualTurnover,
            onChanged: (value) {
              firstName = value;
            },
            label: 'ANNUAL TURNOVER',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.industrySector,
            onChanged: (value) {
              lastName = value;
            },
            label: 'INDUSTRY SECTOR (OPTIONAL)',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.paymentFlowDescription,
            onChanged: (value) {
              firstName = value;
            },
            label: 'PAYMENT FLOW DESCRIPTION',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.businessActivityDescription,
            onChanged: (value) {
              lastName = value;
            },
            label: 'BUSINESS ACTIVITY DESCRIPTION',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.countryOfOperation,
            onChanged: (value) {
              firstName = value;
            },
            label: 'COUNTRY OF OPERATION (Optional)',
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      );
    });
  }
}
