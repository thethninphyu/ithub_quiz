import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Logger().e("SizeOfWithForClipper$size");
    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 20)
      ..quadraticBezierTo(0, size.height, 20, size.height)
      ..lineTo(size.width - 20, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, size.height - 20)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LoginCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Logger().e("SizeOfWithForClipper$size");
    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 20)
      ..quadraticBezierTo(0, size.height, 20, size.height)
      ..lineTo(size.width - 20, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, size.height - 20)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
