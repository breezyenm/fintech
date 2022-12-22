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
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/vtn.dart';

class BusinessRegistrationDetails extends StatefulWidget {
  const BusinessRegistrationDetails({Key? key}) : super(key: key);

  @override
  State<BusinessRegistrationDetails> createState() =>
      _BusinessRegistrationDetailsState();
}

class _BusinessRegistrationDetailsState
    extends State<BusinessRegistrationDetails> {
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
                'Business Registration Details',
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
            controller: auth.companyName,
            label: 'BUSINESS NAME',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.businessRegistrationNumber,
            label: 'BUSINESS REGISTRATION NUMBER',
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
                auth.businessRegisteredDate.text =
                    DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(dateTime);
              }
            },
            controller: auth.businessRegisteredDate,
            label: 'BUSINESS REGISTERED DATE',
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
                //     vtnData.country = snapshot.data?.firstWhere(
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
                      auth.businessRegisteredCountry = (snapshot.data ?? [])
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
                    leading:
                        auth.businessRegisteredCountry?.abbr?.toLowerCase(),
                    text: auth.businessRegisteredCountry?.name,
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
                //     auth.businessRegisteredCountry = snapshot.data
                //         ?.firstWhere((element) => element.name == p0);
                //   },
                //   value: auth.businessRegisteredCountry?.name,
                //   items: snapshot.data?.map((e) => e.name!).toList() ?? [],
                //   hint: 'Select Country',
                //   label: 'BUSINESS REGISTERED COUNTRY',
                // );
              }),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.tradingName,
            label: 'TRADING NAME',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.website,
            label: 'WEBSITE (Optional)',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledDropdown(
            onChanged: (p0) {
              setState(() {
                auth.businessCategory = p0;
              });
            },
            value: auth.businessCategory,
            items: const [
              'Sole Trader',
              'Private Limited Company',
              'Public Company',
              'Partnership',
              'Limited Liability Partnership Firm',
              'Government Body',
              'Associations',
              'Trust',
              'Regulated Trust',
              'Unregulated Trust',
            ],
            hint: 'Select',
            label: 'BUSINESS CATEGORY',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.businessProductDetails,
            label: 'BUSINESS PRODUCT',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.businessProductType,
            label: 'BUSINESS PRODUCT TYPE',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledDropdown(
            onChanged: (p0) {
              setState(() {
                auth.businessProgram = p0;
              });
            },
            value: auth.businessProgram,
            items: const [
              'PROGRAM MANAGER',
              'SME',
            ],
            hint: 'Select',
            label: 'BUSINESS PROGRAM',
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );
    });
  }
}
