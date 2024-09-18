abstract class DiaryRepository {
  Future<void> createEntry(String title, String content);
  Future<String> getRagResponse(String query);
}
