import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/dropdown/labelled_dropdown.dart';
import 'package:qwid/bottom_sheets/general_sheet.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/data/wallet.dart';

class DownloadTrans extends GeneralSheet {
  DownloadTrans(
      {Key? key, required BuildContext context, Function()? onPressed})
      : super(
          key: key,
          subtitle: 'Select currency and year',
          title: 'Download statement',
          buttonText: 'Download',
          body: [
            Consumer2<WalletData, WalletAPI>(
              builder: (context, data, api, chi9ld) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LabelledDropdown(
                        hint: 'Select currency',
                        label: 'CURRENCY',
                        items: data.wallets
                            .map((e) => e.cur!.toUpperCase())
                            .toList(),
                        onChanged: (value) {
                          data.fromCur = value;
                          data.wallet = data.wallets
                              .firstWhere((element) => element.cur == value);
                        },
                        value: data.wallet?.cur,
                        //   prefix: CircleAvatar(
                        //   radius: 12,
                        //   backgroundColor: CustomColors.stroke,
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(12),
                        //     child: SvgPicture.network(
                        //       e.flag,
                        //       width: 24,
                        //       height: 24,
                        //       alignment: Alignment.center,
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      LabelledDropdown(
                        hint: 'Select year',
                        label: 'YEAR',
                        items: [
                          '2022',
                          if (DateTime.now().year > 2022)
                            ...List.generate(
                              DateTime.now().year - 2022,
                              (index) => (2022 + index + 1).toString(),
                            ),
                        ],
                        onChanged: (value) {
                          data.year = value;
                        },
                        value: data.year,
                        //   prefix: CircleAvatar(
                        //   radius: 12,
                        //   backgroundColor: CustomColors.stroke,
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(12),
                        //     child: SvgPicture.network(
                        //       e.flag,
                        //       width: 24,
                        //       height: 24,
                        //       alignment: Alignment.center,
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          onPressed: onPressed,
        );
}
