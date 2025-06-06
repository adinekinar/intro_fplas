import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class SelectAnswerBox extends StatefulWidget {
  final String pathId;
  final int questionId;
  final String question;
  final List<String> options;
  final String correctAnswerHash;
  final void Function(String selected, bool isCorrect)? onAnswered;

  const SelectAnswerBox({
    Key? key,
    required this.pathId,
    required this.questionId,
    required this.question,
    required this.options,
    required this.correctAnswerHash,
    this.onAnswered,
  }) : super(key: key);

  @override
  State<SelectAnswerBox> createState() => _SelectAnswerBoxState();
}

class _SelectAnswerBoxState extends State<SelectAnswerBox> {
  String? selected;
  bool? isCorrect;
  final userId = 'user123';

  @override
  void initState() {
    super.initState();
    final box = Hive.box('answers');
    final key = "${widget.pathId}_${widget.questionId}_$userId";
    final saved = box.get(key);

    if (saved != null) {
      selected = saved['answer'];
      isCorrect = hashAnswer(selected!) == widget.correctAnswerHash;
      final time = saved['timeStamp'];
      print("Jawaban sebelumnya: $selected pada $time");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCorrect = selected != null && hashAnswer(selected!) == widget.correctAnswerHash;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${widget.questionId.toString()}. ${widget.question}", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _showOptions,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: selected == null
                  ? Colors.grey[200]
                  : (isCorrect ? Colors.green[300] : Colors.red[300]),
              border: Border.all(color: Colors.grey),
            ),
            child: Text(
              selected ?? "Select the answer",
              style: TextStyle(
                color: selected == null ? Colors.grey[700] : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showOptions() async {
    if (selected != null && isCorrect == true) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Retry Answer?"),
          content: Text("This answer is already correct. Do you want to select a new answer?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancel")),
            TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Retry")),
          ],
        ),
      );
      if (confirm != true) return;
    }
    final shuffled = List<String>.from(widget.options)..shuffle();

    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: shuffled.map((option) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context, option);
              },
              child: Container(
                width: 120,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(option, style: TextStyle(color: Colors.white)),
              ),
            );
          }).toList(),
        ),
      ),
    );

    if (result != null) {
      final correct = hashAnswer(result) == widget.correctAnswerHash;
      setState(() {
        selected = result;
        isCorrect = correct;
      });

      final box = Hive.box('answers');
      final key = "${widget.pathId}_${widget.questionId}_$userId";
      final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      box.put(key, {
        "answer": selected,
        "timeStamp": formattedTime,
      });

      widget.onAnswered?.call(result, correct);
    }
  }
}

String hashAnswer(String answer) {
  const pepper = "fplas2024introductory";
  final input = "$pepper:${answer.trim().toLowerCase()}";
  return sha256.convert(utf8.encode(input)).toString();
}