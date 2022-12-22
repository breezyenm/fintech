import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/labelled_dropdown.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/models/state.dart';
import 'package:qwid/providers/API/auth.dart';
import 'package:qwid/providers/API/profile.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/vtn.dart';
import 'package:qwid/screens/onboarding/update/update_business.dart';
import 'package:qwid/skeletons/onboarding.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool loading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthData, VTNAPI, VTNData>(
        builder: (context, auth, vtn, vtnData, child) {
      return Form(
        key: _key,
        child: Onboarding(
          title: 'Update Profile',
          subtitle: 'Fill the form below to continue',
          body: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  LabelledTextField(
                    autofillHints: const [AutofillHints.givenName],
                    textInputAction: TextInputAction.next,
                    controller: auth.firstName,
                    hint: auth.user!.firstName,
                    label: 'FIRST NAME',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    autofillHints: const [AutofillHints.familyName],
                    textInputAction: TextInputAction.next,
                    controller: auth.lastName,
                    hint: auth.user!.lastName,
                    label: 'LAST NAME',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    type: TextInputType.datetime,
                    autofillHints: const [AutofillHints.birthdayDay],
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
                        auth.dob.text =
                            DateFormat(DateFormat.YEAR_NUM_MONTH_DAY)
                                .format(dateTime);
                      }
                    },
                    controller: auth.dob,
                    hint: auth.user!.dob,
                    label: 'DATE OF BIRTH',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledDropdown(
                    onChanged: (p0) {
                      auth.gender = p0;
                    },
                    value: auth.gender,
                    items: const ['Male', 'Female', 'Other'],
                    hint: auth.user?.sex ?? 'Select Gender',
                    label: 'GENDER',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    enabled: false,
                    controller: auth.email,
                    hint: auth.user!.email,
                    label: 'EMAIL ADDRESS',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    type: TextInputType.number,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    textInputAction: TextInputAction.next,
                    controller: auth.phone,
                    hint: auth.user!.phone,
                    label: 'PHONE',
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
                        return LabelledDropdown(
                          icon: snapshot.connectionState == ConnectionState.done
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
                          onChanged: (p0) {
                            vtnData.city = null;
                            vtnData.state = null;
                            vtnData.cities = [];
                            vtnData.states = [];
                            vtnData.country = snapshot.data
                                ?.firstWhere((element) => element.name == p0);
                          },
                          value: vtnData.country?.name,
                          items:
                              snapshot.data?.map((e) => e.name!).toList() ?? [],
                          hint: 'Country of residence',
                          label: 'COUNTRY',
                        );
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder<List<States>>(
                      future: vtnData.country == null
                          ? null
                          : vtn.getState(context, vtnData.country!.abbr!),
                      builder: (context, snapshot) {
                        return LabelledDropdown(
                          icon: snapshot.connectionState ==
                                      ConnectionState.done ||
                                  vtnData.country == null
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
                          onChanged: (p0) {
                            vtnData.city = null;
                            vtnData.cities = [];
                            vtnData.state = snapshot.data
                                ?.firstWhere((element) => element.name == p0);
                          },
                          value: vtnData.state?.name,
                          items: snapshot.data
                                  ?.map((e) => e.name ?? '')
                                  .toList() ??
                              [],
                          hint:
                              auth.user?.state?.toUpperCase() ?? 'Select State',
                          label: 'STATE',
                        );
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder<List<String>>(
                      future: (vtnData.country == null || vtnData.state == null)
                          ? null
                          : vtn.getCity(
                              context,
                              vtnData.country!.name!,
                              vtnData.state!.name!,
                            ),
                      builder: (context, snapshot) {
                        return LabelledDropdown(
                          icon: (snapshot.connectionState ==
                                      ConnectionState.done ||
                                  vtnData.country == null ||
                                  vtnData.state == null)
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
                          onChanged: (p0) {
                            vtnData.city = p0;
                          },
                          value: vtnData.city,
                          items: snapshot.data ?? [],
                          hint: auth.user?.city ?? 'Select City',
                          label: 'CITY',
                        );
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    type: TextInputType.streetAddress,
                    autofillHints: const [AutofillHints.fullStreetAddress],
                    textInputAction: TextInputAction.next,
                    controller: auth.address,
                    hint: auth.user!.address,
                    label: 'ADDRESS',
                    minLines: 3,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    type: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    controller: auth.zipcode,
                    hint: auth.user!.zipcode.toString(),
                    label: 'ZIP CODE',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer2<ProfileAPI, AuthAPI>(
                      builder: (context, profileAPI, api, child) {
                    return CustomButton(
                      text: loading
                          ? 'loading'
                          : auth.user?.userType == 1
                              ? 'Save'
                              : 'Next',
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          if (auth.user?.userType == 1) {
                            setState(() {
                              loading = true;
                            });
                            bool success = await profileAPI.update(
                              context,
                            );
                            if (success) {
                              await api.loginCheck(context);
                            }
                            if (mounted) {
                              setState(() {
                                loading = false;
                              });
                            }
                          } else {
                            Navigation.push(
                              const UpdateBusinessProfile(),
                              context,
                            );
                          }
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
