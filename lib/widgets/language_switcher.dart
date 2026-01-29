import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/app_localization.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Language'),
      backgroundColor: const Color(0xFF1a1f3a),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLanguageButton(context, 'English', 'en'),
          _buildLanguageButton(context, '日本語', 'ja'),
          _buildLanguageButton(context, '한국어', 'ko'),
          _buildLanguageButton(context, '中文', 'zh'),
          _buildLanguageButton(context, 'हिंदी', 'hi'),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(
    BuildContext context,
    String label,
    String languageCode,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          MoonCalendarApp.setLocale(
            context,
            AppLocalization.getLocaleFromString(languageCode),
          );
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          minimumSize: const Size.fromHeight(45),
        ),
        child: Text(label),
      ),
    );
  }
}
