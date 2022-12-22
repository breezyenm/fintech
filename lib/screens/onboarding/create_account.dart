import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/search_dropdown.dart';
import 'package:qwid/assets/dropdown/search_list.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/providers/API/auth.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/vtn.dart';
import 'package:qwid/screens/onboarding/otp.dart';
import 'package:qwid/skeletons/onboarding.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class RegisterPage extends StatefulWidget {
  final String accountType;
  const RegisterPage({Key? key, required this.accountType}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool loading = false;
  bool obscure = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<AuthData>(context, listen: false).clear();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   context.dependOnInheritedWidgetOfExactType();
  //   super.didChangeDependencies();
  // }

  // @override
  // void dispose() {
  //   Provider.of<AuthData>(context, listen: false).dispos();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: LogoAppbar(),
      body: Consumer<AuthData>(builder: (context, data, chi9ld) {
        return Form(
          key: _key,
          child: Onboarding(
            title: 'Create your ${widget.accountType} account',
            subtitle:
                "Enter your details${widget.accountType == 'business' ? '' : ', we’ll wait 😁'}",
            image: '1',
            body: [
              if (widget.accountType == 'business')
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: LabelledTextField(
                    textInputAction: TextInputAction.next,
                    controller: data.companyName,
                    hint: 'Enter the name of your company',
                    label: 'Company name',
                  ),
                ),
              if (widget.accountType == 'business')
                const SizedBox(
                  height: 24,
                ),
              AutofillGroup(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: LabelledTextField(
                        autofillHints: const [AutofillHints.email],
                        textInputAction: TextInputAction.next,
                        controller: data.email,
                        hint: 'email@example.com',
                        label: 'Email Address',
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: LabelledTextField(
                        autofillHints: const [AutofillHints.password],
                        textInputAction: TextInputAction.done,
                        // onEditingComplete: () =>
                        //     TextInput.finishAutofillContext(),
                        // obscure: obscure,
                        // suffix: InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       obscure = !obscure;
                        //     });
                        //   },
                        //   child: Obscure(
                        //     obscure: obscure,
                        //   ),
                        // ),
                        controller: data.password,
                        hint: 'Password (8 character min)',
                        label: 'Password',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Consumer2<VTNAPI, VTNData>(
                  builder: (context, vtn, vtnData, chi9ld) {
                return FutureBuilder<List<Country>>(
                    future: vtn.getCountries(context),
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: InkWell(
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
                              vtnData.country = (snapshot.data ?? [])
                                  .firstWhere(
                                      (element) => element.name == country);
                            } else {
                              setState(() {});
                            }
                          },
                          child: SearchDropdown(
                            icon: snapshot.connectionState ==
                                        ConnectionState.done ||
                                    (snapshot.data ?? []).isNotEmpty
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
                            label: 'COUNTRY',
                            leading: vtnData.country?.abbr?.toLowerCase(),
                            text: vtnData.country?.name,
                          ),
                        ),
                        // CustomDropdown(
                        //           onChanged: (p0) {
                        //             vtnData.country = snapshot.data
                        //                 ?.firstWhere((element) => element.name == p0);
                        //           },
                        //           value: vtnData.country?.name,
                        //           items:
                        //               snapshot.data?.map((e) => e.name!).toList() ?? [],
                        //           hint: 'Country of residence',
                        //           label: 'Country',
                        //         ),
                      );
                    });
              }),
              const SizedBox(
                height: 24,
              ),
              Consumer<AuthAPI>(builder: (context, authAPI, chi9ld) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: CustomButton(
                    text: loading ? 'loading' : 'Create account',
                    onPressed: () async {
                      if (_key.currentState?.validate() ?? false) {
                        setState(() {
                          loading = true;
                        });
                        TextInput.finishAutofillContext();
                        await authAPI.createUser(context).then((value) {
                          setState(() {
                            loading = false;
                          });
                          if (value) {
                            Navigation.replaceAll(
                              const OTPPage(),
                              context,
                            );
                          }
                        });
                      }
                    },
                  ),
                );
              }),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Already have an account? ',
                        style: CustomTextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: const CustomTextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigation.replace(
                              const LoginPage(),
                              context,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        );
      }),
    );
  }
}
