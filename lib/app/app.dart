import 'package:flutter/material.dart';
import 'package:lexicon/core/shortcuts/app_shortcuts.dart';
import '../core/command_palette/command_palette_overlay.dart';
import 'layout/home_screen.dart';
import 'theme/app_theme.dart';

class LexiconApp extends StatelessWidget {
  const LexiconApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lexicon',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AppShortcuts(
        child: CommandPaletteOverlay(child: HomeScreen()),
      ),
    );
  }
}
