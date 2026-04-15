import 'package:dio/dio.dart';
import '../models/item.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: _baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );

  Future<List<Item>> getItems() async {
    try {
      final response = await _dio.get('/todos', queryParameters: {'_limit': 20});
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => Item.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to load items: ${e.message}');
    }
  }

  Future<Item> createItem(String title) async {
    try {
      final response = await _dio.post('/todos', data: {
        'title': title,
        'createdAt': DateTime.now().toIso8601String(),
      });
      return Item.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to create item: ${e.message}');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _dio.delete('/todos/$id');
    } on DioException catch (e) {
      throw Exception('Failed to delete item: ${e.message}');
    }
  }
}
