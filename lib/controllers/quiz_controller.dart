import 'package:flutter/foundation.dart';

import '../data/quiz_data.dart';

/// Menyimpan seluruh progres kuis di luar widget, sehingga tidak hilang
/// saat layar diputar atau pengguna berpindah halaman.
class QuizController extends ChangeNotifier {
  String userName = '';
  int currentIndex = 0;
  bool _started = false;
  bool _finished = false;
  final Map<int, int> _answers = {};

  int get total => quizData.length;
  bool get inProgress => _started && !_finished;
  bool get isFirst => currentIndex == 0;
  bool get isLast => currentIndex == total - 1;
  int? get selectedAnswer => _answers[currentIndex];

  int get correctCount {
    int count = 0;
    _answers.forEach((index, answer) {
      if (quizData[index].correctAnswerIndex == answer) count++;
    });
    return count;
  }

  int get score => (correctCount * 100 / total).round();

  /// Memulai kuis baru. Jika masih ada kuis yang berjalan, dilanjutkan.
  void start(String name) {
    if (inProgress) return;
    reset();
    userName = name.trim();
    _started = true;
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    _answers[currentIndex] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (!isLast) {
      currentIndex++;
      notifyListeners();
    }
  }

  void previous() {
    if (!isFirst) {
      currentIndex--;
      notifyListeners();
    }
  }

  void finish() {
    _finished = true;
    notifyListeners();
  }

  void reset() {
    userName = '';
    currentIndex = 0;
    _started = false;
    _finished = false;
    _answers.clear();
    notifyListeners();
  }
}

/// Satu instance dipakai bersama oleh semua halaman.
final QuizController quizController = QuizController();
