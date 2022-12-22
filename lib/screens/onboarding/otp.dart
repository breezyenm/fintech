import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_field.dart';
import 'package:qwid/providers/API/auth.dart';
import 'package:qwid/providers/brain/auth_provider.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/screens/onboarding/verification.dart';
import 'package:qwid/screens/onboarding/waiting.dart';
import 'package:qwid/skeletons/onboarding.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  bool loading = false;
  bool resending = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: LogoAppbar(),
      body: Consumer3<AuthData, AuthAPI, AuthProvider>(
          builder: (context, data, api, pro, chi9ld) {
        return Form(
          key: _key,
          child: Onboarding(
            title: 'Welcome to Qwid',
            subtitle:
                'Provide below the confirmation code sent to ${data.user?.email?.substring(0, 2)}${'******'}@${data.user?.email?.split('@').last}',
            image: '3',
            body: [
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: LabelledField(
                  label: 'OTP',
                  controller: data.code,
                  hint: '8-character code',
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
                        text: 'Didn’t receive the code? ',
                        style: CustomTextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.black,
                        ),
                      ),
                      TextSpan(
                        text: resending ? 'Resending' : 'Resend code',
                        style: CustomTextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: pro.resend > 0
                              ? CustomColors.labelText.withOpacity(0.5)
                              : CustomColors.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (pro.resend == 0) {
                              setState(() {
                                resending = true;
                              });
                              await api.resendEmail(context: context);
                              setState(() {
                                resending = false;
                              });
                              pro.resend = 30;
                              pro.reduce();
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
              if (pro.resend > 0)
                const SizedBox(
                  height: 4,
                ),
              if (pro.resend > 0)
                Text(
                  'Email Resent. You can resend again in ${pro.resend} second${pro.resend == 1 ? '' : 's'}',
                  style: CustomTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.labelText.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: CustomButton(
                  text: loading ? 'loading' : 'Verify email',
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      setState(() {
                        loading = true;
                      });
                      await api.verifyEmail(context: context).then((value) {
                        if (value) {
                          Navigation.replace(
                            const Waiting(),
                            context,
                          );
                        }
                      });
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Consumer<AuthData>(builder: (context, data, child) {
                return InkWell(
                  onTap: () async {
                    await Navigation.replaceAll(
                      const LoginPage(),
                      context,
                    );
                    data.user = null;
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Back to login',
                        style: CustomTextStyle(
                          color: CustomColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 11.5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: CustomColors.primary,
                        size: 10,
                      ),
                    ],
                  ),
                );
              }),
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
