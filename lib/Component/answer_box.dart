import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SelectAnswerBox extends StatefulWidget {
  final int questionId;
  final String question;
  final List<String> options;
  final String correctAnswerHash;
  final void Function(String selected, bool isCorrect)? onAnswered;

  const SelectAnswerBox({
    Key? key,
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
  String hashAnswer(String text) {
    return sha256.convert(utf8.encode(text.trim().toLowerCase())).toString();
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
          onTap: (selected != null && isCorrect == true) ? null : _showOptions,
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
      widget.onAnswered?.call(result, correct);
    }
  }
}