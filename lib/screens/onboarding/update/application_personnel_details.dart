import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/labelled_dropdown.dart';
import 'package:qwid/assets/dropdown/search_dropdown.dart';
import 'package:qwid/assets/dropdown/search_list.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/data/auth.dart';
import 'package:qwid/providers/data/vtn.dart';

class ApplicationPersonnelDetails extends StatefulWidget {
  const ApplicationPersonnelDetails({Key? key}) : super(key: key);

  @override
  State<ApplicationPersonnelDetails> createState() =>
      _ApplicationPersonnelDetailsState();
}

class _ApplicationPersonnelDetailsState
    extends State<ApplicationPersonnelDetails> {
  String? address, dob, phone, firstName, lastName, gender, zipcode;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthData, VTNAPI, VTNData>(
        builder: (context, auth, vtn, vtnData, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 24,
              ),
              Text(
                'Application Personnel Details',
                style: CustomTextStyle(
                  color: CustomColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.fullName,
            onChanged: (value) {
              firstName = value;
            },
            label: 'FULL NAME',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.businessApplicantPosition,
            onChanged: (value) {
              lastName = value;
            },
            hint: 'Director, Shareholder',
            label: 'DESIGNATION',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            enabled: false,
            onTap: () async {
              DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now(),
              );
              if (dateTime != null) {
                auth.businessApplicantPositionStartDate.text =
                    DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(dateTime);
              }
            },
            controller: auth.businessApplicantPositionStartDate,
            onChanged: (value) {
              dob = value;
            },
            label: 'DATE OF APPOINTMENT (DESIGNATION)',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            enabled: false,
            onTap: () async {
              DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
              );
              if (dateTime != null) {
                auth.businessApplicantPositionEndDate.text =
                    DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(dateTime);
              }
            },
            controller: auth.businessApplicantPositionEndDate,
            onChanged: (value) {
              dob = value;
            },
            label: 'DATE OF TERMINATION (DESIGNATION) (Optional)',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledDropdown(
            onChanged: (p0) {
              setState(() {
                auth.businessApplicantDocumentType = p0;
              });
            },
            value: auth.businessApplicantDocumentType,
            items: const ['National ID', 'Passport', 'Driver\'s License'],
            hint: 'Select',
            label: 'TYPE OF IDENTITY',
          ),
          const SizedBox(
            height: 16,
          ),
          // Text(
          //   'UPLOAD PROOF OF IDENTITY',
          //   style: CustomTextStyle(
          //     fontSize: 11,
          //     fontWeight: FontWeight.w500,
          //     color: CustomColors.labelText.withOpacity(0.5),
          //   ),
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          // DottedBorder(
          // dashPattern: [8, 8],
          // borderType: BorderType.RRect,
          //   radius: const Radius.circular(8),
          //   color: CustomColors.darkPrimary,
          //   child: Container(
          //     alignment: Alignment.center,
          //     height: MediaQuery.of(context).size.width - 64,
          //     width: MediaQuery.of(context).size.width - 64,
          //     decoration: BoxDecoration(
          //       color: CustomColors.white,
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: CustomIcon(
          //       height: 24,
          //       icon: 'upload',
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            controller: auth.businessApplicantDocumentNumber,
            onChanged: (value) {
              lastName = value;
            },
            label: 'IDENTITY NUMBER',
          ),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder<List<Country>>(
              future: vtn.getCountries(context),
              builder: (context, snapshot) {
                return InkWell(
                  onTap: () async {
                    if ((snapshot.data ?? []).isNotEmpty) {
                      String country = await Navigation.push(
                        SearchList(
                          leading: (snapshot.data ?? [])
                              .map((e) => e.abbr?.toLowerCase() ?? '')
                              .toList(),
                          items: (snapshot.data ?? [])
                              .map((e) => e.name ?? '')
                              .toList(),
                        ),
                        context,
                      );
                      auth.businessApplicantDocumentIssueCountry =
                          (snapshot.data ?? [])
                              .firstWhere((element) => element.name == country);
                    } else {
                      setState(() {});
                    }
                  },
                  child: SearchDropdown(
                    icon: snapshot.connectionState == ConnectionState.done ||
                            (snapshot.data ?? []).isNotEmpty
                        ? null
                        : const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 1.2,
                              valueColor:
                                  AlwaysStoppedAnimation(CustomColors.primary),
                            ),
                          ),
                    hint: 'Select Country',
                    label: 'ISSUING COUNTRY',
                    leading: auth.businessApplicantDocumentIssueCountry?.abbr
                        ?.toLowerCase(),
                    text: auth.businessApplicantDocumentIssueCountry?.name,
                  ),
                );
                // LabelledDropdown(
                //   icon: snapshot.connectionState == ConnectionState.done
                //       ? null
                //       : const SizedBox(
                //           height: 24,
                //           width: 24,
                //           child: CircularProgressIndicator.adaptive(
                //             strokeWidth: 1.2,
                //             valueColor:
                //                 AlwaysStoppedAnimation(CustomColors.primary),
                //           ),
                //         ),
                //   onChanged: (p0) {
                //     auth.businessApplicantDocumentIssueCountry = snapshot.data
                //         ?.firstWhere((element) => element.name == p0);
                //   },
                //   value: auth.businessApplicantDocumentIssueCountry?.name,
                //   items: snapshot.data?.map((e) => e.name!).toList() ?? [],
                //   hint: 'Select Country',
                //   label: 'ISSUING COUNTRY',
                // );
              }),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            enabled: false,
            onTap: () async {
              DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now(),
              );
              if (dateTime != null) {
                auth.businessApplicantDocumentIssuedDate.text =
                    DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(dateTime);
              }
            },
            controller: auth.businessApplicantDocumentIssuedDate,
            onChanged: (value) {
              dob = value;
            },
            label: 'IDENTITY ISSUE DATE',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledTextField(
            textInputAction: TextInputAction.next,
            enabled: false,
            onTap: () async {
              DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now(),
              );
              if (dateTime != null) {
                auth.businessApplicantDocumentExpiryDate.text =
                    DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(dateTime);
              }
            },
            controller: auth.businessApplicantDocumentExpiryDate,
            onChanged: (value) {
              dob = value;
            },
            label: 'IDENTITY EXPIRY DATE',
          ),
          const SizedBox(
            height: 16,
          ),
          LabelledDropdown(
            onChanged: (p0) {
              setState(() {
                auth.businessApplicantisPep = p0;
              });
            },
            value: auth.businessApplicantisPep,
            items: const [
              'Yes',
              'No',
            ],
            hint: 'Select',
            label: 'Is the application staff a PEP?',
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );
    });
  }
}
