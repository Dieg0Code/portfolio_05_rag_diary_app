import 'package:rag_diary_app/domain/repositories/diary_repository.dart';

class CreateDiary {
  final DiaryRepository repository;

  CreateDiary(this.repository);

  Future<void> call(String title, String content) async {
    return await repository.createEntry(title, content);
  }
}
