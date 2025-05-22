import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_fplas/Back/state.dart';
import 'package:intro_fplas/Component/learn_card.dart';
import 'package:intro_fplas/Pages/learnpath.dart';

class Learnpage extends StatefulWidget {
  const Learnpage({super.key});

  @override
  State<Learnpage> createState() => _LearnpageState();
}

class _LearnpageState extends State<Learnpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(CupertinoIcons.doc_on_clipboard, color: Colors.blueAccent),
                SizedBox(width: 15.0),
                Text('Getting Started to Flutter!')
              ],
            ),
            const SizedBox(height: 15.0),
            Expanded(
              child: ListView.builder(
                itemCount: courseList.length,
                itemBuilder: (context, index) {
                  final course = courseList[index];
                  return GestureDetector(
                    child: courseCard(
                      icon: course['icon'],
                      title: course['title'],
                      status: course['status'],
                      subStatus: course['subStatus'],
                      iconColor: course['iconColor'],
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_)=> LearningPathPage(
                            pathId: course['path'],
                            pageIndex: course['pageIndex'],
                          )
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}