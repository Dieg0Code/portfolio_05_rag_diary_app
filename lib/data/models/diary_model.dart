class DiaryModel {
  final String title;
  final String content;

  DiaryModel({required this.title, required this.content});

  factory DiaryModel.fromJson(Map<String, dynamic> json) {
    return DiaryModel(
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}
