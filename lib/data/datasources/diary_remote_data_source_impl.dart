import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rag_diary_app/core/error/exceptions.dart';
import 'package:rag_diary_app/data/datasources/diary_remote_data_source.dart';
import 'package:rag_diary_app/data/models/base_response_model.dart';
import 'package:rag_diary_app/data/models/diary_model.dart';

class DiaryRemoteDataSourceImpl implements DiaryRemoteDataSource {
  final http.Client client;
  final String baseUrl =
      'https://7m5vu6grr1.execute-api.sa-east-1.amazonaws.com/dev/api/v1';

  DiaryRemoteDataSourceImpl({required this.client});

  @override
  Future<void> createEntry(DiaryModel entry) async {
    final response = await client.post(
      Uri.parse('$baseUrl/diary'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(entry.toJson()),
    );

    final baseResponse = BaseResponseModel<String>.fromJson(
      json.decode(response.body),
      (data) => data as String,
    );

    if (baseResponse.code != 201) {
      throw ServerException(
          message: baseResponse.msg, statusCode: baseResponse.code);
    }
  }

  @override
  Future<String> getRagResponse(String query) async {
    final response = await client.post(
      Uri.parse('$baseUrl/diary/rag-response'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'query': query}),
    );

    final baseResponse = BaseResponseModel<String>.fromJson(
      json.decode(response.body),
      (data) => data as String,
    );

    if (baseResponse.code != 200) {
      throw ServerException(
          message: baseResponse.msg, statusCode: baseResponse.code);
    }

    return baseResponse.data;
  }
}
