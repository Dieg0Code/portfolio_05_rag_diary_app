import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rag_diary_app/presentation/bloc/diary_bloc.dart';
import 'package:rag_diary_app/presentation/bloc/clear_rag_response_event.dart';
import 'package:rag_diary_app/presentation/bloc/diary_state.dart';
import 'package:rag_diary_app/presentation/widgets/rag_query_form.dart';
import 'package:rag_diary_app/presentation/widgets/animated_dots.dart'; // Asegúrate de importar el nuevo widget

class RagPage extends StatefulWidget {
  const RagPage({super.key});

  @override
  _RagPageState createState() => _RagPageState();
}

class _RagPageState extends State<RagPage> {
  String? userQuery;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DiaryBloc>().add(ClearRagResponseEvent());
    });
  }

  @override
  void dispose() {
    context.read<DiaryBloc>().add(ClearRagResponseEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DiaryBloc, DiaryState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                const SliverAppBar(
                  floating: true,
                  snap: true,
                  title: Text('RAG'),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      RagQueryForm(
                        onQuerySubmitted: (query) {
                          setState(() {
                            userQuery =
                                query; // Guardamos la consulta del usuario
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Mostramos la consulta del usuario
                      if (userQuery != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Card(
                            color: Colors.blue.shade100,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                userQuery!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Mostramos el estado de carga con animación de puntos
                      if (state is DiaryLoading)
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: AnimatedDots(), // Aquí usamos la animación
                          ),
                        ),

                      // Mostramos la respuesta de RAG
                      if (state is RagResponseReceived)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              context
                                  .read<DiaryBloc>()
                                  .add(ClearRagResponseEvent());
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(state.response),
                              ),
                            ),
                          ),
                        ),
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
