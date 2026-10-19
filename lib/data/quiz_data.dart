import '../models/question_model.dart';

final List<Question> quizData = [
  Question(
    questionText: 'Bahasa pemrograman apa yang digunakan dalam Flutter?',
    options: ['Python', 'Dart', 'Java', 'HTML'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText:
        'Widget apa yang digunakan untuk menampilkan tulisan/teks di layar?',
    options: ['Text', 'Image', 'Container', 'Column'],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Apa ekstensi file kode pemrograman untuk Flutter?',
    options: ['.html', '.css', '.dart', '.apk'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: ' Widget apa yang digunakan untuk menampilkan gambar?',
    options: [' Text', ' Image', 'Row', 'Icon'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Widget layout apa yang digunakan untuk menyusun komponen ke bawah (vertikal)?',
    options: ['Row', 'Column', 'Center', 'Padding'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Widget layout apa yang digunakan untuk menyusun komponen ke samping (horizontal)?',
    options: ['Row', ' Column', 'Container', ' Scaffold'],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'File apa yang digunakan untuk mendaftarkan aset seperti gambar atau font di Flutter?',
    options: ['main.dart', 'pubspec.yaml', ' index.html', 'android.xml'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Apa nama fitur Flutter yang bisa menampilkan perubahan kode di HP secara instan tanpa restart?',
    options: ['Hot Reload', 'Hot Restart', 'Auto Save', 'Fast Build'],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Jenis widget yang tampilannya tetap (statis) dan tidak bisa berubah nilainya saat aplikasi berjalan adalah...',
    options: [
      'StatelessWidget',
      'StatefulWidget',
      'DynamicWidget',
      ' MutableWidget',
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Jenis widget yang tampilannya bisa berubah secara dinamis (misal angka counter bertambah) adalah...',
    options: [
      'StatelessWidget',
      'StatefulWidget',
      'StaticWidget',
      ' ConstantWidget',
    ],
    correctAnswerIndex: 1,
  ),
];
