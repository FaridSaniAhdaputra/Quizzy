import 'dart:math' as math;

import 'package:flutter/material.dart';

class Responsive {
  static const double maxContentWidth = 600;

  final double width;
  final double height;

  Responsive._(this.width, this.height);

  factory Responsive.of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Responsive._(size.width, size.height);
  }

  double get contentWidth => math.min(width, maxContentWidth);

  /// Persentase dari lebar konten.
  double wp(double percent) => contentWidth * percent;

  /// Persentase dari tinggi layar.
  double hp(double percent) => height * percent;

  /// Ukuran font / ikon yang ikut menyesuaikan lebar konten.
  double sp(double base) => base * (contentWidth / 390).clamp(0.9, 1.25);
}
