import 'package:flutter/material.dart';

// StatelessWidget Example - Static Header
class AppHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AppHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade400,
            Colors.deepPurple.shade600,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.widgets,
            size: 48,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// StatelessWidget Example - Static Info Card
class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const InfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

// StatefulWidget Example - Interactive Counter
class InteractiveCounter extends StatefulWidget {
  const InteractiveCounter({super.key});

  @override
  State<InteractiveCounter> createState() => _InteractiveCounterState();
}

class _InteractiveCounterState extends State<InteractiveCounter> {
  int _counter = 0;
  Color _counterColor = Colors.blue;
  double _fontSize = 24.0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _updateCounterStyle();
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _updateCounterStyle();
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _updateCounterStyle();
    });
  }

  void _updateCounterStyle() {
    if (_counter == 0) {
      _counterColor = Colors.blue;
      _fontSize = 24.0;
    } else if (_counter <= 5) {
      _counterColor = Colors.green;
      _fontSize = 28.0;
    } else if (_counter <= 10) {
      _counterColor = Colors.orange;
      _fontSize = 32.0;
    } else {
      _counterColor = Colors.red;
      _fontSize = 36.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Interactive Counter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _counterColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: _counterColor.withOpacity(0.3)),
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.bold,
                color: _counterColor,
              ),
              child: Text(
                '$_counter',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _decrementCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Icon(Icons.remove),
              ),
              ElevatedButton(
                onPressed: _resetCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Icon(Icons.refresh),
              ),
              ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// StatefulWidget Example - Theme Toggle
class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  bool _isDarkMode = false;
  final List<String> _quotes = [
    "Stateless widgets are predictable and efficient",
    "Stateful widgets bring interactivity to life",
    "Understanding both types makes you a better Flutter developer",
    "Choose the right widget for the right job",
  ];
  int _currentQuoteIndex = 0;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _nextQuote() {
    setState(() {
      _currentQuoteIndex = (_currentQuoteIndex + 1) % _quotes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (_isDarkMode ? Colors.black : Colors.grey).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Theme Toggle Demo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _isDarkMode ? Colors.white : Colors.grey.shade800,
                ),
              ),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  _toggleTheme();
                },
                activeThumbColor: Colors.deepPurple,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (_isDarkMode ? Colors.deepPurple : Colors.deepPurple.shade100)
                  .withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Icon(
                  _isDarkMode ? Icons.nights_stay : Icons.wb_sunny,
                  size: 48,
                  color: _isDarkMode ? Colors.deepPurple.shade200 : Colors.deepPurple,
                ),
                const SizedBox(height: 12),
                Text(
                  _isDarkMode ? 'Dark Mode' : 'Light Mode',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (_isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100)
                  .withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  'Flutter Wisdom',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _quotes[_currentQuoteIndex],
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: _isDarkMode ? Colors.white70 : Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _nextQuote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Next Quote'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// StatefulWidget Example - Interactive Profile
class InteractiveProfile extends StatefulWidget {
  const InteractiveProfile({super.key});

  @override
  State<InteractiveProfile> createState() => _InteractiveProfileState();
}

class _InteractiveProfileState extends State<InteractiveProfile> {
  bool _isExpanded = false;
  int _likes = 42;
  bool _isLiked = false;
  final List<String> _skills = ['Flutter', 'Dart', 'Firebase', 'UI/UX'];
  List<String> _displayedSkills = [];

  @override
  void initState() {
    super.initState();
    _displayedSkills = _skills.take(2).toList();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _displayedSkills = _skills;
      } else {
        _displayedSkills = _skills.take(2).toList();
      }
    });
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likes++;
      } else {
        _likes--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.deepPurple.shade100,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.deepPurple.shade700,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Flutter Developer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Widget Enthusiast',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _displayedSkills.map((skill) {
                    return Chip(
                      label: Text(skill),
                      backgroundColor: Colors.deepPurple.shade100,
                      labelStyle: TextStyle(
                        color: Colors.deepPurple.shade700,
                        fontSize: 12,
                      ),
                    );
                  }).toList(),
                ),
                if (_skills.length > 2)
                  TextButton(
                    onPressed: _toggleExpanded,
                    child: Text(_isExpanded ? 'Show Less' : 'Show More'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _toggleLike,
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : null,
                ),
                label: Text('$_likes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isLiked ? Colors.red.shade50 : null,
                  foregroundColor: _isLiked ? Colors.red : null,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _likes = 42;
                    _isLiked = false;
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Main Demo Screen
class StatelessWidgetStatefulWidgetDemo extends StatelessWidget {
  const StatelessWidgetStatefulWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Stateless vs Stateful Widgets'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // StatelessWidget Header (Static)
            const AppHeader(
              title: 'Widget Types Demo',
              subtitle: 'Exploring Stateless and Stateful Widgets',
            ),
            
            const SizedBox(height: 24),
            
            // StatelessWidget Info Cards (Static)
            const InfoCard(
              title: 'StatelessWidget',
              description: 'Static widgets that don\'t change once built. Perfect for headers, labels, and static content.',
              icon: Icons.widgets_outlined,
              color: Colors.blue,
            ),
            
            const SizedBox(height: 16),
            
            const InfoCard(
              title: 'StatefulWidget',
              description: 'Dynamic widgets that can change their appearance based on user interaction or data changes.',
              icon: Icons.autorenew,
              color: Colors.green,
            ),
            
            const SizedBox(height: 24),
            
            // StatefulWidget Examples (Interactive)
            const Text(
              'Interactive Examples (StatefulWidget)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            
            const SizedBox(height: 16),
            
            const InteractiveCounter(),
            
            const SizedBox(height: 16),
            
            const ThemeToggle(),
            
            const SizedBox(height: 16),
            
            const InteractiveProfile(),
            
            const SizedBox(height: 24),
            
            // Summary Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Key Differences:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDifferenceItem(
                    'StatelessWidget',
                    'Immutable, no internal state',
                    Icons.block,
                  ),
                  _buildDifferenceItem(
                    'StatefulWidget',
                    'Mutable, can change over time',
                    Icons.sync,
                  ),
                  _buildDifferenceItem(
                    'Performance',
                    'Stateless widgets are more performant',
                    Icons.speed,
                  ),
                  _buildDifferenceItem(
                    'Use Case',
                    'Use StatelessWidget for static content',
                    Icons.category,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifferenceItem(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
