import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/dropdown_field.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/virtual_accounts.dart';
import 'package:qwid/popups/general/successful_popup.dart';
import 'package:qwid/providers/API/account.dart';
import 'package:qwid/providers/brain/account_provider.dart';
import 'package:qwid/providers/data/wallet.dart';

class SelectCurrency extends StatefulWidget {
  const SelectCurrency({Key? key}) : super(key: key);

  @override
  State<SelectCurrency> createState() => _SelectCurrencyState();
}

class _SelectCurrencyState extends State<SelectCurrency> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: AlertDialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        contentPadding: const EdgeInsets.all(24),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIcon(
                height: 120,
                icon: 'save',
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'SETUP VIRTUAL ACCOUNT',
                style: CustomTextStyle(
                  color: CustomColors.labelText,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Consumer3<AccountAPI, AccountProvider, WalletData>(
                  builder: (context, api, pro, walletData, child) {
                return FutureBuilder<List<VirtualAccounts>>(
                    future: api.getAllVirtualWallets(context),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.done &&
                              (snapshot.data ?? []).isEmpty
                          ? Text(
                              'You have setup all available virtual accounts',
                              style: CustomTextStyle(
                                color: CustomColors.text.withOpacity(0.5),
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : CustomDropdownField(
                              icon: snapshot.connectionState ==
                                      ConnectionState.done
                                  ? null
                                  : const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator.adaptive(
                                        strokeWidth: 1.2,
                                        valueColor: AlwaysStoppedAnimation(
                                            CustomColors.primary),
                                      ),
                                    ),
                              hint: 'Currency',
                              items: (snapshot.data ?? [])
                                  .map((e) => e.currency!)
                                  .toList(),
                              prefix: pro.wallet == null
                                  ? null
                                  : SizedBox(
                                      height: 24,
                                      width: 36,
                                      child: SvgPicture.network(
                                        pro.wallet!.flag!,
                                        width: 36,
                                        height: 24,
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              onChanged: (value) {
                                pro.virtualAccountToBeAdded =
                                    pro.virtualAccountsToBeAdded.firstWhere(
                                        (element) => element.currency == value);
                                pro.wallet = walletData.wallets.firstWhere(
                                    (element) =>
                                        element.cur?.toLowerCase() ==
                                        pro.virtualAccountToBeAdded?.cur
                                            ?.toLowerCase());
                              },
                              value: pro.virtualAccountToBeAdded?.currency,
                              focusNode: FocusNode(),
                            );
                    });
              }),
              const SizedBox(
                height: 24,
              ),
              Consumer2<AccountAPI, AccountProvider>(
                  builder: (context, api, pro, child) {
                return (pro.virtualAccountsToBeAdded).isEmpty
                    ? const SizedBox.shrink()
                    : CustomButton(
                        text: loading ? 'loading' : 'Request Account',
                        onPressed: () async {
                          if (key.currentState?.validate() ?? false) {
                            setState(() {
                              loading = true;
                            });
                            await api
                                .requestVirtualAccount(
                              context,
                              pro.virtualAccountToBeAdded!.cur!,
                            )
                                .then((value) {
                              setState(() {
                                loading = false;
                              });
                              if (value) {
                                Navigation.pop(context);
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => SuccessfulPopup(
                                    title: 'SETUP COMPLETE',
                                    subtitle: Text(
                                      'Virtual account requested successfully',
                                      style: CustomTextStyle(
                                        color:
                                            CustomColors.text.withOpacity(0.5),
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    context: context,
                                  ),
                                );
                              }
                            });
                          }
                        },
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
