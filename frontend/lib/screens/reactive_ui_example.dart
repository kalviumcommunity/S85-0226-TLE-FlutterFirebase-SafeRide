import 'package:flutter/material.dart';

/// This screen demonstrates Flutter's Reactive UI Model
/// 
/// Key Concepts:
/// 1. StatefulWidget - Holds mutable state
/// 2. setState() - Triggers UI rebuild when state changes
/// 3. Reactive Updates - UI automatically reflects state changes
/// 4. Efficient Rendering - Only affected widgets rebuild

class ReactiveUIExample extends StatefulWidget {
  const ReactiveUIExample({super.key});

  @override
  State<ReactiveUIExample> createState() => _ReactiveUIExampleState();
}

class _ReactiveUIExampleState extends State<ReactiveUIExample> {
  // STATE VARIABLES - when these change, UI rebuilds automatically
  int _counter = 0;
  Color _backgroundColor = Colors.purple[50]!;
  bool _isVisible = true;
  String _message = 'Press buttons to see reactive updates!';

  // STATE MODIFICATION METHOD - uses setState() to trigger rebuild
  void _incrementCounter() {
    setState(() {
      _counter++;
      _message = 'Counter incremented $_counter time${_counter == 1 ? '' : 's'}!';
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _message = _counter == 0 
            ? 'Counter reset to zero!' 
            : 'Counter decremented!';
      } else {
        _message = 'Counter cannot go below zero!';
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _message = 'Counter has been reset!';
    });
  }

  void _changeBackgroundColor() {
    setState(() {
      // Cycle through different colors
      final colors = [
        Colors.purple[50]!,
        Colors.blue[50]!,
        Colors.green[50]!,
        Colors.orange[50]!,
        Colors.pink[50]!,
      ];
      int currentIndex = colors.indexOf(_backgroundColor);
      _backgroundColor = colors[(currentIndex + 1) % colors.length];
      _message = 'Background color changed!';
    });
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
      _message = _isVisible ? 'Widget is now visible!' : 'Widget is now hidden!';
    });
  }

  @override
  Widget build(BuildContext context) {
    // This build method runs every time setState() is called
    // Flutter efficiently rebuilds only the widgets that changed
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reactive UI Model'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: _backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header
                  const Text(
                    '⚡ Reactive UI in Action',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  
                  // Status Message
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      _message,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Counter Display Card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.deepPurple, Colors.purple[300]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.touch_app,
                            size: 48,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Counter Value',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // This text widget rebuilds when _counter changes
                          Text(
                            '$_counter',
                            style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Counter Control Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _decrementCounter,
                        icon: const Icon(Icons.remove),
                        label: const Text('Minus'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: _incrementCounter,
                        icon: const Icon(Icons.add),
                        label: const Text('Plus'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _resetCounter,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Divider
                  const Divider(thickness: 2, indent: 40, endIndent: 40),
                  const SizedBox(height: 20),
                  
                  // Interactive Widget Section
                  const Text(
                    'More Reactive Examples',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Toggle Visibility Button
                  ElevatedButton.icon(
                    onPressed: _toggleVisibility,
                    icon: Icon(_isVisible ? Icons.visibility_off : Icons.visibility),
                    label: Text(_isVisible ? 'Hide Widget' : 'Show Widget'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Conditionally rendered widget (demonstrates reactive visibility)
                  AnimatedOpacity(
                    opacity: _isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 32),
                          SizedBox(width: 12),
                          Text(
                            'I appear and disappear!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Change Background Button
                  ElevatedButton.icon(
                    onPressed: _changeBackgroundColor,
                    icon: const Icon(Icons.palette),
                    label: const Text('Change Background'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Explanation Card
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.lightbulb, color: Colors.amber),
                              SizedBox(width: 8),
                              Text(
                                'How it works:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildExplanationRow('1. Button pressed → calls function'),
                          _buildExplanationRow('2. setState() called with changes'),
                          _buildExplanationRow('3. Flutter rebuilds affected widgets'),
                          _buildExplanationRow('4. UI updates automatically! ⚡'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExplanationRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('  • ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
