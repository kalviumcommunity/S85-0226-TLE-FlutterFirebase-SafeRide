import 'package:flutter/material.dart';

class DebugDemoScreen extends StatefulWidget {
  const DebugDemoScreen({super.key});

  @override
  State<DebugDemoScreen> createState() => _DebugDemoScreenState();
}

class _DebugDemoScreenState extends State<DebugDemoScreen> {
  int _counter = 0;
  String _lastAction = 'No action yet';
  Color _backgroundColor = Colors.blue.shade50;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _lastAction = 'Incremented counter to $_counter';
      debugPrint('🔥 DEBUG: Counter incremented! Current value: $_counter');
      debugPrint('🎨 DEBUG: Background color will change');
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _lastAction = 'Decremented counter to $_counter';
        debugPrint('❄️ DEBUG: Counter decremented! Current value: $_counter');
      } else {
        _lastAction = 'Counter is already 0';
        debugPrint('⚠️ DEBUG: Cannot decrement below 0');
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _lastAction = 'Reset counter to 0';
      _backgroundColor = _backgroundColor == Colors.blue.shade50 
          ? Colors.green.shade50 
          : Colors.blue.shade50;
      debugPrint('🔄 DEBUG: Counter reset! Background changed');
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🏗️ DEBUG: Building DebugDemoScreen widget...');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Console Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      backgroundColor: _backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Debug Info Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.bug_report,
                      size: 60,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Debug Console Demo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Watch the Debug Console for logs!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Counter Display
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.deepPurple.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      'Counter Value',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
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
                    Text(
                      _lastAction,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.remove),
                        SizedBox(width: 8),
                        Text('Decrease'),
                      ],
                    ),
                  ),
                  
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 8),
                        Text('Increase'),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _resetCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh),
                      SizedBox(width: 8),
                      Text('Reset & Change Color'),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Instructions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.yellow.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🔍 Debug Instructions:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...[
                      '• Open Debug Console in your IDE',
                      '• Press buttons and watch the logs',
                      '• Try Hot Reload by changing code',
                      '• Open DevTools for widget inspection',
                    ].map(
                      (instruction) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          instruction,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
