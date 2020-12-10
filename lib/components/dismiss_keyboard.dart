import 'package:flutter/material.dart';

void dismissKeyboard(BuildContext context) {
  return FocusScope.of(context).requestFocus(FocusNode());
}
