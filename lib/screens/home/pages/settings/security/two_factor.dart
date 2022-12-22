import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/providers/API/settings.dart';
import 'package:qwid/providers/data/settings.dart';
import 'package:qwid/screens/home/components/copy.dart';
import 'package:url_launcher/url_launcher.dart';

class TwoFactor extends StatefulWidget {
  const TwoFactor({Key? key}) : super(key: key);

  @override
  State<TwoFactor> createState() => _TwoFactorState();
}

class _TwoFactorState extends State<TwoFactor> {
  bool loading = false;
  bool backPressed = false;
  bool? active;
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsAPI>(builder: (context, api, chi9ld) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Two-factor Authentication',
          ),
          leading: backPressed
              ? const CircularProgressIndicator.adaptive(
                  strokeWidth: 1.4,
                  valueColor: AlwaysStoppedAnimation(CustomColors.primary),
                )
              : IconButton(
                  onPressed: () async {
                    setState(() {
                      backPressed = true;
                    });
                    await api
                        .deactivateGoogleAuth(context)
                        .then((value) => Navigation.pop(context));
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
        ),
        body: FutureBuilder<Map<String, String>?>(
            future: active != null ? null : api.getGoogleAuthStatus(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                active = snapshot.data == null;
              }
              if (snapshot.connectionState != ConnectionState.done &&
                  active == null) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation(CustomColors.primary),
                  ),
                );
              }
              if (active ?? false) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Two-factor Authenticator app enabled',
                          style: CustomTextStyle(
                            color: CustomColors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Tap the button below to de-activate your 2FA.',
                          style: CustomTextStyle(
                            color: CustomColors.black.withOpacity(0.5),
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomButton(
                          text: loading ? 'loading' : 'Disable 2fa',
                          onPressed: backPressed
                              ? null
                              : () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  bool success =
                                      await api.deactivateGoogleAuth(context);
                                  setState(() {
                                    loading = false;
                                  });
                                  if (success) {
                                    Navigation.pop(context);
                                  }
                                },
                        ),
                      ],
                    ),
                  ),
                );
              }
              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 44),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Set Up Authenticator App',
                        style: CustomTextStyle(
                          color: CustomColors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '• Install ',
                                    style: CustomTextStyle(
                                      color:
                                          CustomColors.black.withOpacity(0.5),
                                      fontFamily: 'Montserrat',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                      text: 'Google Authenticator',
                                      style: const CustomTextStyle(
                                        color: CustomColors.primary,
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          if (Platform.isAndroid) {
                                            launchUrl(
                                              Uri.parse(
                                                'https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en_US&gl=US',
                                              ),
                                            );
                                          }
                                          if (Platform.isIOS) {
                                            launchUrl(
                                              Uri.parse(
                                                'https://apps.apple.com/ng/app/google-authenticator/id388497605',
                                              ),
                                            );
                                          }
                                        }),
                                  TextSpan(
                                    text: ' app on your phone',
                                    style: CustomTextStyle(
                                      color:
                                          CustomColors.black.withOpacity(0.5),
                                      fontFamily: 'Montserrat',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '• Scan the QR Code below',
                              style: CustomTextStyle(
                                color: CustomColors.black.withOpacity(0.5),
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: Image.network(
                      snapshot.data!['qrCode']!,
                      height: 141,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    child: Text(
                      '• If you can’t scan the QR Code, enter this code in the Google Authenticator app',
                      style: CustomTextStyle(
                        color: CustomColors.black.withOpacity(0.5),
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data!['code']!,
                          style: const CustomTextStyle(
                            color: CustomColors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Copy(
                          text: snapshot.data!['code']!,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Enable Authenticator app',
                    style: CustomTextStyle(
                      color: CustomColors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Enter the 6 digit code from the app once the scan is completed to activate your 2FA.',
                    style: CustomTextStyle(
                      color: CustomColors.black.withOpacity(0.5),
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer<SettingsData>(builder: (context, data, chi9ld) {
                    return LabelledTextField(
                      label: 'CODE',
                      controller: data.code,
                      hint: '8-character code',
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer<SettingsData>(builder: (context, data, chi9ld) {
                    return CustomButton(
                      text: loading ? 'loading' : 'Enable 2fa',
                      onPressed: backPressed
                          ? null
                          : () async {
                              setState(() {
                                loading = true;
                              });
                              active = await api.confirmGoogleAuth(
                                context,
                                code: data.code.text,
                                googleAuthCode: snapshot.data!['code']!,
                              );
                              data.code.clear();
                              setState(() {
                                loading = false;
                              });
                            },
                    );
                  }),
                ],
              );
            }),
      );
    });
  }
}
