import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/widgets/mainScreen.dart' show MainScreen;
import 'package:wordle/provider/accountProv.dart' show AccountProvider;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AccountProvider(),
      child: const WordleApp(),
    ),
  );
}

class WordleApp extends StatelessWidget {
  const WordleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
