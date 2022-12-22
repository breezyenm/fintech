import 'package:flutter/material.dart';

class Navigation {
  static void pop(
    BuildContext context,
  ) {
    Navigator.of(context).pop();
  }

  static void popWithResult(
    BuildContext context,
    dynamic result,
  ) {
    Navigator.of(context).pop(result);
  }

  static Future<dynamic> push(
    Widget route,
    BuildContext context,
  ) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => route,
      ),
    );
  }

  static Future replace(
    Widget route,
    BuildContext context,
  ) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => route,
      ),
    );
  }

  static Future replaceAll(
    Widget route,
    BuildContext context,
  ) async {
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => route,
        ),
        (route) => false);
  }

  static void popAll(
    BuildContext context,
  ) async {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
