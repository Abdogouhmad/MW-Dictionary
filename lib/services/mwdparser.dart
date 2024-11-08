import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Mwdparser {
  late final String word;
  late final String mwdApiKey;
  static const String baseUrl =
      "https://dictionaryapi.com/api/v3/references/learners/json";

  Mwdparser(this.word) {
    mwdApiKey = dotenv.env["MWD"] ?? "NO KEY";
    if (word.isEmpty) {
      throw Exception("Empty word");
    }
    if (mwdApiKey == "NO KEY") {
      throw Exception("No key found");
    }
  }

  // Method to fetch data from the API
  Future<Map<String, dynamic>> fetchDefinition() async {
    final url = "$baseUrl/$word?key=$mwdApiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load definition");
    }
  }
}
