import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/statement.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:url_launcher/url_launcher.dart';

class StatementCard extends StatelessWidget {
  final Statement statement;

  const StatementCard({Key? key, required this.statement}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthData, WalletData>(
        builder: (context, authData, data, chi9ld) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffDADADA),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80,
        padding: const EdgeInsets.symmetric(
          horizontal: 23,
        ),
        width: double.infinity,
        child: Row(
          children: [
            Text(
              statement.month!,
              // DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
              //     .format(statement.createdAt!),
              style: const CustomTextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                await launchUrl(Uri.parse(
                    'https://blinqremit.io/dashboard/viewStatement/${base64.encode('${authData.user?.uid ?? ''}-${data.year}-${statement.month}-${data.fromCur ?? ''}'.codeUnits)}'));
              },
              child: const Text(
                'PDF',
                style: CustomTextStyle(
                  fontSize: 16,
                  color: CustomColors.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            InkWell(
              onTap: () async {
                await launchUrl(
                  Uri.parse(
                      'https://blinqremit.io/dashboard/excelStatement/${base64.encode('${authData.user?.uid ?? ''}-${data.year}-${statement.month}-${data.fromCur ?? ''}'.codeUnits)}'),
                );
              },
              child: const Text(
                'CSV',
                style: CustomTextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                  color: CustomColors.primary,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
