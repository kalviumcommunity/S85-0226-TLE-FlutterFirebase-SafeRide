import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeRide - Home'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.home,
              size: 100,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to SafeRide',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Go to Second Screen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second', arguments: 'Hello from SafeRide Home!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Go to Second Screen with Message'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/scroll');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.tertiary,
                foregroundColor: colorScheme.onTertiary,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Open Scrollable Views Demo'),
            ),
            ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/state');
  },
  child: const Text("Open State Demo"),
),
ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/responsive');
  },
  child: const Text("Open Responsive Demo"),
),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user-input');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.secondary,
                foregroundColor: colorScheme.onSecondary,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Open User Input Form'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/assets');
              },
              icon: const Icon(Icons.image),
              label: const Text('Assets Demo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/bottom');
  },
  child: const Text("Open Bottom Navigation"),
),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/responsive-layout');
              },
              icon: const Icon(Icons.devices),
              label: const Text('Responsive Layout Demo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/animations');
              },
              icon: const Icon(Icons.animation),
              label: const Text('Animations & Transitions Demo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
