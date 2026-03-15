import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'ar';

  final List<Map<String, dynamic>> _languages = [
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦'},
    {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اللغة'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final lang = _languages[index];
          final isSelected = _selectedLanguage == lang['code'];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : null,
            child: ListTile(
              leading: Text(lang['flag'], style: const TextStyle(fontSize: 24)),
              title: Text(lang['name']),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: AppTheme.goldColor)
                  : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = lang['code'];
                });
              },
            ),
          );
        },
      ),
    );
  }
}
