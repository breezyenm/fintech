import 'package:flutter/material.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_field.dart';
import 'package:qwid/providers/API/auth.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/skeletons/onboarding.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool loading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: LogoAppbar(),
      body: Consumer2<AuthData, AuthAPI>(builder: (context, data, api, chi9ld) {
        return Form(
          key: _key,
          child: Onboarding(
            title: 'Forgot password?',
            subtitle: 'Enter your details to reset your password',
            image: '3',
            body: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: LabelledField(
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.done,
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
                child: CustomButton(
                  text: loading ? 'loading' : 'Reset password',
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      setState(() {
                        loading = true;
                      });
                      await api.forgotPassword(context);
                      if (mounted) {
                        setState(() {
                          loading = false;
                        });
                      }
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
