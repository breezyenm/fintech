import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/obscure.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_field.dart';
import 'package:qwid/providers/API/auth.dart';
import 'package:qwid/providers/brain/settings_provider.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/screens/onboarding/create_account.dart';
import 'package:qwid/screens/onboarding/forgot_password.dart';
import 'package:qwid/screens/onboarding/onboarding.dart';
import 'package:qwid/skeletons/home.dart';
import 'package:qwid/skeletons/onboarding.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  bool obscure = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  check() async {
    Provider.of<AuthData>(context, listen: false).clear();
    await Provider.of<SettingsProvider>(context, listen: false)
        .checkFingerprint()
        .then((fingerprint) async {
      if (!fingerprint) {
        if (loading) {
          loading = true;
          if (mounted) {
            setState(() {});
          }
          await Provider.of<AuthAPI>(context, listen: false)
              .loginWithBiometrics(context)
              .then((value) {
            if (mounted) {
              setState(() {
                loading = false;
              });
            }
            if (value) {
              Navigation.replaceAll(
                const Home(),
                context,
              );
            }
          });
        }
      }
    });
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: LogoAppbar(),
      body: Consumer2<AuthData, AuthAPI>(builder: (context, data, api, chi9ld) {
        return Form(
          key: _key,
          child: Onboarding(
            title: 'Welcome back',
            subtitle: 'Enter your details to login',
            image: '3',
            body: [
              AutofillGroup(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: LabelledField(
                        autofillHints: const [AutofillHints.email],
                        textInputAction: TextInputAction.next,
                        enabled: !loading,
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
                      child: LabelledField(
                        type: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.password],
                        // onEditingComplete: () =>
                        //     TextInput.finishAutofillContext(),
                        textInputAction: TextInputAction.done,
                        enabled: !loading,
                        controller: data.password,
                        hint: 'Password (8 character min)',
                        obscure: obscure,
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          child: Obscure(
                            obscure: obscure,
                          ),
                        ),
                        label: 'Password',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Forgot password? ',
                        style: CustomTextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Reset',
                        style: const CustomTextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (!loading) {
                              Navigation.replaceAll(
                                const ForgotPassword(),
                                context,
                              );
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Consumer<SettingsProvider>(builder: (context, settings, chi9ld) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      if (settings.fingerprint ?? false)
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return CustomColors.black.withOpacity(0.25);
                              }
                              return CustomColors.primary;
                            },
                          ),
                          onTap: () async {
                            if (!loading) {
                              setState(() {
                                loading = true;
                              });
                              await api
                                  .loginWithBiometrics(context)
                                  .then((value) {
                                setState(() {
                                  loading = false;
                                });
                                if (value) {
                                  Navigation.replaceAll(
                                    const Home(),
                                    context,
                                  );
                                }
                              });
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 44,
                            width: 44,
                            // padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CustomColors.labelText.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: CustomColors.white,
                            ),
                            child: CustomIcon(
                              height: 24,
                              icon: 'fingerprint',
                            ),
                          ),
                        ),
                      if (settings.fingerprint ?? false)
                        const SizedBox(
                          width: 10,
                        ),
                      Expanded(
                        child: CustomButton(
                          text: loading ? 'loading' : 'Login',
                          onPressed: () async {
                            if (_key.currentState?.validate() ?? false) {
                              setState(() {
                                loading = true;
                              });
                              TextInput.finishAutofillContext();
                              await api.loginUser(context).then((value) {
                                setState(() {
                                  loading = false;
                                });
                                if (!value) {
                                  // Navigation.replaceAll(
                                  //   const Home(),
                                  //   context,
                                  // );
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ],
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
                        text: 'Don’t have an account? ',
                        style: CustomTextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Create account',
                        style: const CustomTextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigation.replace(
                              const OnboardingPage(),
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
