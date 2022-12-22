import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qwid/assets/buttons/signup.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/screens/onboarding/login.dart';
import 'package:qwid/skeletons/onboarding.dart';

import 'create_account.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Onboarding(
      image: '0',
      title: 'The easiest way to make payments worldwide.',
      subtitle: 'Create your personal or business account',
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SignupButton(
            onPressed: () {
              Navigation.push(
                const RegisterPage(
                  accountType: 'personal',
                ),
                context,
              );
            },
            icon: 'personal',
            text: 'Sign up for a Personal Account',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SignupButton(
            onPressed: () {
              Navigation.push(
                const RegisterPage(
                  accountType: 'business',
                ),
                context,
              );
            },
            icon: 'business',
            text: 'Sign up for a Business Account',
          ),
        ),
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
                  text: 'Log in',
                  style: const CustomTextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigation.replaceAll(
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
          height: 44,
        ),
      ],
    );
  }
}
