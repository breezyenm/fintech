import 'package:flutter/material.dart';
import 'package:qwid/assets/buttons/option_button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/beneficiary.dart';
import 'package:qwid/providers/API/beneficiary.dart';
import 'package:provider/provider.dart';
import 'package:qwid/providers/data/beneficiary.dart';
import 'package:qwid/screens/home/components/beneficiary_card.dart';
import 'package:qwid/screens/home/pages/beneficiary/add_beneficiary.dart';
import 'package:qwid/screens/home/pages/beneficiary/beneficiary_info.dart';

class BeneficiaryPage extends StatefulWidget {
  final Function(Beneficiary beneficiary)? onTap;
  const BeneficiaryPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<BeneficiaryPage> createState() => _BeneficiaryPageState();
}

class _BeneficiaryPageState extends State<BeneficiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<BeneficiaryAPI, BeneficiaryData>(
      builder: (context, api, data, chi9ld) {
        return FutureBuilder<List<Beneficiary>>(
          future: api.getBeneficiary(0, 10, context),
          builder: (context, snapshot) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: OptionButton(
                      onPressed: () async {
                        await Navigation.push(
                          const AddBeneficiary(),
                          context,
                        );
                        setState(() {
                          data.beneficiaries = null;
                        });
                      },
                      text: 'New Beneficiary',
                      subtext:
                          'Add a new individual or business to your beneficiary list',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Text(
                      'Beneficiaries',
                      style: CustomTextStyle(
                        color: CustomColors.text,
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: data.beneficiaries == null
                        ? const Center(
                            child: SizedBox(
                              height: 12,
                              width: 12,
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 1.2,
                                valueColor: AlwaysStoppedAnimation(
                                    CustomColors.primary),
                              ),
                            ),
                          )
                        : (data.beneficiaries ?? []).isEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const Text(
                                      'Empty',
                                      style: CustomTextStyle(
                                        color: CustomColors.text,
                                        fontFamily: 'Montserrat',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "You've not added any beneficiary, add one now to continue",
                                      style: CustomTextStyle(
                                        color:
                                            CustomColors.text.withOpacity(0.5),
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : ListView.separated(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 44),
                                itemBuilder: (context, index) =>
                                    BeneficiaryCard(
                                  beneficiary: data.beneficiaries![index],
                                  onTap: widget.onTap != null
                                      ? () async {
                                          widget.onTap!(
                                              data.beneficiaries![index]);
                                        }
                                      : () async {
                                          await Navigation.push(
                                            BeneficiaryInfo(
                                              beneficiary:
                                                  data.beneficiaries![index],
                                            ),
                                            context,
                                          );
                                          setState(() {
                                            data.beneficiaries = null;
                                          });
                                        },
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 16,
                                ),
                                itemCount: (data.beneficiaries ?? []).length,
                              ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
