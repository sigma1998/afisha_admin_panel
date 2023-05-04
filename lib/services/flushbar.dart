import 'package:afisha_admin_panel/values/colors.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';


showCustomFlushBar (BuildContext context, String message) {
  Flushbar(
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(16),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    backgroundColor: AppColors.red,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    message:message,
  ).show(context).then((value) {
  });
}