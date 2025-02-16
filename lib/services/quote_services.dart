import 'package:http/http.dart' as http;
import 'dart:convert';

class QuoteService {
  Future<String> fetchQuote() async {
    final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data[0]['q'];
    } else {
      throw Exception('Failed to fetch quote');
    }
  }
}