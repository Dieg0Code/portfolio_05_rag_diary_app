import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rag_diary_app/presentation/bloc/diary_bloc.dart';
import 'package:rag_diary_app/presentation/bloc/diary_state.dart';
import 'package:rag_diary_app/presentation/widgets/diary_form.dart';

class DiaryView extends StatelessWidget {
  const DiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiaryBloc, DiaryState>(
      listener: (context, state) {
        if (state is DiaryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is DiarySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Diary created successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        return const Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DiaryForm(),
              ],
            ),
          ),
        );
      },
    );
  }
}
