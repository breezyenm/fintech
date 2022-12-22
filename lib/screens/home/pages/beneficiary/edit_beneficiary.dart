import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/labelled_dropdown.dart';
import 'package:qwid/assets/dropdown/search_dropdown.dart';
import 'package:qwid/assets/dropdown/search_list.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/models/beneficiary.dart';
import 'package:qwid/models/nig_bank.dart';
import 'package:qwid/models/state.dart';
import 'package:qwid/providers/API/beneficiary.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/data/beneficiary.dart';
import 'package:qwid/providers/data/vtn.dart';

class EditBeneficiary extends StatefulWidget {
  final Beneficiary? beneficiary;
  const EditBeneficiary({Key? key, this.beneficiary}) : super(key: key);

  @override
  State<EditBeneficiary> createState() => _EditBeneficiaryState();
}

class _EditBeneficiaryState extends State<EditBeneficiary> {
  bool loading = false;
  @override
  void initState() {
    Provider.of<BeneficiaryData>(context, listen: false).formKey =
        GlobalKey<FormState>();
    Provider.of<BeneficiaryData>(context, listen: false).clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<BeneficiaryData, BeneficiaryAPI, VTNAPI, VTNData>(
        builder: (context, data, api, vtn, vtnData, chi9ld) {
      return Form(
        key: data.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personal information',
                    style: CustomTextStyle(
                      color: CustomColors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Fill the form below to continue',
                    style: CustomTextStyle(
                      color: CustomColors.black.withOpacity(0.5),
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: CustomColors.white,
                border: Border.all(
                  color: CustomColors.stroke,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelledDropdown(
                    hint: widget.beneficiary?.beneficiaryType == null
                        ? 'Select Beneficiary Type'
                        : data.beneficiaryTypes.entries
                            .firstWhere((element) =>
                                element.value ==
                                widget.beneficiary?.beneficiaryType?.toString())
                            .key,
                    items: data.beneficiaryTypes.keys.toList(),
                    onChanged: (value) {
                      data.beneficiaryType = data.beneficiaryTypes[value];
                    },
                    label: 'BENEFICIARY TYPE',
                    value: data.beneficiaryType == null
                        ? null
                        : data.beneficiaryTypes.entries
                            .firstWhere((element) =>
                                element.value == data.beneficiaryType)
                            .key,
                  ),
                  if (data.beneficiaryType == '2')
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.beneficiaryType == '2')
                    LabelledTextField(
                      controller: data.email,
                      hint: widget.beneficiary?.beneficiaryEmail,
                      label: 'EMAIL ADDRESS',
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder(
                    future: vtnData.countries.isNotEmpty
                        ? null
                        : vtn.getCountries(context),
                    builder: (context, snapshot) {
                      // if (beneficiary != null && vtnData.countries.isNotEmpty) {
                      //   data.country = vtnData.countries.firstWhere(
                      //     (element) => element.abbr == beneficiary?.country,
                      //   );
                      // }
                      return InkWell(
                        onTap: () async {
                          if (vtnData.countries.isNotEmpty) {
                            data.city = null;
                            data.state = null;
                            vtnData.cities = [];
                            vtnData.states = [];
                            String country = await Navigation.push(
                              SearchList(
                                leading: vtnData.countries
                                    .map((e) => e.abbr?.toLowerCase() ?? '')
                                    .toList(),
                                items: vtnData.countries
                                    .map((e) => e.name ?? '')
                                    .toList(),
                              ),
                              context,
                            );
                            data.country = vtnData.countries.firstWhere(
                                (element) => element.name == country);
                          } else {
                            setState(() {});
                          }
                        },
                        child: SearchDropdown(
                          icon: snapshot.connectionState ==
                                      ConnectionState.done ||
                                  vtnData.countries.isNotEmpty
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
                          label: 'COUNTRY',
                          hint: 'Select Country',
                          leading: data.country?.abbr?.toLowerCase(),
                          text: data.country?.name,
                        ),
                      );
                      //                 LabelledDropdown(
                      //   icon:
                      //       snapshot.connectionState == ConnectionState.done ||
                      //               vtnData.countries.isNotEmpty
                      //           ? null
                      //           : const SizedBox(
                      //               height: 24,
                      //               width: 24,
                      //               child: CircularProgressIndicator.adaptive(
                      //                 strokeWidth: 1.2,
                      //                 valueColor: AlwaysStoppedAnimation(
                      //                     CustomColors.primary),
                      //               ),
                      //             ),
                      //   hint: widget.beneficiary?.beneficiaryCountry == null
                      //       ? 'Select Country'
                      //       : vtnData.countries
                      //           .firstWhere((element) =>
                      //               element.abbr ==
                      //               widget.beneficiary?.beneficiaryCountry)
                      //           .name!,
                      //   items:
                      //       vtnData.countries.map((e) => e.name ?? '').toList(),
                      //   onChanged: (value) {
                      //     data.city = null;
                      //     data.state = null;
                      //     vtnData.cities = [];
                      //     vtnData.states = [];
                      //     data.country = vtnData.countries
                      //         .firstWhere((element) => element.name == value);
                      //   },
                      //   label: 'COUNTRY',
                      //   value: data.country?.name,
                      // );
                    },
                  ),
                  if (data.country != null)
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.country != null)
                    FutureBuilder(
                        future: vtnData.states.isNotEmpty
                            ? null
                            : vtn.getState(
                                context,
                                data.country!.abbr!,
                              ),
                        builder: (context, snapshot) {
                          return LabelledDropdown(
                            icon: snapshot.connectionState ==
                                        ConnectionState.done ||
                                    data.country == null ||
                                    vtnData.states.isNotEmpty
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
                            hint: widget.beneficiary?.state ?? 'Select State',
                            items: vtnData.states.map((e) => e.name!).toList(),
                            onChanged: (value) {
                              data.city = null;
                              vtnData.cities = [];
                              data.state = vtnData.states.firstWhere(
                                  (element) => element.name == value);
                            },
                            label: 'STATE',
                            value: data.state?.name,
                          );
                        }),
                  if (data.country != null && data.state != null)
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.country != null && data.state != null)
                    FutureBuilder<List<String>>(
                        future: vtnData.cities.isNotEmpty
                            ? null
                            : vtn.getCity(context, data.country!.name!,
                                data.state!.name!),
                        builder: (context, snapshot) {
                          return LabelledDropdown(
                            icon: (snapshot.connectionState ==
                                        ConnectionState.done ||
                                    data.country == null ||
                                    data.state == null ||
                                    vtnData.cities.isNotEmpty)
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
                            hint: widget.beneficiary?.city ?? 'Select City',
                            items: vtnData.cities,
                            onChanged: (value) {
                              data.city = value;
                            },
                            label: 'CITY',
                            value: data.city,
                          );
                        }),
                  if (data.country != null &&
                      data.state != null &&
                      data.city != null)
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.country != null &&
                      data.state != null &&
                      data.city != null)
                    LabelledTextField(
                      controller: data.address,
                      hint: widget.beneficiary?.address,
                      label: 'ADDRESS',
                      minLines: 3,
                    ),
                  if (data.country != null &&
                      data.state != null &&
                      data.city != null)
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.country != null &&
                      data.state != null &&
                      data.city != null)
                    LabelledTextField(
                      controller: data.zipcode,
                      hint: widget.beneficiary?.zipcode,
                      label: 'ZIPCODE',
                    ),
                  if (data.country != null &&
                      data.state != null &&
                      data.city != null)
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.country != null &&
                      data.state != null &&
                      data.city != null)
                    LabelledTextField(
                      type: TextInputType.number,
                      controller: data.mobile,
                      hint: widget.beneficiary?.mobile,
                      label: 'MOBILE NUMBER',
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bank information',
                    style: CustomTextStyle(
                      color: CustomColors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Fill the form below to continue',
                    style: CustomTextStyle(
                      color: CustomColors.black.withOpacity(0.5),
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: CustomColors.white,
                border: Border.all(
                  color: CustomColors.stroke,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: vtnData.countries.isNotEmpty
                        ? null
                        : vtn.getCountries(context),
                    builder: (context, snapshot) {
                      // if (beneficiary != null && vtnData.countries.isNotEmpty) {
                      //   data.country = vtnData.countries.firstWhere(
                      //     (element) => element.abbr == beneficiary?.country,
                      //   );
                      // }
                      return InkWell(
                        onTap: () async {
                          if (vtnData.countries.isNotEmpty) {
                            setState(() {
                              data.cities = [];
                              data.states = [];
                            });
                            data.bankCity = null;
                            data.bankState = null;
                            String country = await Navigation.push(
                              SearchList(
                                leading: vtnData.countries
                                    .map((e) => e.abbr?.toLowerCase() ?? '')
                                    .toList(),
                                items: vtnData.countries
                                    .map((e) => e.name ?? '')
                                    .toList(),
                              ),
                              context,
                            );
                            data.bankCountry = vtnData.countries.firstWhere(
                                (element) => element.name == country);
                          } else {
                            setState(() {});
                          }
                        },
                        child: SearchDropdown(
                          leading: data.bankCountry?.abbr?.toLowerCase(),
                          icon: snapshot.connectionState ==
                                      ConnectionState.done ||
                                  vtnData.countries.isNotEmpty
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
                          hint: 'Select Country',
                          label: 'BANK COUNTRY',
                          text: data.bankCountry?.name,
                        ),
                      );
                      // LabelledDropdown(
                      //   hint: widget.beneficiary?.country == null
                      //       ? 'Select Country'
                      //       : vtnData.countries
                      //           .firstWhere((element) =>
                      //               element.abbr == widget.beneficiary?.country)
                      //           .name!,
                      //   items:
                      //       vtnData.countries.map((e) => e.name ?? '').toList(),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       data.cities = [];
                      //       data.states = [];
                      //     });
                      //     data.bankCity = null;
                      //     data.bankState = null;
                      //     data.bankCountry = vtnData.countries
                      //         .firstWhere((element) => element.name == value);
                      //   },
                      //   label: 'BANK COUNTRY',
                      //   value: data.bankCountry?.name,
                      // );
                    },
                  ),
                  if (data.bankCountry != null)
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.bankCountry != null)
                    FutureBuilder<List<States>>(
                        future: data.states.isNotEmpty
                            ? null
                            : vtn.getState(context, data.bankCountry!.abbr!,
                                save: false),
                        builder: (context, snapshot) {
                          if (data.states.isEmpty) {
                            data.states = snapshot.data ?? [];
                          }
                          return LabelledDropdown(
                            icon: snapshot.connectionState ==
                                        ConnectionState.done ||
                                    data.states.isNotEmpty
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
                            hint:
                                widget.beneficiary?.bankState ?? 'Select State',
                            items: data.states.map((e) => e.name!).toList(),
                            onChanged: (value) {
                              setState(() {
                                data.cities = [];
                              });
                              data.bankCity = null;
                              data.bankState = data.states.firstWhere(
                                  (element) => element.name == value);
                            },
                            label: 'BANK STATE',
                            value: data.bankState?.name,
                          );
                        }),
                  if (data.bankCountry != null && data.bankState != null)
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.bankCountry != null && data.bankState != null)
                    FutureBuilder<List<String>>(
                        future: data.cities.isNotEmpty
                            ? null
                            : vtn.getCity(context, data.bankCountry!.name!,
                                data.bankState!.name!,
                                save: false),
                        builder: (context, snapshot) {
                          if (data.cities.isEmpty) {
                            data.cities = snapshot.data ?? [];
                          }
                          return LabelledDropdown(
                            icon: (snapshot.connectionState ==
                                        ConnectionState.done ||
                                    data.bankCountry == null ||
                                    data.bankState == null ||
                                    data.cities.isNotEmpty)
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
                            hint: widget.beneficiary?.bankCity ?? 'Select City',
                            items: snapshot.data ?? [],
                            onChanged: (value) {
                              data.bankCity = value;
                            },
                            label: 'BANK CITY',
                            value: data.bankCity,
                          );
                        }),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledDropdown(
                    hint: widget.beneficiary?.cur ?? 'Select Currency',
                    items: data.bankCountry?.currencies
                            ?.map((e) => e.cur ?? '')
                            .toList() ??
                        [],
                    onChanged: (value) {
                      data.currency = data.bankCountry?.currencies
                          ?.firstWhere((element) => element.cur == value);
                    },
                    label: 'CURRENCY',
                    value: data.currency?.cur,
                  ),
                  if (data.bankCountry?.name?.toUpperCase() != 'NIGERIA')
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.bankCountry?.name?.toUpperCase() != 'NIGERIA')
                    LabelledTextField(
                      controller: data.bankName,
                      label: 'BANK NAME',
                      hint: widget.beneficiary?.bankName ?? '',
                    ),
                  if (data.bankCountry?.name?.toUpperCase() == 'NIGERIA')
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.bankCountry?.name?.toUpperCase() == 'NIGERIA')
                    FutureBuilder<List<NigBank>>(
                        future: api.getBanks(context),
                        builder: (context, snapshot) {
                          return InkWell(
                            onTap: () async {
                              if (data.nigBanks.isNotEmpty) {
                                String bank = await Navigation.push(
                                  SearchList(
                                    items: data.nigBanks
                                        .map((e) => e.bankName ?? '')
                                        .toList(),
                                  ),
                                  context,
                                );
                                data.bank = data.nigBanks.firstWhere(
                                    (element) => element.bankName == bank);
                              } else {
                                setState(() {});
                              }
                            },
                            child: SearchDropdown(
                              leading: data.bankCountry?.abbr?.toLowerCase(),
                              icon: snapshot.connectionState ==
                                          ConnectionState.done ||
                                      vtnData.countries.isNotEmpty
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
                              hint: 'Select Bank',
                              label: 'BANK NAME',
                              text: data.bank?.bankName,
                            ),
                          );
                        }),
                  if (data.bankCountry?.name?.toUpperCase() == 'NIGERIA')
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.bankCountry?.name?.toUpperCase() == 'NIGERIA')
                    LabelledDropdown(
                      hint: widget.beneficiary?.accountType == null
                          ? 'Select Account Type'
                          : data.accountTypes.entries
                              .firstWhere((element) =>
                                  element.value ==
                                  widget.beneficiary?.accountType?.toString())
                              .key,
                      items: data.accountTypes.keys.toList(),
                      onChanged: (value) {
                        data.accountType = data.accountTypes[value];
                      },
                      label: 'ACCOUNT TYPE',
                      value: data.accountType == null
                          ? null
                          : data.accountTypes.entries
                              .firstWhere((element) =>
                                  element.value == data.accountType)
                              .key,
                    ),
                  if (data.country?.name?.toLowerCase() == 'argentina')
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.country?.name?.toLowerCase() == 'argentina')
                    LabelledTextField(
                      controller: data.idType,
                      label: 'ID NUMBER',
                    ),
                  if (data.country?.name?.toLowerCase() == 'russia')
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.country?.name?.toLowerCase() == 'russia')
                    LabelledTextField(
                      controller: data.cpf,
                      label: 'CPF',
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    controller: data.accountNo,
                    label: 'ACCOUNT NUMBER',
                    maxLength: 10,
                    hint: widget.beneficiary?.accountNo,
                    onChanged: (value) {
                      if (data.accountName.text.isNotEmpty) {
                        data.accountName.clear();
                      }
                      setState(() {});
                    },
                    suffix: (data.accountNo.text.length > 3 &&
                            data.accountName.text.isEmpty &&
                            data.bank != null &&
                            data.bankCountry != null &&
                            !loading)
                        ? InkWell(
                            onTap: () async {
                              setState(() {
                                loading = true;
                              });
                              await api.verifyBank(
                                context: context,
                                country: data.bankCountry!,
                              );
                              setState(() {
                                loading = false;
                              });
                            },
                            child: const Text(
                              'VERIFY',
                              style: CustomTextStyle(
                                color: CustomColors.primary,
                              ),
                            ),
                          )
                        : loading
                            ? SizedBox.fromSize(
                                size: const Size(12, 12),
                                child: const CircularProgressIndicator.adaptive(
                                  strokeWidth: 1.2,
                                  valueColor: AlwaysStoppedAnimation(
                                    CustomColors.primary,
                                  ),
                                ),
                              )
                            : data.accountName.text.isNotEmpty
                                ? const Icon(
                                    Icons.check_circle_rounded,
                                    color: CustomColors.primary,
                                    size: 20,
                                  )
                                : null,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    label: 'ACCOUNT NAME',
                    hint: widget.beneficiary?.accountName,
                    controller: data.accountName,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    hint: widget.beneficiary?.bankAddress,
                    controller: data.bankAddress,
                    label: 'BANK ADDRESS',
                    minLines: 3,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    hint: widget.beneficiary?.bankZipcode,
                    label: 'BANK ZIPCODE',
                    controller: data.bankZipcode,
                  ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // LabelledTextField(
                  //   controller: data.sortCode,
                  //   label: 'SORT CODE',
                  //   hint: widget.beneficiary?.bankSortCode,
                  // ),
                  if (data.bankCountry?.name?.toUpperCase() != 'NIGERIA')
                    const SizedBox(
                      height: 16,
                    ),
                  if (data.bankCountry?.name?.toUpperCase() != 'NIGERIA')
                    LabelledTextField(
                      controller: data.swift,
                      label: 'SWIFT',
                      hint: widget.beneficiary?.swift,
                    ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // LabelledTextField(
                  //   controller: data.routingNo,
                  //   label: 'ROUTING NO.',
                  //   hint: widget.beneficiary?.bankRoutingNo,
                  // ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
