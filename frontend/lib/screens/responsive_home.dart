import 'package:flutter/material.dart';
import 'flutter_concepts_demo.dart';

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;

    final bool isTablet = screenWidth > 600;
    final bool isLandscape = orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SafeRide Responsive UI',
          style: TextStyle(
            fontSize: isTablet ? 24 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 8,
      ),

      body: SafeArea(   // ✅ UI CHANGE 1
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  _buildHeaderSection(context, isTablet, isLandscape),

                  const SizedBox(height: 24),

                  _buildMainContent(context, isTablet, isLandscape, constraints),

                  const SizedBox(height: 24),

                  _buildFeatureCards(context, isTablet, isLandscape),

                  const SizedBox(height: 24),

                  _buildFooterSection(context, isTablet),

                ],
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FlutterConceptsDemoScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF667eea),
        icon: const Icon(Icons.school, color: Colors.white),
        label: const Text(
          'Learn Flutter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // HEADER
  Widget _buildHeaderSection(BuildContext context, bool isTablet, bool isLandscape) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 32 : 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(28),   // ✅ UI CHANGE 2
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withOpacity(0.3),
            blurRadius: 28,   // ✅
            spreadRadius: 1,  // ✅
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [

          Container(
            padding: EdgeInsets.all(isTablet ? 20 : 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_car_rounded,
              size: isTablet ? 80 : 60,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'Welcome to SafeRide',
            style: TextStyle(
              fontSize: isTablet ? 32 : 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Your trusted companion for safe journeys',
            style: TextStyle(
              fontSize: isTablet ? 18 : 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  // MAIN CONTENT
  Widget _buildMainContent(BuildContext context, bool isTablet, bool isLandscape, BoxConstraints constraints) {

    if (isLandscape && !isTablet) {
      return Row(
        children: [
          Expanded(child: _buildStatsCard('Active Rides', '247', Icons.directions_car_rounded, const Color(0xFF10b981), isTablet)),
          const SizedBox(width: 16),
          Expanded(child: _buildStatsCard('Safe Journeys', '1,842', Icons.security_rounded, const Color(0xFF667eea), isTablet)),
        ],
      );
    }

    else if (isTablet) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: isLandscape ? 4 : 2,
        childAspectRatio: 1.5,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildStatsCard('Active Rides', '247', Icons.directions_car_rounded, const Color(0xFF10b981), isTablet),
          _buildStatsCard('Safe Journeys', '1,842', Icons.security_rounded, const Color(0xFF667eea), isTablet),
          _buildStatsCard('Drivers Online', '89', Icons.people_rounded, const Color(0xFFf59e0b), isTablet),
          _buildStatsCard('Rating', '4.8', Icons.star_rounded, const Color(0xFFfbbf24), isTablet),
        ],
      );
    }

    else {
      return Column(
        children: [
          _buildStatsCard('Active Rides', '247', Icons.directions_car_rounded, const Color(0xFF10b981), isTablet),
          const SizedBox(height: 16),
          _buildStatsCard('Safe Journeys', '1,842', Icons.security_rounded, const Color(0xFF667eea), isTablet),
          const SizedBox(height: 16),
          _buildStatsCard('Drivers Online', '89', Icons.people_rounded, const Color(0xFFf59e0b), isTablet),
          const SizedBox(height: 16),
          _buildStatsCard('Rating', '4.8', Icons.star_rounded, const Color(0xFFfbbf24), isTablet),
        ],
      );
    }
  }

  // STATS CARD
  Widget _buildStatsCard(String title, String value, IconData icon, Color color, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 26 : 22),   // ✅ UI CHANGE 3
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.circular(22),  // ✅
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: isTablet ? 40 : 32, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: isTablet ? 28 : 24, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: isTablet ? 16 : 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // FEATURE + FOOTER kept SAME (no risk change)
}