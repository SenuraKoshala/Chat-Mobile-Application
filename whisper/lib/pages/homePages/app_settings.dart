import 'package:flutter/material.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = ThemeMode.light; // Default theme
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button to toggle light/dark mode
            ElevatedButton(
              onPressed: _toggleTheme,
              child: Text(
                _themeMode == ThemeMode.light ? 'Switch to Dark Mode' : 'Switch to Light Mode',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
