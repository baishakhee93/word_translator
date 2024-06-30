import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  final String endpoint = 'https://api.mymemory.translated.net/get';

  Future<String> translate(String text, String targetLanguage) async {
    try {
      final response = await http.get(
        Uri.parse('$endpoint?q=$text&langpair=en|$targetLanguage'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('responseData')) {
          return jsonResponse['responseData']['translatedText'];
        } else {
          throw Exception('Translation failed: unexpected response format');
        }
      } else {
        throw Exception('Failed to translate text: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to translate text');
    }
  }
}
