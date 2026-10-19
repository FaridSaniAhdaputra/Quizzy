import 'package:flutter/material.dart';

import '../utils/responsive.dart';

/// Tombol pilihan jawaban. Berubah warna dan menampilkan centang
/// saat dipilih.
class OptionButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onPressed;

  const OptionButton({
    super.key,
    required this.text,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final radius = BorderRadius.circular(r.sp(12));

    return Material(
      color: selected ? primaryColor : Colors.transparent,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: r.wp(0.05),
            vertical: r.hp(0.02),
          ),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: primaryColor, width: 1.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: r.sp(16),
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : textColor,
                  ),
                ),
              ),
              if (selected)
                Icon(Icons.check_circle, color: Colors.white, size: r.sp(22)),
            ],
          ),
        ),
      ),
    );
  }
}
