import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_state.dart';

class ThemeToggleScreen extends StatelessWidget {
  const ThemeToggleScreen({super.key});

  @override
  Widget build(BuildContext context) {

    bool isDark =
        context.watch<ThemeState>().mode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Settings"),
      ),

      body: Center(
        child: SwitchListTile(
          title: const Text("Dark Mode"),
          value: isDark,
          onChanged: (value) {
            context.read<ThemeState>().toggleTheme(value);
          },
        ),
      ),
    );
  }
}