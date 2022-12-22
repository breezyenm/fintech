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
import 'package:qwid/screens/onboarding/onboarding.dart';
import 'package:qwid/skeletons/home.dart';
import 'package:qwid/skeletons/onboarding.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool loading = false;
  bool obscure = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: LogoAppbar(),
      body: Consumer2<AuthData, AuthAPI>(
        builder: (context, data, api, chi9ld) {
          return Form(
            key: _key,
            child: Onboarding(
              title: 'Password reset',
              subtitle:
                  'Enter your new password and the reset code sent to ${data.email.text}',
              image: '3',
              body: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: LabelledField(
                    autofillHints: const [AutofillHints.password],
                    // onEditingComplete: () =>
                    //     TextInput.finishAutofillContext(),
                    textInputAction: TextInputAction.done,
                    enabled: !loading,
                    controller: data.newPassword,
                    hint: 'New Password (8 character min)',
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
                    label: 'New Password',
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
                    textInputAction: TextInputAction.done,
                    enabled: !loading,
                    controller: data.resetCode,
                    hint: 'Enter reset code',
                    label: 'Reset code',
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
                    text: loading ? 'loading' : 'Save password',
                    onPressed: () async {
                      if (_key.currentState?.validate() ?? false) {
                        setState(() {
                          loading = true;
                        });
                        await api.resetPassword(context);
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
        },
      ),
    );
  }
}
