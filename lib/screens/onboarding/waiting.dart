import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/appbars/logo_appbar.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/providers/API/auth.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/screens/onboarding/loader.dart';
import 'package:qwid/screens/onboarding/login.dart';

class Waiting extends StatefulWidget {
  const Waiting({Key? key}) : super(key: key);

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<AuthData>(builder: (context, authData, child) {
      return Scaffold(
        appBar: LogoAppbar(
          automaticallyImplyLeading: false,
        ),
        backgroundColor: CustomColors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            Image.asset(
              'images/admin_review.gif',
              height: width * 0.54,
              width: width * 0.54,
            ),
            const SizedBox(
              height: 48,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Text(
                'Next step!',
                style: CustomTextStyle(
                  color: CustomColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Text(
                'Complete a quick kyc verification so we can verify your identity',
                style: CustomTextStyle(
                  color: CustomColors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Consumer<AuthAPI>(builder: (context, api, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: CustomButton(
                  text: loading ? 'loading' : 'KYC Verification',
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    await api.kycVerification(context);
                    // await api.loginCheck(context);
                    if (mounted) {
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
              );
            }),
            const SizedBox(
              height: 48,
            ),
            InkWell(
              onTap: () async {
                await Navigation.replaceAll(
                  const LoginPage(),
                  context,
                );
                authData.user = null;
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
            ),
            const SizedBox(
              height: 48,
            ),
          ],
        ),
      );
    });
  }
}
