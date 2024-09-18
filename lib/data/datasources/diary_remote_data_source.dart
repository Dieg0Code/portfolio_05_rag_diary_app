import 'package:rag_diary_app/data/models/diary_model.dart';

abstract class DiaryRemoteDataSource {
  Future<void> createEntry(DiaryModel entry);
  Future<String> getRagResponse(String query);
}
