import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/labelled_dropdown.dart';
import 'package:qwid/assets/dropdown/search_dropdown.dart';
import 'package:qwid/assets/dropdown/search_list.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/models/state.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/vtn.dart';

class StakeholderInfo extends StatefulWidget {
  const StakeholderInfo({Key? key}) : super(key: key);

  @override
  State<StakeholderInfo> createState() => _StakeholderInfoState();
}

class _StakeholderInfoState extends State<StakeholderInfo> {
  String? address, dob, phone, firstName, lastName, gender, zipcode;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthData, VTNAPI>(builder: (context, auth, vtn, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: const [
              SizedBox(
                height: 48,
              ),
              Text(
                'Stakeholder Information',
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
            controller: auth.stakeholder1LastName,
            onChanged: (value) {
              firstName = value;
            },
            label: 'STAKEHOLDER LAST NAME',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.stakeholder1FirstName,
            onChanged: (value) {
              lastName = value;
            },
            label: 'STAKEHOLDER FIRST NAME',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.stakeholder1Email,
            onChanged: (value) {
              firstName = value;
            },
            label: 'STAKEHOLDER EMAIL',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.stakeholder1Designation,
            onChanged: (value) {
              lastName = value;
            },
            label: 'STAKEHOLDER POSITION',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            enabled: false,
            onTap: () async {
              DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now(),
              );
              if (dateTime != null) {
                auth.stakeholder1PostStartDate.text =
                    DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(dateTime);
              }
            },
            controller: auth.stakeholder1PostStartDate,
            onChanged: (value) {
              dob = value;
            },
            label: 'STAKEHOLDER DATE OF APPOINTMENT (POSITION)',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            enabled: false,
            onTap: () async {
              DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now().add(const Duration(
                  days: 365 * 100,
                )),
              );
              if (dateTime != null) {
                auth.stakeholder1PostEndDate.text =
                    DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(dateTime);
              }
            },
            controller: auth.stakeholder1PostEndDate,
            onChanged: (value) {
              dob = value;
            },
            label: 'STAKEHOLDER DATE OF TERMINATION (POSITION) (Optional)',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.stakeholder1ShareVolume,
            onChanged: (value) {
              firstName = value;
            },
            label: 'STAKEHOLDER SHARE PERCENTAGE',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            enabled: false,
            onTap: () async {
              DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.tryParse(auth.user?.dob ?? '') ??
                    DateTime.now().subtract(
                      const Duration(
                        days: 365 * 18,
                      ),
                    ),
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now().subtract(
                  const Duration(
                    days: 365 * 18,
                  ),
                ),
              );
              if (dateTime != null) {
                auth.stakeholder1DOB.text =
                    DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(dateTime);
              }
            },
            controller: auth.stakeholder1DOB,
            onChanged: (value) {
              dob = value;
            },
            label: 'STAKEHOLDER DATE OF BIRTH',
          ),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder<List<Country>>(
              future: vtn.getCountries(context),
              builder: (context, snapshot) {
                return InkWell(
                  onTap: () async {
                    if ((snapshot.data ?? []).isNotEmpty) {
                      auth.stakeholder1City = null;
                      auth.stakeholder1State = null;
                      auth.stakeholderCities = [];
                      auth.stakeholderStates = [];
                      String country = await Navigation.push(
                        SearchList(
                          leading: (snapshot.data ?? [])
                              .map((e) => e.abbr?.toLowerCase() ?? '')
                              .toList(),
                          items: (snapshot.data ?? [])
                              .map((e) => e.name ?? '')
                              .toList(),
                        ),
                        context,
                      );
                      auth.stakeholder1Nationality = (snapshot.data ?? [])
                          .firstWhere((element) => element.name == country);
                    } else {
                      setState(() {});
                    }
                  },
                  child: SearchDropdown(
                    icon: snapshot.connectionState == ConnectionState.done ||
                            (snapshot.data ?? []).isNotEmpty
                        ? null
                        : const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 1.2,
                              valueColor:
                                  AlwaysStoppedAnimation(CustomColors.primary),
                            ),
                          ),
                    hint: 'Select Country',
                    label: 'ISSUING COUNTRY',
                    leading: auth.stakeholder1Nationality?.abbr?.toLowerCase(),
                    text: auth.stakeholder1Nationality?.name,
                  ),
                );
                // LabelledDropdown(
                //   icon: snapshot.connectionState == ConnectionState.done
                //       ? null
                //       : const SizedBox(
                //           height: 24,
                //           width: 24,
                //           child: CircularProgressIndicator.adaptive(
                //             strokeWidth: 1.2,
                //             valueColor:
                //                 AlwaysStoppedAnimation(CustomColors.primary),
                //           ),
                //         ),
                //   onChanged: (p0) {
                //     auth.stakeholder1City = null;
                //     auth.stakeholder1State = null;
                //     auth.stakeholderCities = [];
                //     auth.stakeholderStates = [];
                //     auth.stakeholder1Nationality = snapshot.data
                //         ?.firstWhere((element) => element.name == p0);
                //   },
                //   value: auth.stakeholder1Nationality?.name,
                //   items: snapshot.data?.map((e) => e.name!).toList() ?? [],
                //   hint: 'Select Country',
                //   label: 'STAKEHOLDER NATIONALITY',
                // );
              }),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder<List<States>>(
              future: auth.stakeholder1Nationality == null
                  ? null
                  : vtn.getState(context, auth.stakeholder1Nationality!.abbr!,
                      save: false),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  auth.stakeholderStates = snapshot.data ?? [];
                }
                return LabelledDropdown(
                  icon: snapshot.connectionState == ConnectionState.done ||
                          auth.stakeholder1Nationality == null ||
                          auth.stakeholderStates.isNotEmpty
                      ? null
                      : const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 1.2,
                            valueColor:
                                AlwaysStoppedAnimation(CustomColors.primary),
                          ),
                        ),
                  onChanged: (p0) {
                    auth.stakeholder1City = null;
                    auth.stakeholderCities = [];
                    auth.stakeholder1State = snapshot.data
                        ?.firstWhere((element) => element.name == p0);
                  },
                  value: auth.stakeholder1State?.name,
                  items: snapshot.data?.map((e) => e.name ?? '').toList() ?? [],
                  hint: 'Select State',
                  label: 'STAKEHOLDER STATE',
                );
              }),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder<List<String>>(
              future: (auth.stakeholder1Nationality == null ||
                      auth.stakeholder1State == null)
                  ? null
                  : vtn.getCity(
                      context,
                      auth.stakeholder1Nationality!.name!,
                      auth.stakeholder1State!.name!,
                      save: false,
                    ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  auth.stakeholderCities = snapshot.data ?? [];
                }
                return LabelledDropdown(
                  icon: (snapshot.connectionState == ConnectionState.done ||
                          auth.stakeholder1Nationality == null ||
                          auth.stakeholder1State == null ||
                          auth.stakeholderCities.isNotEmpty)
                      ? null
                      : const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 1.2,
                            valueColor:
                                AlwaysStoppedAnimation(CustomColors.primary),
                          ),
                        ),
                  onChanged: (p0) {
                    auth.stakeholder1City = p0;
                  },
                  value: auth.stakeholder1City,
                  items: snapshot.data ?? [],
                  hint: 'Select City',
                  label: 'STAKEHOLDER CITY',
                );
              }),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.stakeholder1Address,
            onChanged: (value) {
              lastName = value;
            },
            label: 'STAKEHOLDER ADDRESS',
          ),
          const SizedBox(
            height: 16,
          ),
          // LabelledTextField(
          //   textInputAction: TextInputAction.next,
          //   controller: auth.firstName,
          //   onChanged: (value) {
          //     firstName = value;
          //   },
          //   label: 'STAKEHOLDER MOBILE',
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.stakeholder1Zipcode,
            onChanged: (value) {
              lastName = value;
            },
            label: 'STAKEHOLDER ZIPCODE',
          ),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder<List<Country>>(
              future: vtn.getCountries(context),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.done) {
                //   if (snapshot.data
                //           ?.map((e) => e.name)
                //           .contains(auth.user?.country) ??
                //       false) {
                //     auth.stakeholder1Nationality = snapshot.data?.firstWhere(
                //         (element) =>
                //             element.name == auth.user?.country);
                //   }
                // }
                return InkWell(
                  onTap: () async {
                    if ((snapshot.data ?? []).isNotEmpty) {
                      String country = await Navigation.push(
                        SearchList(
                          leading: (snapshot.data ?? [])
                              .map((e) => e.abbr?.toLowerCase() ?? '')
                              .toList(),
                          items: (snapshot.data ?? [])
                              .map((e) => e.name ?? '')
                              .toList(),
                        ),
                        context,
                      );
                      auth.stakeholder1TaxCountry = (snapshot.data ?? [])
                          .firstWhere((element) => element.name == country);
                    } else {
                      setState(() {});
                    }
                  },
                  child: SearchDropdown(
                    icon: snapshot.connectionState == ConnectionState.done ||
                            (snapshot.data ?? []).isNotEmpty
                        ? null
                        : const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 1.2,
                              valueColor:
                                  AlwaysStoppedAnimation(CustomColors.primary),
                            ),
                          ),
                    hint: 'Select Country',
                    label: 'ISSUING COUNTRY',
                    leading: auth.stakeholder1TaxCountry?.abbr?.toLowerCase(),
                    text: auth.stakeholder1TaxCountry?.name,
                  ),
                );
                // LabelledDropdown(
                //   icon: snapshot.connectionState == ConnectionState.done
                //       ? null
                //       : const SizedBox(
                //           height: 24,
                //           width: 24,
                //           child: CircularProgressIndicator.adaptive(
                //             strokeWidth: 1.2,
                //             valueColor:
                //                 AlwaysStoppedAnimation(CustomColors.primary),
                //           ),
                //         ),
                //   onChanged: (p0) {
                //     auth.stakeholder1TaxCountry = snapshot.data
                //         ?.firstWhere((element) => element.name == p0);
                //   },
                //   value: auth.stakeholder1TaxCountry?.name,
                //   items: snapshot.data?.map((e) => e.name!).toList() ?? [],
                //   hint: 'Select Country',
                //   label: 'STAKEHOLDER TAX ISSUING COUNTRY',
                // );
              }),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.stakeholder1TaxNumber,
            onChanged: (value) {
              lastName = value;
            },
            label: 'STAKEHOLDER TAX NUMBER',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledDropdown(
            onChanged: (p0) {
              setState(() {
                auth.stakeholder1IsPep = p0;
              });
            },
            value: auth.stakeholder1IsPep,
            items: const [
              'Yes',
              'No',
            ],
            hint: 'Select',
            label: 'Is the stakeholder a PEP?',
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );
    });
  }
}
