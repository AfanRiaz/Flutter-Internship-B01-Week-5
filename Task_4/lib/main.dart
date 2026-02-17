import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notes_list_page.dart';
import 'notes_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NotesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesListPage(),
    );
  }
}
