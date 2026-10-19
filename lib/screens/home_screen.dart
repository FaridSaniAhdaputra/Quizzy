import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan nama kamu terlebih dahulu!'),
        ),
      );
      return;
    }
    // Sementara hanya notifikasi, halaman kuis dibuat di tahap berikutnya
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Siap, ${_nameController.text.trim()}! Kuis segera dimulai...',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: r.wp(0.08),
              vertical: r.hp(0.05),
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
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _startQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(r.sp(12)),
                      ),
                    ),
                    child: Text(
                      'Mulai Kuis',
                      style: TextStyle(
                        fontSize: r.sp(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
