import 'package:flutter/material.dart';

SnackBar snackBarWidget(String content, {Color? color, Duration? duration}) {
  return SnackBar(
    duration: duration ?? const Duration(seconds: 4),
    content: Text(
      content,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: color ?? Colors.red,
    behavior: SnackBarBehavior.floating,
  );
}
