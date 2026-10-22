import 'package:flutter/material.dart';

import '../controllers/quiz_controller.dart';
import '../data/quiz_data.dart';
import '../main.dart'; // Akses themeNotifier
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/responsive_center.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Jika ada kuis yang belum selesai, tampilkan kembali namanya
    if (quizController.inProgress) {
      _nameController.text = quizController.userName;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (!quizController.inProgress) {
      if (_nameController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Silakan masukkan nama kamu terlebih dahulu!'),
          ),
        );
        return;
      }
      quizController.start(_nameController.text);
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuizScreen()),
    ).then((_) {
      // Saat kembali dari kuis, perbarui teks tombol (Mulai / Lanjutkan)
      if (mounted) setState(() {});
    });
  }

  void _showInstructions(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final pointPerQuestion = (100 / quizData.length).round();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: primaryColor),
              const SizedBox(width: 8),
              const Flexible(
                child: Text(
                  'Petunjuk Bermain',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              '1. Masukkan nama kamu.\n'
              '2. Tekan tombol "Mulai Kuis".\n'
              '3. Pilih jawaban, lalu tekan "Selanjutnya".\n'
              '4. Kamu bisa kembali ke soal sebelumnya.\n'
              '5. Setiap jawaban benar bernilai $pointPerQuestion poin.\n'
              '6. Lihat skor akhirmu di akhir!\n\n'
              'Semoga berhasil!',
              style: const TextStyle(height: 1.5, fontSize: 14),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Paham',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final inProgress = quizController.inProgress;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: r.wp(0.08),
                vertical: r.hp(0.03),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          color: primaryColor,
                          size: r.sp(28),
                        ),
                        onPressed: () {
                          themeNotifier.value = isDarkMode
                              ? ThemeMode.light
                              : ThemeMode.dark;
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.help_outline,
                          color: primaryColor,
                          size: r.sp(28),
                        ),
                        onPressed: () => _showInstructions(context),
                      ),
                    ],
                  ),
                  Text(
                    'Quizzy',
                    style: TextStyle(
                      fontSize: r.sp(32),
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: r.hp(0.01)),
                  Text(
                    'Uji pengetahuanmu sekarang!',
                    style: TextStyle(
                      fontSize: r.sp(16),
                      color: textColor.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(height: r.hp(0.08)),
                  Text(
                    'Nama Kamu',
                    style: TextStyle(
                      fontSize: r.sp(16),
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: r.hp(0.01)),
                  TextField(
                    controller: _nameController,
                    // Nama dikunci selama kuis masih berjalan
                    enabled: !inProgress,
                    style: TextStyle(color: textColor, fontSize: r.sp(16)),
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama...',
                      hintStyle: TextStyle(
                        color: textColor.withValues(alpha: 0.4),
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(r.sp(12)),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.person, color: primaryColor),
                    ),
                  ),
                  SizedBox(height: r.hp(0.08)),
                  CustomButton(
                    text: inProgress ? 'Lanjutkan Kuis' : 'Mulai Kuis',
                    fontSize: 18,
                    onPressed: _startQuiz,
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
