import 'package:flutter/material.dart';

class ScrollableFullPage extends ListView {
  ScrollableFullPage({Key? key, required List<Widget> children})
      : super(
          key: key,
          children: children,
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 44),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        );
}
