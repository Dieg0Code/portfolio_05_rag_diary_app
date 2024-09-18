import 'package:rag_diary_app/presentation/bloc/diary_event.dart';

class GetRagResponseEvent extends DiaryEvent {
  final String query;

  GetRagResponseEvent({required this.query});
}
