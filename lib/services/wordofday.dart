import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Test version of the service that uses flutter_dotenv
class RandomWord {
  static const baseUrlWord = "https://api.api-ninjas.com/v1/randomword";
  late final String apiKey;

  void _wordServiceTest() {
    apiKey = dotenv.env['WORD'] ?? 'API_KEY_NOT_FOUND';
    if (apiKey == 'API_KEY_NOT_FOUND') {
      throw Exception('WORD API key not found in .env file');
    }
  }

  Future<String> getRandomWord() async {
    _wordServiceTest();
    try {
      final response = await http.get(
        Uri.parse(baseUrlWord),
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey('word') && data['word'] is List) {
          List<String> words = List<String>.from(data['word']);
          return words[0]; // Return the first word from the list
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to get random word. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching random word: $e');
    }
  }
}
