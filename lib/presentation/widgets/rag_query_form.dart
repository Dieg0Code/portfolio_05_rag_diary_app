import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rag_diary_app/presentation/bloc/diary_bloc.dart';
import 'package:rag_diary_app/presentation/bloc/get_rag_response_event.dart';

class RagQueryForm extends StatefulWidget {
  final Function(String query) onQuerySubmitted;

  const RagQueryForm({super.key, required this.onQuerySubmitted});

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

  void _submitQuery(String query) {
    if (query.isNotEmpty) {
      widget.onQuerySubmitted(query);
      context.read<DiaryBloc>().add(GetRagResponseEvent(query: query));
      _queryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: _queryController,
              hintText: 'Enter your query',
              onSubmitted: _submitQuery,
              leading: const Icon(Icons.search),
              trailing: [
                if (_queryController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _queryController.clear();
                      setState(() {});
                    },
                  ),
              ],
              textInputAction: TextInputAction.search,
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              return ListTile(
                title: Text('Sugerencia ${index + 1}'),
                onTap: () {
                  setState(() {
                    _queryController.text = 'Sugerencia ${index + 1}';
                    _submitQuery(_queryController.text);
                  });
                },
              );
            });
          },
        ),
      ),
    );
  }
}
