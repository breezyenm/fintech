import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/text_field.dart';

class SearchList<String> extends StatefulWidget {
  final List<String> items;
  final List<String>? leading;
  const SearchList({Key? key, required this.items, this.leading})
      : super(key: key);

  @override
  State<SearchList<String>> createState() => _SearchListState<String>();
}

class _SearchListState<String> extends State<SearchList<String>> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: CustomTextField(
                hint: 'Search',
                controller: controller,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                children: widget.items
                    .where((element) => element
                        .toString()
                        .contains(controller.text.toUpperCase()))
                    .map(
                      (e) => ListTile(
                        onTap: () {
                          Navigation.popWithResult(
                            context,
                            e.toString(),
                          );
                        },
                        leading: widget.leading == null
                            ? null
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'icons/flags/png/${widget.leading?[widget.items.indexOf(e)]}.png',
                                  package: 'country_icons',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 32,
                                      height: 32,
                                      decoration: const BoxDecoration(
                                        color: CustomColors.stroke,
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  },
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        title: Text(
                          e.toString(),
                          style: const CustomTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: CustomColors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
