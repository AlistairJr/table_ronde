import 'dart:convert';
import 'package:http/http.dart' as http;

/// Model for GIF data from Tenor API
class TenorGifModel {
  final String id;
  final String title;
  final String previewUrl; // Small preview for grid
  final String fullUrl; // Full size for sending
  final int width;
  final int height;

  TenorGifModel({
    required this.id,
    required this.title,
    required this.previewUrl,
    required this.fullUrl,
    required this.width,
    required this.height,
  });

  /// Create from Tenor API response
  factory TenorGifModel.fromJson(Map<String, dynamic> json) {
    final media = json['media_formats'];

    return TenorGifModel(
      id: json['id'] ?? '',
      title: json['content_description'] ?? 'GIF',
      // Use tinygif for preview (smaller, faster loading)
      previewUrl: media?['tinygif']?['url'] ?? media?['gif']?['url'] ?? '',
      // Use gif for full quality when sending
      fullUrl: media?['gif']?['url'] ?? '',
      width: (media?['gif']?['dims']?[0] ?? 200).toInt(),
      height: (media?['gif']?['dims']?[1] ?? 200).toInt(),
    );
  }
}

/// Service to fetch GIFs from Tenor API
class TenorGifService {
  // API Key - Replace with your own from https://developers.google.com/tenor/guides/quickstart
  static const String _apiKey =
      'AIzaSyAyimkuYQYF_FXVALexPuGQctUWRURdCYQ'; // Demo key
  static const String _baseUrl = 'https://tenor.googleapis.com/v2';
  static const int _limit = 30; // GIFs per request

  /// Fetch trending GIFs
  static Future<List<TenorGifModel>> fetchTrending({int limit = _limit}) async {
    try {
      final url = Uri.parse(
          '$_baseUrl/featured?key=$_apiKey&limit=$limit&media_filter=gif');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => TenorGifModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load trending GIFs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching trending GIFs: $e');
      return [];
    }
  }

  /// Search GIFs by query
  static Future<List<TenorGifModel>> searchGifs(
    String query, {
    int limit = _limit,
  }) async {
    if (query.isEmpty) return fetchTrending(limit: limit);

    try {
      final url = Uri.parse(
        '$_baseUrl/search?key=$_apiKey&q=${Uri.encodeComponent(query)}&limit=$limit&media_filter=gif',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => TenorGifModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search GIFs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching GIFs: $e');
      return [];
    }
  }

  /// Get GIFs by category
  static Future<List<TenorGifModel>> fetchByCategory(
    String category, {
    int limit = _limit,
  }) async {
    return searchGifs(category, limit: limit);
  }

  /// Get suggested categories
  static List<String> getSuggestedCategories() {
    return [
      'Trending',
      'Funny',
      'Love',
      'Happy',
      'Sad',
      'Angry',
      'Wow',
      'Dance',
      'Hello',
      'Bye',
    ];
  }
}
