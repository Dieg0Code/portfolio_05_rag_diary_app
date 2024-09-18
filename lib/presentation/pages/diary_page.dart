import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rag_diary_app/domain/usecases/create_diary.dart';
import 'package:rag_diary_app/domain/usecases/get_rag_response.dart';
import 'package:rag_diary_app/presentation/bloc/diary_bloc.dart';
import 'package:rag_diary_app/presentation/pages/diary_view.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diary'),
      ),
      body: BlocProvider(
        create: (context) => DiaryBloc(
          createDiary: context.read<CreateDiary>(),
          getRagResponse: context.read<GetRagResponse>(),
        ),
        child: const DiaryView(),
      ),
    );
  }
}
