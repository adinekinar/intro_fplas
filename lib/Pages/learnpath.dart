import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intro_fplas/Pages/homepage.dart';

import '../Back/learning_loader.dart';
import '../Component/answer_box.dart';

class LearningPathPage extends StatefulWidget {
  final String pathId;
  final int pageIndex;

  const LearningPathPage({super.key, required this.pathId, this.pageIndex = 0});

  @override
  State<LearningPathPage> createState() => _LearningPathPageState();
}

class _LearningPathPageState extends State<LearningPathPage> {
  late int currentIndex;
  late ScrollController _scrollController;
  late List<Map<String, dynamic>> pages = [];
  Map<String, List<Map<String, dynamic>>>? questionsMap;
  List<Map<String, dynamic>> questionItems = [];


  @override
  void initState() {
    super.initState();
    currentIndex = widget.pageIndex;
    pages = [];
    loadPageData();
    _scrollController = ScrollController();
  }

  Future<void> loadPageData() async {
    final paths = await LearningLoader.loadPaths();
    final questions = await LearningLoader.loadQuestions();

    final selectedPath = widget.pathId;
    final selectedPage = currentIndex + 1;

    setState(() {
      pages = paths[selectedPath]!;
      questionsMap = questions;
      questionItems = []; // ← reset dulu

      final questionsList = questions[selectedPath];
      final pageData = questionsList?.firstWhere(
            (e) => e['page'] == selectedPage,
        orElse: () => {},
      );

      questionItems = pageData?['item']?.cast<Map<String, dynamic>>() ?? [];
    });
  }

  bool get allAnswered {
    if(questionItems.isEmpty) return false;

    final box = Hive.box('answers');
    const userId = 'user123';
    //final userId = Hive.box('userBox').get('userId') ?? 'guest';

    return questionItems.every((q) {
      final key = "${widget.pathId}_${q['question_id']}_$userId";
      return box.get(key) != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Loading...")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final currentPage = pages[currentIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Introduction to Widget", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        leading: currentIndex > 0
            ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              currentIndex--;
            });
            loadPageData(); // ← Refresh questions
          },
        )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          controller: _scrollController,
          children: [
            Text("${currentPage['page']} of ${currentPage['total']}"),
            const SizedBox(height: 16),

            ..._buildContentWidgets(currentPage['items']),

            const SizedBox(height: 24),

            ...questionItems.map((q) => SelectAnswerBox(
              key: ValueKey(q['question_id']),
              pathId: widget.pathId,
              questionId: q['question_id'],
              question: q['question'],
              options: List<String>.from(q['options']),
              correctAnswerHash: q['answerHash'],
              onAnswered: (selected, isCorrect) {
                setState(() {});
              },
            )).toList(),

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: allAnswered ? () {
                  if (currentIndex < pages.length - 1) {
                    setState(() {
                      currentIndex++;
                    });
                    loadPageData();
                    if(_scrollController.hasClients){
                    _scrollController.jumpTo(0);}
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => Homepage()),
                    );
                  }
                } : null,
                child: Text((currentIndex < pages.length - 1) ? "Next →" : "Top"),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContentWidgets(List<dynamic> items) {
    return items.map<Widget>((item) {
      switch (item['type']) {
        case 'title':
          return Text(item['text'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
        case 'subtitle':
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(item['text'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          );
        case 'paragraph':
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(item['text']),
          );
        case 'bullet':
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate((item['items'] as List).length, (i) {
              final b = item['items'][i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  b['label'] != null
                  ?  "• ${b['label']} → ${b['desc']}"
                  :  "• ${b['desc']}"
                ),
              );
            }),
          );
        case 'code':
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(item['text']),
          );
        case 'question':
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate((item['questions'] as List).length, (i) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: GestureDetector(
                  onTap: (){},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${i + 1}. ${item['questions'][i]}"),
                    ],
                  ),
                ),
              );
            }),
          );
        default:
          return const SizedBox.shrink();
      }
    }).toList();
  }
}