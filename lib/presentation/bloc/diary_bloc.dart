import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rag_diary_app/core/error/exceptions.dart';
import 'package:rag_diary_app/domain/usecases/create_diary.dart';
import 'package:rag_diary_app/domain/usecases/get_rag_response.dart';
import 'package:rag_diary_app/presentation/bloc/create_diary_event.dart';
import 'package:rag_diary_app/presentation/bloc/diary_event.dart';
import 'package:rag_diary_app/presentation/bloc/diary_state.dart';
import 'package:rag_diary_app/presentation/bloc/get_rag_response_event.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final CreateDiary createDiary;
  final GetRagResponse getRagResponse;

  DiaryBloc({required this.createDiary, required this.getRagResponse})
      : super(DiaryInitial()) {
    on<CreateDiaryEvent>((event, emit) async {
      emit(DiaryLoading());
      try {
        await createDiary(event.title, event.content);
        emit(DiarySuccess());
      } on ServerException catch (e) {
        emit(DiaryError(message: '${e.statusCode}: ${e.message}'));
      } catch (e) {
        emit(DiaryError(message: e.toString()));
      }
    });

    on<GetRagResponseEvent>((event, emit) async {
      emit(DiaryLoading());
      try {
        final response = await getRagResponse(event.query);
        emit(RagResponseReceived(response: response));
      } on ServerException catch (e) {
        emit(DiaryError(message: '${e.statusCode}: ${e.message}'));
      } catch (e) {
        emit(DiaryError(message: e.toString()));
      }
    });
  }
}
