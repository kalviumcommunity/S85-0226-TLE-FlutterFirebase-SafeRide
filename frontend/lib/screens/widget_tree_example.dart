import 'package:flutter/material.dart';

/// This screen demonstrates the Widget Tree concept in Flutter
/// 
/// Widget Tree Hierarchy for this screen:
/// MaterialApp (root - defined in main.dart)
///   └── Scaffold
///       ├── AppBar
///       │   └── Text('Widget Tree Example')
///       └── Body (Center)
///           └── SingleChildScrollView
///               └── Padding
///                   └── Column
///                       ├── Text (Welcome Header)
///                       ├── SizedBox (spacing)
///                       ├── Card (Tree Visualization)
///                       │   └── Padding
///                       │       └── Column
///                       │           ├── Text (Title)
///                       │           ├── Divider
///                       │           └── Text (Tree Diagram)
///                       ├── SizedBox (spacing)
///                       ├── Container (Colored Box Example)
///                       │   └── Column
///                       │       ├── Icon
///                       │       └── Text
///                       └── Text (Footer)

class WidgetTreeExample extends StatelessWidget {
  const WidgetTreeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Tree Example'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Text
                const Text(
                  '🌳 Welcome to Flutter Widget Tree',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                
                // Tree Visualization Card
                Card(
                  elevation: 4,
                  color: Colors.purple[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Widget Hierarchy:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const Divider(thickness: 2),
                        const Text(
                          'Scaffold\n'
                          ' ┣ AppBar\n'
                          ' ┃  ┗ Text\n'
                          ' ┗ Body\n'
                          '    ┗ Center\n'
                          '       ┗ SingleChildScrollView\n'
                          '          ┗ Padding\n'
                          '             ┗ Column\n'
                          '                ┣ Text\n'
                          '                ┣ SizedBox\n'
                          '                ┣ Card\n'
                          '                ┣ Container\n'
                          '                ┗ Text',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Colored Box Example - Demonstrating Parent-Child Relationship
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.purple[300]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.widgets,
                        size: 48,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Container (Parent)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Contains Column → Icon + Text (Children)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // Footer Text
                const Text(
                  'Every widget is a node in the tree!\n'
                  'Parent widgets contain child widgets,\n'
                  'forming a hierarchical structure.',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
