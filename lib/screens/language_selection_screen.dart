import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'skill_selection_screen.dart'; 

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'en'; // Default to English

  // Language options with icons
  final List<Map<String, String>> _languages = [
    {
      'code': 'en',
      'name': 'English',
      'nativeName': 'English',
      'icon': '🇬🇧',
      'subtitle': 'Select if you prefer English',
    },
    {
      'code': 'hi',
      'name': 'Hindi',
      'nativeName': 'हिंदी',
      'icon': '🇮🇳',
      'subtitle': 'अगर आप हिंदी पसंद करते हैं',
    },
    {
      'code': 'gu',
      'name': 'Gujarati',
      'nativeName': 'ગુજરાતી',
      'icon': '🪷',
      'subtitle': 'જો તમે ગુજરાતી પસંદ કરો છો',
    },
  ];

  void _onLanguageSelected(String code) {
    setState(() {
      _selectedLanguage = code;
    });
  }

  Future<void> _onContinuePressed() async {
    // Save selected language to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferred_language', _selectedLanguage);

    // Navigate to login screen
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Soft background
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6B46C1), Color(0xFF9F7AEA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.wb_sunny,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '🌱 KaamSetu',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose your language',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Language Selection Cards
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final lang = _languages[index];
                  final isSelected = _selectedLanguage == lang['code'];

                  return _LanguageCard(
                    icon: lang['icon']!,
                    name: lang['name']!,
                    nativeName: lang['nativeName']!,
                    subtitle: lang['subtitle']!,
                    isSelected: isSelected,
                    onTap: () => _onLanguageSelected(lang['code']!),
                  );
                },
              ),
            ),

            // Continue Button
            Container(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onContinuePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B46C1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Continue →',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Language Card Widget
class _LanguageCard extends StatelessWidget {
  final String icon;
  final String name;
  final String nativeName;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.icon,
    required this.name,
    required this.nativeName,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF6B46C1) : Colors.grey.shade200,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF6B46C1).withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6B46C1).withOpacity(0.1)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  icon,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nativeName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? const Color(0xFF6B46C1)
                          : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Checkmark for selected
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF6B46C1),
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}