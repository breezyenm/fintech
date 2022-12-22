import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/labelled_dropdown.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/models/state.dart';
import 'package:qwid/providers/API/profile.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/vtn.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  File? image;
  String? address, dob, phone, firstName, lastName, gender, zipcode;
  bool loading = false;

  @override
  void initState() {
    Provider.of<AuthData>(context, listen: false).clear();
    Provider.of<VTNData>(context, listen: false).clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
      ),
      body: Consumer3<AuthData, VTNAPI, VTNData>(
          builder: (context, auth, vtn, vtnData, child) {
        return ListView(
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
                    'Personal information',
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
            Container(
              decoration: BoxDecoration(
                color: CustomColors.white,
                border: Border.all(
                  color: CustomColors.stroke,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROFILE PICTURE',
                    style: CustomTextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.labelText.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    dashPattern: const [6, 6],
                    radius: const Radius.circular(5),
                    color: CustomColors.labelText,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () async {
                        if (Platform.isIOS) {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            withReadStream: true,
                            // allowedExtensions: ['jpg', 'png', 'jpeg'],
                          );
                          if (result != null) {
                            setState(() {
                              image = File(result.files.single.path!);
                            });
                          }
                        } else {
                          XFile? _image = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );
                          if (_image != null) {
                            setState(() {
                              image = File(_image.path);
                            });
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 96,
                        width: 96,
                        decoration: BoxDecoration(
                          image: image == null
                              ? (auth.user!.pix ?? '') == ''
                                  ? null
                                  : DecorationImage(
                                      image: NetworkImage(auth.user!.pix!),
                                      fit: BoxFit.cover,
                                    )
                              : DecorationImage(
                                  image: FileImage(image!),
                                  fit: BoxFit.cover,
                                ),
                          color: CustomColors.stroke,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: CustomIcon(
                          height: 24,
                          icon: 'camera',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Tap to change',
                    style: CustomTextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.darkPrimary.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    controller: auth.firstName,
                    onChanged: (value) {
                      firstName = value;
                    },
                    hint: auth.user!.firstName,
                    label: 'FIRST NAME',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    controller: auth.lastName,
                    onChanged: (value) {
                      lastName = value;
                    },
                    hint: auth.user!.lastName,
                    label: 'LAST NAME',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    enabled: false,
                    onTap: () async {
                      DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.tryParse(auth.user?.dob ?? '') ??
                            DateTime.now().subtract(
                              const Duration(
                                days: 365 * 18,
                              ),
                            ),
                        firstDate: DateTime(DateTime.now().year - 100),
                        lastDate: DateTime.now().subtract(
                          const Duration(
                            days: 365 * 18,
                          ),
                        ),
                      );
                      if (dateTime != null) {
                        auth.dob.text =
                            DateFormat(DateFormat.YEAR_NUM_MONTH_DAY)
                                .format(dateTime);
                      }
                    },
                    controller: auth.dob,
                    onChanged: (value) {
                      dob = value;
                    },
                    hint: auth.user!.dob,
                    label: 'DATE OF BIRTH',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledDropdown(
                    onChanged: (p0) {
                      setState(() {
                        gender = p0;
                      });
                    },
                    value: gender,
                    items: const ['Male', 'Female', 'Other'],
                    hint: auth.user?.sex ?? 'Select Gender',
                    label: 'GENDER',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    enabled: false,
                    controller: auth.email,
                    hint: auth.user!.email,
                    label: 'EMAIL ADDRESS',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    type: TextInputType.number,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    controller: auth.phone,
                    onChanged: (value) {
                      phone = value;
                    },
                    hint: auth.user!.phone,
                    label: 'PHONE',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder<List<Country>>(
                      future: vtn.getCountries(context),
                      builder: (context, snapshot) {
                        // if (snapshot.connectionState == ConnectionState.done) {
                        //   if (snapshot.data
                        //           ?.map((e) => e.name)
                        //           .contains(auth.user?.country) ??
                        //       false) {
                        //     vtnData.country = snapshot.data?.firstWhere(
                        //         (element) =>
                        //             element.name == auth.user?.country);
                        //   }
                        // }
                        return LabelledDropdown(
                          icon: snapshot.connectionState == ConnectionState.done
                              ? null
                              : const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 1.2,
                                    valueColor: AlwaysStoppedAnimation(
                                        CustomColors.primary),
                                  ),
                                ),
                          onChanged: (p0) {
                            vtnData.city = null;
                            vtnData.state = null;
                            vtnData.cities = [];
                            vtnData.states = [];
                            vtnData.country = snapshot.data
                                ?.firstWhere((element) => element.name == p0);
                          },
                          value: vtnData.country?.name,
                          items:
                              snapshot.data?.map((e) => e.name!).toList() ?? [],
                          hint: auth.user?.country?.toUpperCase() ??
                              'Country of residence',
                          label: 'COUNTRY',
                        );
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder<List<States>>(
                      future: vtnData.country == null
                          ? null
                          : vtn.getState(context, vtnData.country!.abbr!),
                      builder: (context, snapshot) {
                        return LabelledDropdown(
                          icon: snapshot.connectionState ==
                                      ConnectionState.done ||
                                  vtnData.country == null
                              ? null
                              : const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 1.2,
                                    valueColor: AlwaysStoppedAnimation(
                                        CustomColors.primary),
                                  ),
                                ),
                          onChanged: (p0) {
                            vtnData.city = null;
                            vtnData.cities = [];
                            vtnData.state = snapshot.data
                                ?.firstWhere((element) => element.name == p0);
                          },
                          value: vtnData.state?.name,
                          items: snapshot.data
                                  ?.map((e) => e.name ?? '')
                                  .toList() ??
                              [],
                          hint:
                              auth.user?.state?.toUpperCase() ?? 'Select State',
                          label: 'STATE',
                        );
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder<List<String>>(
                      future: (vtnData.country == null || vtnData.state == null)
                          ? null
                          : vtn.getCity(
                              context,
                              vtnData.country!.name!,
                              vtnData.state!.name!,
                            ),
                      builder: (context, snapshot) {
                        return LabelledDropdown(
                          icon: (snapshot.connectionState ==
                                      ConnectionState.done ||
                                  vtnData.country == null ||
                                  vtnData.state == null)
                              ? null
                              : const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 1.2,
                                    valueColor: AlwaysStoppedAnimation(
                                        CustomColors.primary),
                                  ),
                                ),
                          onChanged: (p0) {
                            vtnData.city = p0;
                          },
                          value: vtnData.city,
                          items: snapshot.data ?? [],
                          hint: auth.user?.city ?? 'Select City',
                          label: 'CITY',
                        );
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    controller: auth.address,
                    onChanged: (value) {
                      address = value;
                    },
                    hint: auth.user!.address,
                    label: 'ADDRESS',
                    minLines: 3,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LabelledTextField(
                    controller: auth.zipcode,
                    onChanged: (value) {
                      zipcode = value;
                    },
                    hint: auth.user!.zipcode.toString(),
                    label: 'ZIP CODE',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Consumer<ProfileAPI>(builder: (context, profileAPI, child) {
              return CustomButton(
                text: loading ? 'loading' : 'Save',
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  await profileAPI
                      .updateProfile(
                    image,
                    vtnData.country,
                    vtnData.state,
                    vtnData.city ?? auth.user?.city ?? '',
                    address ?? auth.user?.address ?? '',
                    dob ?? auth.user?.dob ?? '',
                    zipcode ?? auth.user?.zipcode?.toString() ?? '',
                    phone ?? auth.user?.phone ?? '',
                    firstName ?? auth.user?.firstName ?? '',
                    lastName ?? auth.user?.lastName ?? '',
                    gender ?? auth.user?.sex ?? '',
                    context,
                  )
                      .then((value) {
                    setState(() {
                      loading = false;
                    });
                    if (value) {
                      Navigation.pop(context);
                    }
                  });
                },
              );
            }),
          ],
        );
      }),
    );
  }
}
