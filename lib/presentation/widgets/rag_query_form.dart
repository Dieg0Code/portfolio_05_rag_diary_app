import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rag_diary_app/presentation/bloc/diary_bloc.dart';
import 'package:rag_diary_app/presentation/bloc/get_rag_response_event.dart';

class RagQueryForm extends StatefulWidget {
  const RagQueryForm({super.key});

  @override
  State<RagQueryForm> createState() => _RagQueryFormState();
}

class _RagQueryFormState extends State<RagQueryForm> {
  final _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Query RAG',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _queryController,
              decoration: const InputDecoration(
                  labelText: 'Query', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context
                    .read<DiaryBloc>()
                    .add(GetRagResponseEvent(query: _queryController.text));
                _queryController.clear();
              },
              child: const Text('Query'),
            ),
          ],
        ),
      ),
    );
  }
}
