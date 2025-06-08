import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intro_fplas/Pages/homepage.dart';
import 'package:intro_fplas/Pages/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('answers');
  await Hive.openBox('userBox');
  await Hive.openBox('settings');

  final fontSize = Hive.box('settings').get('fontSize', defaultValue: 16.0);

  runApp(MyApp(fontSize));
}

class MyApp extends StatelessWidget {
  final double fontSize;
  const MyApp(this.fontSize, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Introductory FPLAS',
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        textTheme: Theme.of(context).textTheme.apply(fontSizeFactor: fontSize / 16.0),
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => const SplashScreen(),
        '/home': (_) => const Homepage()
      },
    );
  }
}