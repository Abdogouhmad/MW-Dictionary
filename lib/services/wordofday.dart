import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Test version of the service that uses flutter_dotenv
class RandomWord {
  static const baseUrlWord = "https://api.api-ninjas.com/v1/randomword";
  late final String apiKey;
  late final String apiUrl;

  void _wordServiceTest() {
    apiKey = dotenv.env['WORD'] ?? 'API_KEY_NOT_FOUND';
    apiUrl = dotenv.env['MWD_API'] ?? 'API_KEY_NOT_FOUND';
    if (apiKey == 'API_KEY_NOT_FOUND' && apiUrl == 'API_KEY_NOT_FOUND') {
      throw Exception('WORD API key not found in .env file');
    }
  }

  void _prettyPrintJson(String input) {
    const JsonDecoder decoder = JsonDecoder();
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final dynamic object = decoder.convert(input);
    final dynamic prettyString = encoder.convert(object);
    prettyString.split('\n').forEach((dynamic element) => print(element));
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

  // define generated word
  Future<Map<String, dynamic>> defineRandomWord() async {
    _wordServiceTest();

    try {
      final response = await http.get(Uri.parse(apiUrl));
      // _prettyPrintJson(response.body);
      if (response.statusCode == 200) {
        // parse the json
        final Map<String, dynamic> data = jsonDecode(response.body);
        // check the data if it has data as a key
        if (data.containsKey('data') &&
            data['data'] is List &&
            data['data'].isNotEmpty) {
          // greb the 1st array
          final Map<String, dynamic> result = data['data'][0];
          if (result['definition']['app-shortdef'] is Map<String, dynamic> &&
              result['ipa'] is Map<String, dynamic> &&
              result['definition']['app-shortdef']['def'] is List) {
            final Map<String, dynamic> def = {
              'partofspch': result['definition']['app-shortdef']['fl'],
              'def': result['definition']['app-shortdef']['def'],
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

// Future<void> main() async {
//   // Load environment variables from .env file
//   await dotenv.load(fileName: ".env");

//   final randomWordService = RandomWord();

//   try {
//     // Fetch the example
//     await randomWordService.defineRandomWord();
//     // print("Example is: $definition");
//   } catch (e) {
//     print("Error: $e");
//   }
// }
