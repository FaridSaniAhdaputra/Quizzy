import 'package:flutter/material.dart';

import '../data/quiz_data.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/option_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String userName;

  const QuizScreen({super.key, required this.userName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  // Menyimpan jawaban: nomor soal -> index pilihan
  final Map<int, int> _answers = {};

  bool get _isFirst => _currentIndex == 0;
  bool get _isLast => _currentIndex == quizData.length - 1;
  int? get _selectedAnswer => _answers[_currentIndex];

  void _selectAnswer(int optionIndex) {
    setState(() => _answers[_currentIndex] = optionIndex);
  }

  void _previous() {
    if (!_isFirst) setState(() => _currentIndex--);
  }

  void _onNext() {
    if (!_isLast) {
      setState(() => _currentIndex++);
      return;
    }
    int correct = 0;
    _answers.forEach((index, answer) {
      if (quizData[index].correctAnswerIndex == answer) correct++;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          userName: widget.userName,
          correctCount: correct,
          total: quizData.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final question = quizData[_currentIndex];
    final progress = (_currentIndex + 1) / quizData.length;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Soal ${_currentIndex + 1} / ${quizData.length}',
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
                'Hai, ${widget.userName}!',
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
                    selected: _selectedAnswer == i,
                    onPressed: () => _selectAnswer(i),
                  ),
                ),
              SizedBox(height: r.hp(0.01)),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Sebelumnya',
                      onPressed: _isFirst ? null : _previous,
                    ),
                  ),
                  SizedBox(width: r.wp(0.04)),
                  Expanded(
                    child: CustomButton(
                      text: _isLast ? 'Selesai' : 'Selanjutnya',
                      onPressed: _selectedAnswer == null ? null : _onNext,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
