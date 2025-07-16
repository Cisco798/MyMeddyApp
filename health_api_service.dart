import 'dart:convert';
import 'package:http/http.dart' as http;

class HealthApiService {
  static const String _baseUrl = 'https://api.nutritionix.com/v1_1';
  static const String _appId = 'YOUR_APP_ID';
  static const String _appKey = 'YOUR_APP_KEY';

  Future<List<String>> fetchHealthTips() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.nutritionix.com/v1_1/search?query=health+tips'),
        headers: {'x-app-id': _appId, 'x-app-key': _appKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final hits = data['hits'] as List;
        return hits.map<String>((hit) => hit['fields']['item_name'] as String).toList();
      } else {
        throw Exception('Failed to load health tips');
      }
    } catch (e) {
      throw Exception('Failed to connect to API: $e');
    }
  }
}
