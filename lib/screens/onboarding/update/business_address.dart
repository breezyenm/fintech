import 'package:flutter/material.dart';
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

class BusinessAddress extends StatefulWidget {
  const BusinessAddress({Key? key}) : super(key: key);

  @override
  State<BusinessAddress> createState() => _BusinessAddressState();
}

class _BusinessAddressState extends State<BusinessAddress> {
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
                'Business Address',
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
          FutureBuilder<List<Country>>(
              future: vtn.getCountries(context),
              builder: (context, snapshot) {
                return InkWell(
                  onTap: () async {
                    if ((snapshot.data ?? []).isNotEmpty) {
                      auth.businessCity = null;
                      auth.businessState = null;
                      auth.businessCities = [];
                      auth.businessStates = [];
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
                      auth.businessCountry = (snapshot.data ?? [])
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
                    label: 'BUSINESS COUNTRY',
                    leading: auth.businessCountry?.abbr?.toLowerCase(),
                    text: auth.businessCountry?.name,
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
                //     auth.businessCity = null;
                //     auth.businessState = null;
                //     auth.businessCities = [];
                //     auth.businessStates = [];
                //     setState(() {
                //       auth.businessCountry = snapshot.data
                //           ?.firstWhere((element) => element.name == p0);
                //     });
                //   },
                //   value: auth.businessCountry?.name,
                //   items: snapshot.data?.map((e) => e.name!).toList() ?? [],
                //   hint: 'Select Country',
                //   label: 'BUSINESS COUNTRY',
                // );
              }),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder<List<States>>(
              future: auth.businessCountry == null
                  ? null
                  : vtn.getState(context, auth.businessCountry!.abbr!,
                      save: false),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  auth.businessStates = snapshot.data ?? [];
                }
                return LabelledDropdown(
                  icon: snapshot.connectionState == ConnectionState.done ||
                          auth.businessCountry == null ||
                          auth.businessStates.isNotEmpty
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
                    auth.businessCity = null;
                    auth.businessCities = [];
                    auth.businessState = snapshot.data
                        ?.firstWhere((element) => element.name == p0);
                  },
                  value: auth.businessState?.name,
                  items: snapshot.data?.map((e) => e.name ?? '').toList() ?? [],
                  hint: 'Select State',
                  label: 'BUSINESS STATE',
                );
              }),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder<List<String>>(
              future:
                  (auth.businessCountry == null || auth.businessState == null)
                      ? null
                      : vtn.getCity(
                          context,
                          auth.businessCountry!.name!,
                          auth.businessState!.name!,
                          save: false,
                        ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  auth.businessCities = snapshot.data ?? [];
                }
                return LabelledDropdown(
                  icon: (snapshot.connectionState == ConnectionState.done ||
                          auth.businessCountry == null ||
                          auth.businessState == null ||
                          auth.businessCities.isNotEmpty)
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
                    auth.businessCity = p0;
                  },
                  value: auth.businessCity,
                  items: snapshot.data ?? [],
                  hint: 'Select City',
                  label: 'BUSINESS CITY',
                );
              }),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.businessAddress,
            onChanged: (value) {
              lastName = value;
            },
            label: 'BUSINESS ADDRESS',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.businessZipcode,
            onChanged: (value) {
              firstName = value;
            },
            label: 'BUSINESS ZIPCODE',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            type: TextInputType.number,
            textInputAction: TextInputAction.next,
            controller: auth.businessMobile,
            onChanged: (value) {
              lastName = value;
            },
            label: 'BUSINESS MOBILE',
          ),
        ],
      );
    });
  }
}
