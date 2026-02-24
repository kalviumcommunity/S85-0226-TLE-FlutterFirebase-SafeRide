import 'package:flutter/material.dart';

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    
    // Determine device type and layout strategy
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF667eea), const Color(0xFF764ba2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 8,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                _buildHeaderSection(context, isTablet, isLandscape),
                const SizedBox(height: 24),
                
                // Main Content Area
                _buildMainContent(context, isTablet, isLandscape, constraints),
                const SizedBox(height: 24),
                
                // Feature Cards Section
                _buildFeatureCards(context, isTablet, isLandscape),
                const SizedBox(height: 24),
                
                // Footer Section
                _buildFooterSection(context, isTablet),
              ],
            ),
          );
        },
      ),
    );
  }

  // Header Section with responsive design
  Widget _buildHeaderSection(BuildContext context, bool isTablet, bool isLandscape) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 32.0 : 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF667eea), const Color(0xFF764ba2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withOpacity(0.3),
            blurRadius: 20,
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
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Your trusted companion for safe journeys',
            style: TextStyle(
              fontSize: isTablet ? 18 : 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Main Content Area with responsive layout
  Widget _buildMainContent(BuildContext context, bool isTablet, bool isLandscape, BoxConstraints constraints) {
    if (isLandscape && !isTablet) {
      // Landscape phone: Use Row layout
      return Row(
        children: [
          Expanded(child: _buildStatsCard('Active Rides', '247', Icons.directions_car_rounded, const Color(0xFF10b981), isTablet)),
          const SizedBox(width: 16),
          Expanded(child: _buildStatsCard('Safe Journeys', '1,842', Icons.security_rounded, const Color(0xFF667eea), isTablet)),
        ],
      );
    } else if (isTablet) {
      // Tablet: Use GridView
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
    } else {
      // Portrait phone: Use Column
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

  // Individual Stats Card with responsive sizing
  Widget _buildStatsCard(String title, String value, IconData icon, Color color, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 24.0 : 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: isTablet ? 40 : 32,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: isTablet ? 28 : 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Feature Cards Section with responsive grid
  Widget _buildFeatureCards(BuildContext context, bool isTablet, bool isLandscape) {
    final features = [
      {'title': 'Real-time Tracking', 'icon': Icons.gps_fixed, 'color': const Color(0xFF8b5cf6)},
      {'title': 'Emergency SOS', 'icon': Icons.emergency, 'color': const Color(0xFFef4444)},
      {'title': 'Driver Verification', 'icon': Icons.verified_user, 'color': const Color(0xFF14b8a6)},
      {'title': 'Share Trip', 'icon': Icons.share, 'color': const Color(0xFF6366f1)},
    ];

    if (isTablet) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isLandscape ? 4 : 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final feature = features[index];
          return _buildFeatureCard(
            feature['title'] as String,
            feature['icon'] as IconData,
            feature['color'] as Color,
            isTablet,
          );
        },
      );
    } else {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: features.map((feature) {
          return Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 24,
              child: _buildFeatureCard(
                feature['title'] as String,
                feature['icon'] as IconData,
                feature['color'] as Color,
                isTablet,
              ),
            ),
          );
        }).toList(),
      );
    }
  }

  // Individual Feature Card
  Widget _buildFeatureCard(String title, IconData icon, Color color, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 24.0 : 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(isTablet ? 18.0 : 14.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.1), color.withOpacity(0.2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
            ),
            child: Icon(
              icon,
              size: isTablet ? 32 : 24,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Footer Section with responsive buttons
  Widget _buildFooterSection(BuildContext context, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 32.0 : 24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[50]!,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Ready to start your safe journey?',
            style: TextStyle(
              fontSize: isTablet ? 20 : 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (isTablet)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF667eea),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Book a Ride',
                      style: TextStyle(fontSize: isTablet ? 18 : 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: const Color(0xFF667eea), width: 2),
                    ),
                    child: Text(
                      'Become a Driver',
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        color: const Color(0xFF667eea),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF667eea),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Book a Ride',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: const Color(0xFF667eea), width: 2),
                    ),
                    child: Text(
                      'Become a Driver',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF667eea),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
