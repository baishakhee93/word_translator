import 'package:flutter/material.dart';
import 'package:Word_Translator/services/TranslationService.dart';
import '../services/AppLocalizations.dart';
class TranslationScreen extends StatefulWidget {
  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _controller = TextEditingController();
  final TranslationService _translationService = TranslationService();
  String _translatedText = '';
  String _selectedLanguage = 'es'; // Default language is Spanish

  // Define your languages map here
  Map<String, String> _languages = {
    'English': 'en',
    'Spanish': 'es',
    'Hindi': 'hi',
    'Bengali': 'bn',
    // Add more languages as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Lenguage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: _languages.entries.map<DropdownMenuItem<String>>((entry) {
                return DropdownMenuItem<String>(
                  value: entry.value,
                  child: Text(entry.key),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final text = _controller.text;
                try {
                  final translated =
                  await _translationService.translate(text, _selectedLanguage);
                  setState(() {
                    _translatedText = translated;
                  });
                } catch (e) {
                  setState(() {
                    _translatedText = 'Error: ${e.toString()}';
                  });
                }
              },
              child: Text("Translet"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _translatedText,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
