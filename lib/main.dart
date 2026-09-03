import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/app_state.dart';
import 'screens/home_screen.dart';
import 'theme.dart';

void main() {
  runApp(const LittleLearnersApp());
}

class LittleLearnersApp extends StatefulWidget {
  const LittleLearnersApp({super.key});

  @override
  State<LittleLearnersApp> createState() => _LittleLearnersAppState();
}

class _LittleLearnersAppState extends State<LittleLearnersApp> {
  final AppState _appState = AppState();

  @override
  void initState() {
    super.initState();
    _appState.load(); // restore saved language, stars, and badges
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>.value(
      value: _appState,
      child: MaterialApp(
        title: 'Little Learners',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}
