import 'package:flutter/material.dart';

class StateManagementDemo extends StatefulWidget {
  const StateManagementDemo({super.key});

  @override
  State<StateManagementDemo> createState() => _StateManagementDemoState();
}

class _StateManagementDemoState extends State<StateManagementDemo> {

  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          counter >= 5 ? Colors.greenAccent.shade100 : Colors.white,

      appBar: AppBar(
        title: const Text("State Management Demo"),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Button Pressed:",
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 10),

            Text(
              "$counter",
              style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  onPressed: increment,
                  child: const Text("Increment"),
                ),

                const SizedBox(width: 15),

                ElevatedButton(
                  onPressed: decrement,
                  child: const Text("Decrement"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              counter >= 5
                  ? "Great! Count reached 5 🎉"
                  : "Keep Clicking 👍",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}