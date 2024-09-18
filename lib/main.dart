import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rag_diary_app/data/datasources/diary_remote_data_source_impl.dart';
import 'package:rag_diary_app/domain/repositories/diary_repository.dart';
import 'package:rag_diary_app/domain/repositories/diary_repository_impl.dart';
import 'presentation/pages/home_page.dart';
import 'data/datasources/diary_remote_data_source.dart';
import 'domain/usecases/create_diary.dart';
import 'domain/usecases/get_rag_response.dart';
import 'presentation/bloc/diary_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<DiaryRemoteDataSource>(
          create: (context) => DiaryRemoteDataSourceImpl(client: http.Client()),
        ),
        RepositoryProvider<DiaryRepository>(
          create: (context) => DiaryRepositoryImpl(
            remoteDataSource: context.read<DiaryRemoteDataSource>(),
          ),
        ),
        RepositoryProvider<CreateDiary>(
          create: (context) => CreateDiary(context.read<DiaryRepository>()),
        ),
        RepositoryProvider<GetRagResponse>(
          create: (context) => GetRagResponse(context.read<DiaryRepository>()),
        ),
        BlocProvider<DiaryBloc>(
          create: (context) => DiaryBloc(
            createDiary: context.read<CreateDiary>(),
            getRagResponse: context.read<GetRagResponse>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Mi Diario App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
