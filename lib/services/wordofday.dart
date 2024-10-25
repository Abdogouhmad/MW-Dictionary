import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RandomWord {
  static const baseUrlWord = "https://api.api-ninjas.com/v1/randomword";
  late final String apiKey;
  late final String apiUrl;

  RandomWord() {
    apiKey = dotenv.env['WORD'] ?? 'API_KEY_NOT_FOUND';
    apiUrl = dotenv.env['MWD_API'] ?? 'API_KEY_NOT_FOUND';
    if (apiKey == 'API_KEY_NOT_FOUND' || apiUrl == 'API_KEY_NOT_FOUND') {
      throw Exception('API key or URL not found in .env file');
    }
  }

  Future<String> getRandomWord() async {
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

  Future<Map<String, dynamic>> defineRandomWord() async {
    final String word = await getRandomWord();
    final String url = "$apiUrl/$word";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey('data') &&
            data['data'] is List &&
            data['data'].isNotEmpty) {
          final Map<String, dynamic> result = data['data'][0];
          if (result['definition']['app-shortdef'] is Map<String, dynamic> &&
              result['ipa'] is Map<String, dynamic> &&
              result['definition']['app-shortdef']['def'] is List) {
            final Map<String, dynamic> def = {
              'word': word,
              'partofspch': result['definition']['app-shortdef']['fl'],
              'def': List<String>.from(
                  result['definition']['app-shortdef']['def']),
              'ipa': result['ipa']['prs'] is List &&
                      result['ipa']['prs'].isNotEmpty
                  ? result['ipa']['prs'][0]['ipa']
                  : result['ipa']['altprs'] is List &&
                          result['ipa']['altprs'].isNotEmpty
                      ? result['ipa']['altprs'][0]['ipa']
                      : "No Data for IPA",
            };
            return def;
          } else {
            throw Exception('Unexpected response format');
          }
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to get example. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Failed to get example");
    }
  }
}
