import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LearningLoader {
  /// Load all learning path pages (e.g., content for a specific course)
  static Future<Map<String, List<Map<String, dynamic>>>> loadPaths() async {
    final jsonString = await rootBundle.loadString('assets/json/all_learning_paths.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);

    // Convert nested list of maps properly
    return data.map((key, value) =>
        MapEntry(key, (value as List).cast<Map<String, dynamic>>()));
  }

  static Future<Map<String, List<Map<String, dynamic>>>> loadQuestions() async {
    final jsonString = await rootBundle.loadString('assets/json/answer_widget.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return data.map((key, value) =>
        MapEntry(key, (value as List).cast<Map<String, dynamic>>()));
  }
}