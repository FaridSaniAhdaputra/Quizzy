import 'package:flutter/material.dart';

import '../controllers/quiz_controller.dart';
import '../data/quiz_data.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/option_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  void _onNext(BuildContext context) {
    if (quizController.isLast) {
      quizController.finish();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResultScreen()),
      );
    } else {
      quizController.next();
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return ListenableBuilder(
      listenable: quizController,
      builder: (context, _) {
        final question = quizData[quizController.currentIndex];
        final progress =
            (quizController.currentIndex + 1) / quizController.total;

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Soal ${quizController.currentIndex + 1} / ${quizController.total}',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: r.sp(18),
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(r.wp(0.06)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Hai, ${quizController.userName}!',
                    style: TextStyle(
                      fontSize: r.sp(16),
                      color: textColor.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.hp(0.015)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(r.sp(8)),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: r.sp(8),
                      color: primaryColor,
                      backgroundColor: primaryColor.withValues(alpha: 0.15),
                    ),
                  ),
                  SizedBox(height: r.hp(0.04)),
                  Text(
                    question.questionText,
                    style: TextStyle(
                      fontSize: r.sp(22),
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.hp(0.04)),
                  for (int i = 0; i < question.options.length; i++)
                    Padding(
                      padding: EdgeInsets.only(bottom: r.hp(0.02)),
                      child: OptionButton(
                        text: question.options[i],
                        selected: quizController.selectedAnswer == i,
                        onPressed: () => quizController.selectAnswer(i),
                      ),
                    ),
                  SizedBox(height: r.hp(0.01)),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Sebelumnya',
                          onPressed: quizController.isFirst
                              ? null
                              : quizController.previous,
                        ),
                      ),
                      SizedBox(width: r.wp(0.04)),
                      Expanded(
                        child: CustomButton(
                          text: quizController.isLast
                              ? 'Selesai'
                              : 'Selanjutnya',
                          onPressed: quizController.selectedAnswer == null
                              ? null
                              : () => _onNext(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
