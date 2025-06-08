import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Settingpage extends StatefulWidget {
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  double fontSize = 16.0;

  @override
  void initState() {
    super.initState();
    final box = Hive.box('settings');
    fontSize = box.get('fontSize', defaultValue: 16.0);
  }

  void _saveFontSize(double value) {
    final box = Hive.box('settings');
    box.put('fontSize', value);
    setState(() {
      fontSize = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Font Size: ${fontSize.toStringAsFixed(1)}", style: TextStyle(fontSize: fontSize)),
            Slider(
              min: 12,
              max: 30,
              divisions: 9,
              value: fontSize,
              onChanged: (value) => _saveFontSize(value),
            ),
          ],
        ),
      ),
    );
  }
}
