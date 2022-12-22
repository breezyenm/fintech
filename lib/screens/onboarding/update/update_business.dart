import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/providers/API/auth.dart';
import 'package:qwid/providers/API/profile.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/vtn.dart';
import 'package:qwid/screens/onboarding/update/application_personnel_details.dart';
import 'package:qwid/screens/onboarding/update/business_address.dart';
import 'package:qwid/screens/onboarding/update/business_registration_details.dart';
import 'package:qwid/screens/onboarding/update/other_information.dart';
import 'package:qwid/screens/onboarding/update/stakeholder_info.dart';
import 'package:qwid/skeletons/onboarding.dart';

class UpdateBusinessProfile extends StatefulWidget {
  const UpdateBusinessProfile({Key? key}) : super(key: key);

  @override
  State<UpdateBusinessProfile> createState() => _UpdateBusinessProfileState();
}

class _UpdateBusinessProfileState extends State<UpdateBusinessProfile> {
  bool loading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthData, VTNAPI, VTNData>(
        builder: (context, auth, vtn, vtnData, child) {
      return Form(
        key: _key,
        child: Onboarding(
          title: 'Update Business info',
          subtitle:
              'We need a few more details as requested by our banking partners',
          body: [
            Divider(
              color: CustomColors.labelText.withOpacity(0.5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ApplicationPersonnelDetails(),
                  const BusinessRegistrationDetails(),
                  const BusinessAddress(),
                  const StakeholderInfo(),
                  const OtherInfo(),
                  Consumer2<ProfileAPI, AuthAPI>(
                      builder: (context, profileAPI, api, child) {
                    return CustomButton(
                      text: loading ? 'loading' : 'Save',
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
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
