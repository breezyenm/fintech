import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/providers/API/beneficiary.dart';
import 'package:qwid/providers/data/beneficiary.dart';
import 'package:qwid/screens/home/pages/beneficiary/edit_beneficiary.dart';

class AddBeneficiary extends StatefulWidget {
  const AddBeneficiary({Key? key}) : super(key: key);

  @override
  State<AddBeneficiary> createState() => _AddBeneficiaryState();
}

class _AddBeneficiaryState extends State<AddBeneficiary> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Beneficiary',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 44),
        children: [
          const EditBeneficiary(),
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Consumer2<BeneficiaryData, BeneficiaryAPI>(
                  builder: (context, data, api, chi9ld) {
                return CustomButton(
                  text: loading ? 'loading' : 'Add Beneficiary',
                  onPressed: () async {
                    if (data.formKey.currentState?.validate() ?? false) {
                      setState(() {
                        loading = true;
                      });
                      await api
                          .addBeneficiary(
                        context: context,
                      )
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                        if (value) {
                          Navigation.pop(context);
                        }
                      });
                    }
                  },
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
