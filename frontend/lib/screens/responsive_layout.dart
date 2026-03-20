import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 1200;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeRide Dashboard'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Container(
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade50,
              Colors.grey.shade100,
            ],
          ),
        ),
        child: isLargeScreen 
            ? _buildLargeScreenLayout(context, screenWidth, screenHeight)
            : isTablet 
                ? _buildTabletLayout(context, screenWidth, screenHeight)
                : _buildPhoneLayout(context, screenWidth, screenHeight),
      ),
    );
  }

  // Phone Layout - Vertical stacking
  Widget _buildPhoneLayout(BuildContext context, double screenWidth, double screenHeight) {
    return Column(
      children: [
        // Header Section
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade400,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade200,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.directions_car,
                size: 48,
                color: Colors.white,
              ),
              SizedBox(height: 8),
              Text(
                'SafeRide',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Your Safety Companion',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Features Section
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildFeatureCard(
                      icon: Icons.location_on,
                      title: 'Live Tracking',
                      color: Colors.red.shade400,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildFeatureCard(
                      icon: Icons.emergency,
                      title: 'Emergency',
                      color: Colors.orange.shade400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildFeatureCard(
                      icon: Icons.route,
                      title: 'Safe Routes',
                      color: Colors.green.shade400,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildFeatureCard(
                      icon: Icons.people,
                      title: 'Contacts',
                      color: Colors.blue.shade400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Status Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Status',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatusItem('Speed', '45 km/h', Icons.speed),
                              _buildStatusItem('Location', 'Safe Zone', Icons.location_city),
                              _buildStatusItem('Battery', '85%', Icons.battery_full),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Tablet Layout - Mix of horizontal and vertical
  Widget _buildTabletLayout(BuildContext context, double screenWidth, double screenHeight) {
    return Row(
      children: [
        // Left Panel - Header and Features
        Expanded(
          flex: 1,
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade400,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_car,
                      size: 56,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'SafeRide',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Your Safety Companion',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Features Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildFeatureCard(
                      icon: Icons.location_on,
                      title: 'Live Tracking',
                      color: Colors.red.shade400,
                    ),
                    _buildFeatureCard(
                      icon: Icons.emergency,
                      title: 'Emergency',
                      color: Colors.orange.shade400,
                    ),
                    _buildFeatureCard(
                      icon: Icons.route,
                      title: 'Safe Routes',
                      color: Colors.green.shade400,
                    ),
                    _buildFeatureCard(
                      icon: Icons.people,
                      title: 'Contacts',
                      color: Colors.blue.shade400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 20),
        
        // Right Panel - Status
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Status',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatusItem('Speed', '45 km/h', Icons.speed),
                        _buildStatusItem('Location', 'Safe Zone', Icons.location_city),
                        _buildStatusItem('Battery', '85%', Icons.battery_full),
                        _buildStatusItem('Trip Time', '25 min', Icons.access_time),
                        _buildStatusItem('Distance', '12.5 km', Icons.straighten),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Large Screen Layout - More horizontal space
  Widget _buildLargeScreenLayout(BuildContext context, double screenWidth, double screenHeight) {
    return Column(
      children: [
        // Header Section
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade400,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade200,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.directions_car,
                size: 64,
                color: Colors.white,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SafeRide Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your Safety Companion',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Main Content Area
        Expanded(
          child: Row(
            children: [
              // Left Panel - Features
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Features',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            children: [
                              _buildFeatureCard(
                                icon: Icons.location_on,
                                title: 'Live Tracking',
                                color: Colors.red.shade400,
                              ),
                              _buildFeatureCard(
                                icon: Icons.emergency,
                                title: 'Emergency',
                                color: Colors.orange.shade400,
                              ),
                              _buildFeatureCard(
                                icon: Icons.route,
                                title: 'Safe Routes',
                                color: Colors.green.shade400,
                              ),
                              _buildFeatureCard(
                                icon: Icons.people,
                                title: 'Contacts',
                                color: Colors.blue.shade400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 24),
              
              // Right Panel - Status
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'System Status',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatusItem('Speed', '45 km/h', Icons.speed),
                              _buildStatusItem('Location', 'Safe Zone', Icons.location_city),
                              _buildStatusItem('Battery', '85%', Icons.battery_full),
                              _buildStatusItem('Trip Time', '25 min', Icons.access_time),
                              _buildStatusItem('Distance', '12.5 km', Icons.straighten),
                              _buildStatusItem('GPS Signal', 'Strong', Icons.gps_fixed),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.deepPurple.shade400,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
