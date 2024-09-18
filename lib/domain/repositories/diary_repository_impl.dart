import 'package:rag_diary_app/data/datasources/diary_remote_data_source.dart';
import 'package:rag_diary_app/data/models/diary_model.dart';
import 'package:rag_diary_app/domain/repositories/diary_repository.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryRemoteDataSource remoteDataSource;

  DiaryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createEntry(String title, String content) async {
    final diaryModel = DiaryModel(title: title, content: content);
    await remoteDataSource.createEntry(diaryModel);
  }

  @override
  Future<String> getRagResponse(String query) async {
    return await remoteDataSource.getRagResponse(query);
  }
}
