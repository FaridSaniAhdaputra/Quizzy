import 'package:flutter/material.dart';

import '../controllers/quiz_controller.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/responsive_center.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          child: Center(
            // Bisa di-scroll agar tidak overflow saat layar landscape
            child: SingleChildScrollView(
              padding: EdgeInsets.all(r.wp(0.06)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.emoji_events_rounded,
                    size: r.sp(100),
                    color: primaryColor,
                  ),
                  SizedBox(height: r.hp(0.02)),
                  Text(
                    'Kuis Selesai!',
                    style: TextStyle(
                      fontSize: r.sp(28),
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.hp(0.01)),
                  Text(
                    'Terima kasih telah bermain,\n${quizController.userName}!',
                    style: TextStyle(
                      fontSize: r.sp(18),
                      color: textColor.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.hp(0.04)),
                  Container(
                    padding: EdgeInsets.all(r.wp(0.06)),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(r.sp(16)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Skor Akhir Anda',
                          style: TextStyle(
                            fontSize: r.sp(16),
                            color: textColor.withValues(alpha: 0.7),
                          ),
                        ),
                        SizedBox(height: r.hp(0.01)),
                        Text(
                          '${quizController.score}',
                          style: TextStyle(
                            fontSize: r.sp(60),
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          '${quizController.correctCount} benar dari ${quizController.total} soal',
                          style: TextStyle(
                            fontSize: r.sp(14),
                            color: textColor.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: r.hp(0.04)),
                  CustomButton(
                    text: 'Kembali ke Beranda',
                    onPressed: () {
                      quizController.reset();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
