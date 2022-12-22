import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/providers/API/profile.dart';
import 'package:qwid/providers/data/settings.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool loading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    Provider.of<SettingsData>(context, listen: false).clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 44),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Update your password',
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
                  'Fill the form below to continue',
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
          const SizedBox(
            height: 16,
          ),
          Consumer<SettingsData>(builder: (context, data, chi9ld) {
            return Container(
              decoration: BoxDecoration(
                color: CustomColors.white,
                border: Border.all(
                  color: CustomColors.stroke,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelledTextField(
                      hint: 'Password',
                      label: 'CURRENT PASSWORD',
                      controller: data.currentPassword,
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // const Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Text(
                    //     'Forgot password?',
                    //     style: CustomTextStyle(
                    //       fontSize: 11,
                    //       fontWeight: FontWeight.w400,
                    //       color: CustomColors.darkPrimary,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 16,
                    ),
                    LabelledTextField(
                      hint: 'Password',
                      label: 'NEW PASSWORD',
                      controller: data.newPassword,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    LabelledTextField(
                      hint: 'Password',
                      label: 'CONFIRM PASSWORD',
                      controller: data.confirmPassword,
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(
            height: 16,
          ),
          Consumer<ProfileAPI>(builder: (context, api, chi9ld) {
            return CustomButton(
              text: loading ? 'loading' : 'Change password',
              onPressed: () async {
                if (_key.currentState?.validate() ?? false) {
                  setState(() {
                    loading = true;
                  });
                  bool success = await api.updatePassword(context);
                  setState(() {
                    loading = false;
                  });
                  if (success) {
                    Navigation.pop(context);
                  }
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
