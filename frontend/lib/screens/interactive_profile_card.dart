import 'package:flutter/material.dart';

/// Interactive Profile Card - Combining Widget Tree & Reactive UI concepts
/// 
/// Widget Tree for this screen:
/// Scaffold
///  ┣ AppBar
///  ┗ Body (AnimatedContainer)
///     ┗ Center
///        ┗ SingleChildScrollView
///           ┗ Padding
///              ┗ Column
///                 ┣ Card (Profile Display)
///                 ┃  ┗ Column
///                 ┃     ┣ CircleAvatar
///                 ┃     ┣ Text (Name)
///                 ┃     ┣ Text (Title)
///                 ┃     ┗ Row (Stats)
///                 ┣ Card (Theme Controls)
///                 ┗ Card (Tree Diagram)

class InteractiveProfileCard extends StatefulWidget {
  const InteractiveProfileCard({super.key});

  @override
  State<InteractiveProfileCard> createState() => _InteractiveProfileCardState();
}

class _InteractiveProfileCardState extends State<InteractiveProfileCard> 
    with SingleTickerProviderStateMixin {
  
  // STATE VARIABLES
  String _name = 'John Developer';
  String _title = 'Flutter Enthusiast';
  int _followers = 1234;
  int _following = 567;
  int _posts = 89;
  Color _cardColor = Colors.deepPurple;
  IconData _avatarIcon = Icons.person;
  bool _showStats = true;
  bool _isDarkMode = false;
  
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // STATE MODIFICATION METHODS
  void _changeTheme(Color color, IconData icon, String themeName) {
    setState(() {
      _cardColor = color;
      _avatarIcon = icon;
    });
    _animationController.forward().then((_) => _animationController.reverse());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Theme changed to $themeName'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _incrementFollowers() {
    setState(() {
      _followers += 10;
    });
  }

  void _updateProfile(String name, String title) {
    setState(() {
      _name = name;
      _title = title;
    });
  }

  void _toggleStats() {
    setState(() {
      _showStats = !_showStats;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _randomizeProfile() {
    final names = ['Alice Developer', 'Bob Designer', 'Carol Engineer', 'Dave Architect'];
    final titles = ['Flutter Expert', 'UI/UX Specialist', 'Full Stack Dev', 'Mobile Guru'];
    
    setState(() {
      _name = (names..shuffle()).first;
      _title = (titles..shuffle()).first;
      _followers += (50 + (DateTime.now().millisecond % 200));
      _following += (10 + (DateTime.now().millisecond % 50));
      _posts += (1 + (DateTime.now().millisecond % 5));
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isDarkMode ? Colors.grey[900]! : Colors.grey[100]!;
    final textColor = _isDarkMode ? Colors.white : Colors.black87;
    final cardBackground = _isDarkMode ? Colors.grey[850]! : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Profile Card'),
        backgroundColor: _cardColor,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleDarkMode,
            tooltip: 'Toggle Dark Mode',
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Main Profile Card
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Card(
                      elevation: 8,
                      color: cardBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            // Avatar with animated color
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: _cardColor,
                              child: Icon(
                                _avatarIcon,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            // Name (reactive to state changes)
                            Text(
                              _name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            
                            // Title (reactive to state changes)
                            Text(
                              _title,
                              style: TextStyle(
                                fontSize: 16,
                                color: _cardColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 24),
                            
                            // Stats Row (conditionally rendered)
                            AnimatedCrossFade(
                              firstChild: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildStatColumn('Posts', _posts, textColor),
                                  _buildDivider(),
                                  _buildStatColumn('Followers', _followers, textColor),
                                  _buildDivider(),
                                  _buildStatColumn('Following', _following, textColor),
                                ],
                              ),
                              secondChild: Container(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.visibility_off, color: textColor.withOpacity(0.5)),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Stats Hidden',
                                      style: TextStyle(
                                        color: textColor.withOpacity(0.5),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              crossFadeState: _showStats 
                                  ? CrossFadeState.showFirst 
                                  : CrossFadeState.showSecond,
                              duration: const Duration(milliseconds: 300),
                            ),
                            const SizedBox(height: 20),
                            
                            // Action Buttons
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: _incrementFollowers,
                                  icon: const Icon(Icons.person_add, size: 18),
                                  label: const Text('Gain Followers'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _cardColor,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: _toggleStats,
                                  icon: Icon(_showStats ? Icons.visibility_off : Icons.visibility, size: 18),
                                  label: Text(_showStats ? 'Hide Stats' : 'Show Stats'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: _randomizeProfile,
                                  icon: const Icon(Icons.shuffle, size: 18),
                                  label: const Text('Randomize'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Theme Selection Card
                  Card(
                    color: cardBackground,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.palette, color: _cardColor),
                              const SizedBox(width: 8),
                              Text(
                                'Choose Theme Color',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildThemeButton(Colors.deepPurple, Icons.person, 'Purple'),
                              _buildThemeButton(Colors.blue, Icons.code, 'Blue'),
                              _buildThemeButton(Colors.green, Icons.eco, 'Green'),
                              _buildThemeButton(Colors.orange, Icons.sunny, 'Orange'),
                              _buildThemeButton(Colors.pink, Icons.favorite, 'Pink'),
                              _buildThemeButton(Colors.teal, Icons.water_drop, 'Teal'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Widget Tree Visualization Card
                  Card(
                    color: cardBackground,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.account_tree, color: _cardColor),
                              const SizedBox(width: 8),
                              Text(
                                'Widget Tree Structure',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Text(
                            'Card (Profile)\n'
                            ' ┣ Column\n'
                            ' ┃  ┣ CircleAvatar\n'
                            ' ┃  ┣ Text (Name) ← Reactive\n'
                            ' ┃  ┣ Text (Title) ← Reactive\n'
                            ' ┃  ┣ Row (Stats) ← Reactive\n'
                            ' ┃  ┃  ┣ Column (Posts)\n'
                            ' ┃  ┃  ┣ Column (Followers)\n'
                            ' ┃  ┃  ┗ Column (Following)\n'
                            ' ┃  ┗ Wrap (Buttons)',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13,
                              color: textColor.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _cardColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.lightbulb_outline, 
                                     color: _cardColor, size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Elements marked with ← Reactive update automatically when state changes!',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      color: textColor,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, int value, Color textColor) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: textColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildThemeButton(Color color, IconData icon, String theme) {
    final isSelected = _cardColor == color;
    return InkWell(
      onTap: () => _changeTheme(color, icon, theme),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: isSelected 
              ? Border.all(color: Colors.white, width: 3)
              : null,
          boxShadow: isSelected 
              ? [BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                )]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 4),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
