abstract class DiaryState {}

class DiaryInitial extends DiaryState {}

class DiaryLoading extends DiaryState {}

class DiarySuccess extends DiaryState {}

class RagResponseReceived extends DiaryState {
  final String response;

  RagResponseReceived({required this.response});
}

class DiaryError extends DiaryState {
  final String message;

  DiaryError({required this.message});
}
