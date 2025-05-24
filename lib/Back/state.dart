import 'package:flutter/material.dart';

final List<Map<String, dynamic>> courseList = [
  {
    'icon': Icons.textsms,
    'title': 'Introduction to Flutter and Widget',
    'status': 'Not Started Yet',
    'subStatus': '',
    'iconColor': Colors.teal,
    'path': '1',
    'pageIndex': 0,
  },
  {
    'icon': Icons.vpn_key,
    'title': 'Introduction to Key Concepts',
    'status': 'Not Started Yet',
    'subStatus': 'Finish last part',
    'iconColor': Colors.orange,
    'path': 'introduction_to_concepts',
    'pageIndex': 0,
  },
  {
    'icon': Icons.device_hub,
    'title': 'About Flutter Program Structure',
    'status': 'Not Started Yet',
    'subStatus': 'Finish last part',
    'iconColor': Colors.purple,
    'path': 'introduction_to_structure',
    'pageIndex': 0,
  },
  {
    'icon': Icons.compare_arrows,
    'title': 'Stateless vs Statefull Differences',
    'status': 'Not Started Yet',
    'subStatus': 'Finish last part',
    'iconColor': Colors.indigo,
    'path': 'introduction_to_state',
    'pageIndex': 0,
  },
];

final Map<String, List<Map<String, dynamic>>> allLearningPaths = {
  "introduction_to_widget": [
    {
      "page": 1,
      "total": 3,
      "items": [
        {
          "type": "title",
          "text": "Everything in Flutter is a ‘Widget’",
        },
        {
          "type": "paragraph",
          "text": "Everything you see in Flutter (buttons, text, images) is a widget. Widgets define both appearance (UI) and behavior (logic).",
        },
        {
          "type": "subtitle",
          "text": "Why Does Flutter Use Widget?",
        },
        {
          "type": "bullet",
          "items": [
            {"label": "Declarative Approach", "desc": "You define what the UI should look like, and Flutter renders it."},
            {"label": "Integrated UI & Logic", "desc": "Less boilerplate code, easier maintenance."},
            {"label": "Simplified State Management", "desc": "Choose between stateless and stateful widgets as needed."},
            {"label": "Consistent Design", "desc": "Flutter ensures UI uniformity across platforms."},
          ]
        },
        {
          "type": "question",
          "questions": [
            "What is everything in Flutter?",
            "What does a widget define?"
          ]
        }
      ]
    },
    {
      "page": 2,
      "total": 3,
      "items": [
        {
          "type": "title",
          "text": "Example of Simplicity"
        },
        {
          "type": "code",
          "text": "ElevatedButton(\n  child: Text('Click Me'), // The UI part\n  onPressed: () {\n    // The logic part\n    print('Button clicked!');\n  },\n);"
        },
        {
          "type": "subtitle",
          "text": "Declarative UI in Flutter"
        },
        {
          "type": "bullet",
          "items": [
            {
              "desc": "Instead of manually updating UI, you define the final UI state."
            },
            {
              "desc": "Flutter automatically renders changes when state updates."
            },
            {
              "desc": "This allows focusing on “what the UI should look like” instead of “how to update it”."
            }
          ]
        },
        {
          "type": "question",
          "questions": [
            "Which UI style does Flutter use?",
            "In Flutter, what part defines the logic in a widget?"
          ]
        }
      ]
    },
    {
      "page": 3,
      "total": 3,
      "items": [
        {
          "type": "title",
          "text": "How Does Flutter Differ from Older UI Frameworks?"
        },
        {
          "type": "subtitle",
          "text": "Older UI Frameworks: How They Work"
        },
        {
          "type": "paragraph",
          "text": "UI and Logic are separated into different files (e.g., XML for UI, Java/Kotlin for logic).  Developers need to constantly switch between files. Also, UI updates require modifying multiple places."
        },
        {
          "type": "paragraph",
          "text": "Define button in XML :"
        },
        {
          "type": "code",
          "text": "<Button android:text='Click me' />"
        },
        {
          "type": "paragraph",
          "text": "Add behavior in button use Java code :"
        },
        {
          "type": "code",
          "text": "Button myButton = findViewById(R.id.myButton);\nmyButton.setOnClickListener(new View.OnClickListener() {\n     public void onClick(View v) {\n         // Do something here\n     }\n});"
        },
        {
          "type": "subtitle",
          "text": "How Flutter Improves This"
        },
        {
          "type": "bullet",
          "items": [
            {
              "desc": "UI and logic are combined in one place using widgets."
            },
            {
              "desc": "Easier to see and modify UI and behavior together."
            },
            {
              "label": "Faster development & cleaner code",
              "desc": "No need to manage separate UI files."
            },
            {
              "desc": "Single widget contains both UI and logic."
            }
          ]
        },
        {
          "type": "question",
          "questions": [
            "What makes Flutter code easier to manage?",
            "Which style causes developers to switch between files?"
          ]
        }
      ]
    },
  ],

  "flutter_navigation": [
    // halaman lain nanti...
  ],
};