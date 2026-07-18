import 'package:flutter/material.dart';

import 'layout/shell.dart';
import 'theme/app_theme.dart';

class LexiconApp extends StatelessWidget {
  const LexiconApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lexicon',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const Shell(),
    );
  }
}