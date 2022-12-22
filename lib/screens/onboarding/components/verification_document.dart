import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/style.dart';
// import 'package:qwid/assets/toast.dart';
import 'package:qwid/models/document.dart';
import 'package:qwid/providers/data/auth.dart';

class VerificationDocument extends StatefulWidget {
  final Document document;
  const VerificationDocument({Key? key, required this.document})
      : super(key: key);

  @override
  State<VerificationDocument> createState() => _VerificationDocumentState();
}

class _VerificationDocumentState extends State<VerificationDocument> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<AuthData>(builder: (context, data, chi9ld) {
            return GestureDetector(
              onTap: () async {
                // Functions.toast(
                //   'button tapped',
                //   context,
                // );
                if (data.supportedFiles[widget.document.id!] == null) {
                  // Functions.toast(
                  //   'if statement passed',
                  //   context,
                  // );
                  if (Platform.isIOS) {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      withReadStream: true,
                      // allowedExtensions: ['jpg', 'png', 'jpeg'],
                    );
                    if (result != null) {
                      setState(() {
                        data.supportedFiles[widget.document.id ?? ''] =
                            File(result.files.single.path!);
                      });
                    }
                  } else {
                    XFile? image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      setState(() {
                        data.supportedFiles[widget.document.id ?? ''] =
                            File(image.path);
                      });
                    }
                  }
                  // Functions.toast(
                  //   'image gotten',
                  //   context,
                  // );
                  // Functions.toast(
                  //   'No image selected',
                  //   context,
                  // );
                } else {
                  setState(() {
                    data.supportedFiles.remove(widget.document.id!);
                  });
                  // Functions.toast(
                  //   'image removed',
                  //   context,
                  // );
                }
              },
              child: data.supportedFiles[widget.document.id!] == null
                  ? DottedBorder(
                      dashPattern: [8, 8],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      color: CustomColors.darkPrimary,
                      child: Container(
                        alignment: Alignment.center,
                        // height: MediaQuery.of(context).size.width - 64,
                        // width: MediaQuery.of(context).size.width - 64,
                        decoration: BoxDecoration(
                          color: CustomColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIcon(
                              height: 24,
                              icon: 'upload',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.document.name ?? '',
                              style: const CustomTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: CustomColors.labelText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Image.file(
                          data.supportedFiles[widget.document.id]!,
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              color: CustomColors.black.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: CustomColors.red,
                              size: 16,
                            ),
                          ),
                        )
                      ],
                    ),
            );
          }),
        ),
      ],
    );
  }
}
