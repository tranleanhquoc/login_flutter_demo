import 'package:example/routes/locator.dart';
import 'package:example/routes/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertWidget {
  static void alertDefault(
      {Function onPress,
      String title = 'FLUTTER ALERT',
      String desc = 'Flutter is more awesome with RFlutter Alert.',
      AlertType type = AlertType.success}) {
    Alert(
      context: locator<NavigatorService>().currentContext(),
      type: type,
      title: title,
      style: AlertStyle(
          animationType: AnimationType.grow,
          titleStyle: GoogleFonts.roboto(fontSize: 24, color: Colors.black),
          descStyle: GoogleFonts.roboto(fontSize: 16, color: Colors.black)),
      desc: desc,
      buttons: [
        DialogButton(
          color: Colors.black,
          child: Text(
            'OK',
            style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
          ),
          onPressed: onPress ??
              () => Navigator.pop(locator<NavigatorService>().currentContext()),
        )
      ],
    ).show();
  }
}
