import 'package:flutter/material.dart';

class WidgetTreeDemo extends StatefulWidget {
  const WidgetTreeDemo({super.key});

  @override
  State<WidgetTreeDemo> createState() => _WidgetTreeDemoState();
}

class _WidgetTreeDemoState extends State<WidgetTreeDemo> {
  int _counter = 0;
  Color _backgroundColor = Colors.blue.shade50;
  bool _isCardVisible = true;
  String _userName = 'Flutter Developer';
  double _cardElevation = 4.0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      // Change background color based on counter value
      if (_counter % 3 == 0) {
        _backgroundColor = Colors.green.shade50;
      } else if (_counter % 2 == 0) {
        _backgroundColor = Colors.orange.shade50;
      } else {
        _backgroundColor = Colors.blue.shade50;
      }
    });
  }

  void _toggleCardVisibility() {
    setState(() {
      _isCardVisible = !_isCardVisible;
    });
  }

  void _changeUserName() {
    setState(() {
      final names = ['Flutter Developer', 'Widget Master', 'UI Expert', 'State Ninja'];
      final currentIndex = names.indexOf(_userName);
      _userName = names[(currentIndex + 1) % names.length];
    });
  }

  void _changeElevation() {
    setState(() {
      _cardElevation = _cardElevation == 4.0 ? 12.0 : 4.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Tree & Reactive UI Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: _backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Counter Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Counter Value',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$_counter',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _incrementCounter,
                        icon: const Icon(Icons.add),
                        label: const Text('Increment Counter'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Profile Card Section
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _isCardVisible ? 1.0 : 0.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: _cardElevation,
                          offset: Offset(0, _cardElevation / 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.deepPurple.shade100,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.deepPurple.shade700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _userName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Widget Tree Explorer',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: _changeUserName,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Change Name'),
                            ),
                            ElevatedButton(
                              onPressed: _changeElevation,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Change Elevation'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Control Panel
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.deepPurple.shade200),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Control Panel',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _toggleCardVisibility,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(_isCardVisible ? 'Hide Card' : 'Show Card'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _counter = 0;
                                _backgroundColor = Colors.blue.shade50;
                                _isCardVisible = true;
                                _userName = 'Flutter Developer';
                                _cardElevation = 4.0;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Reset All'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Widget Tree Info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.deepPurple.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Widget Tree Hierarchy:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '''
Scaffold
 ┣ AppBar
 ┣ AnimatedContainer (Background)
 ┃  ┗ Center
 ┃     ┗ SingleChildScrollView
 ┃         ┗ Column
 ┃             ┣ Container (Counter)
 ┃             ┣ SizedBox
 ┃             ┣ AnimatedOpacity
 ┃             ┃  ┗ AnimatedContainer (Profile Card)
 ┃             ┣ SizedBox
 ┃             ┗ Container (Control Panel)''',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
