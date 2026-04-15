import 'package:dio/dio.dart';
import '../models/item.dart';

// using jsonplaceholder as a free fake api for testing
class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));

  Future<List<Item>> getItems() async {
    try {
      // limit to 20 so the list isn't massive
      final response = await _dio.get('/todos', queryParameters: {'_limit': 20});
      final data = response.data as List<dynamic>;
      return data
          .map((json) => Item.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('getItems error: ${e.message}');
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
      throw Exception('createItem error: ${e.message}');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _dio.delete('/todos/$id');
    } on DioException catch (e) {
      throw Exception('deleteItem error: ${e.message}');
    }
  }
}
