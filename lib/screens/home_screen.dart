import 'package:flutter/material.dart';

import '../controllers/quiz_controller.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
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

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final inProgress = quizController.inProgress;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: r.wp(0.08),
              vertical: r.hp(0.03),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
    );
  }
}
