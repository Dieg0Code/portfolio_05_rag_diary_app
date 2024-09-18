import 'package:rag_diary_app/presentation/bloc/diary_event.dart';

class CreateDiaryEvent extends DiaryEvent {
  final String title;
  final String content;

  CreateDiaryEvent({required this.title, required this.content});
}
