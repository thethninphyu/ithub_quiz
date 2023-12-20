import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static AwesomeDialog createConfirmationDialog({
    required BuildContext context,
    required String title,
    required double width,
    required DialogType dialogType,
    required String description,
    bool showCancelButton = true,
    required Function() onOkPressed,
  }) {
    return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      width: width,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      title: title,
      desc: description,
      showCloseIcon: true,
      btnCancelOnPress: showCancelButton ? (() {}) : null,
      btnOkOnPress: onOkPressed,
    );
  }
}
