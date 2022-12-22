import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/confirm.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/providers/API/auth.dart';
import 'package:qwid/providers/brain/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:qwid/providers/brain/settings_provider.dart';
import 'package:qwid/screens/home/components/settings_card.dart';
import 'package:qwid/screens/home/pages/settings/profile/profile_settings.dart';
import 'package:qwid/screens/home/pages/settings/security/components/settings_option.dart';
import 'package:qwid/screens/home/pages/settings/security/two_factor.dart';
import 'package:qwid/screens/home/pages/settings/security/update_password.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homePro, chi9ld) {
      return Scaffold(
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 44),
          children: [
            SettingsCard(
              title: 'Profile',
              onPressed: () {
                Navigation.push(
                  const ProfileSettings(),
                  context,
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            SettingsCard(
              title: 'Security',
              settings: Column(
                children: [
                  const SettingsOption(
                    text: 'Update Password',
                    subtext: 'Change and Reset forgotten password',
                    route: UpdatePassword(),
                  ),
                  const Divider(
                    height: 32,
                  ),
                  const SettingsOption(
                    text: 'Two-factor Authentication',
                    subtext: 'Add an extra layer of security',
                    route: TwoFactor(),
                  ),
                  const Divider(
                    height: 32,
                  ),
                  Consumer<SettingsProvider>(builder: (context, pro, child) {
                    return SettingsOption(
                      text: 'Biometrics',
                      subtext: 'Use your fingerprint or face ID to login',
                      onChanged: (value) async {
                        await pro.toggleFingerprint(context);
                      },
                      toggle: pro.fingerprint,
                    );
                  }),
                  const Divider(
                    height: 32,
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 16,
            // ),
            // SettingsCard(
            //   title: 'Notifications',
            //   settings: Column(
            //     children: [
            //       SettingsOption(
            //         text: 'Push Notifications',
            //         subtext:
            //             'Keep track of your transactions with notifications',
            //         onChanged: (value) {},
            //         toggle: true,
            //       ),
            //       const Divider(
            //         height: 32,
            //       ),
            //       SettingsOption(
            //         text: 'Email Notifications',
            //         subtext: 'Transaction notifications will be emailed to you',
            //         onChanged: (value) {},
            //         toggle: true,
            //       ),
            //       const Divider(
            //         height: 32,
            //       ),
            //       SettingsOption(
            //         text: 'Login Alerts',
            //         subtext: 'Login alerts will be emailed to you',
            //         onChanged: (value) {},
            //         toggle: true,
            //       ),
            //       const Divider(
            //         height: 32,
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            // const SettingsCard(
            //   title: 'API Keys',
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 32,
            //   ),
            //   child: Text(
            //     'Other Settings',
            //     style: CustomTextStyle(
            //       color: CustomColors.text,
            //       fontFamily: 'Montserrat',
            //       fontSize: 18,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 16,
            ),
            Consumer<AuthAPI>(builder: (context, authAPI, chi9ld) {
              return SettingsCard(
                title: 'LOGOUT',
                destructive: true,
                onPressed: () async {
                  bool success = await confirm(
                    context: context,
                    content: 'Are you sure you want to logout?',
                    yes: 'Yes, logout',
                    no: 'No, stay',
                    yesDestructive: true,
                  );
                  if (success) {
                    setState(() {
                      loading = true;
                    });
                    bool success = await authAPI.logout(context);
                    if (mounted) {
                      setState(() {
                        loading = false;
                      });
                    }
                  }
                },
              );
            }),
            if (loading)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(CustomColors.primary),
                ),
              ),
          ],
        ),
      );
    });
  }
}
