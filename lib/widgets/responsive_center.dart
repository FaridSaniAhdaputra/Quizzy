import 'package:flutter/material.dart';

import '../utils/responsive.dart';

/// Memusatkan konten dan membatasi lebarnya supaya tidak melebar
/// berlebihan di tablet atau browser.
class ResponsiveCenter extends StatelessWidget {
  final Widget child;

  const ResponsiveCenter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
        child: child,
      ),
    );
  }
}
