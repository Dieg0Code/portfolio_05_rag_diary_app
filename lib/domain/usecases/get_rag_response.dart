import 'package:rag_diary_app/domain/repositories/diary_repository.dart';

class GetRagResponse {
  final DiaryRepository repository;

  GetRagResponse(this.repository);

  Future<String> call(String query) async {
    return await repository.getRagResponse(query);
  }
}
