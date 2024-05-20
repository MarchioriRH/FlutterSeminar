import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

/// {@template api_client}
/// An http API client
/// {@endtemplate}
class ApiClient {
  /// {@macro api_client}
  ApiClient({
    required String baseUrl,
    Client? client,
  })  : _baseUrl = baseUrl,
        _client = client ?? Client();

  final String _baseUrl;
  final Client _client;

  Future<Map<String, String>> _getRequestHeaders() async {
    return <String, String>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
    };
  }

  
  /// GET /api/v1/products
  ///
  /// Get the list of products
  Future<Map<String, dynamic>> getProducts() async {
    final uri = Uri.parse('$_baseUrl/api/v1/products');
    final headers = await _getRequestHeaders();

    final response = await _client.get(
      uri,
      headers: headers,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Error();
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data;
  }

  /// GET /api/v1/products/:id
  ///
  /// Get a single product by id
  Future<Map<String, dynamic>> getProductById({
    required String id,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/products/$id');
    final headers = await _getRequestHeaders();

    final response = await _client.get(
      uri,
      headers: headers,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Error();
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data;
  }
}
