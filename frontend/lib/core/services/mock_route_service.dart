import 'package:flutter/foundation.dart';
import 'dart:math';

class MockRoute {
  final String id;
  final String title;
  final String description;
  final double distance;
  final double rating;
  final DateTime createdAt;
  final String difficulty;
  final double elevation;
  final int estimatedTimeMinutes;
  final List<String> waypoints;
  final bool isFavorite;

  MockRoute({
    required this.id,
    required this.title,
    required this.description,
    required this.distance,
    required this.rating,
    required this.createdAt,
    this.difficulty = 'Moderate',
    this.elevation = 0.0,
    this.estimatedTimeMinutes = 0,
    this.waypoints = const [],
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'distance': distance,
      'rating': rating,
      'createdAt': createdAt,
      'difficulty': difficulty,
      'elevation': elevation,
      'estimatedTimeMinutes': estimatedTimeMinutes,
      'waypoints': waypoints,
      'isFavorite': isFavorite,
    };
  }

  factory MockRoute.fromMap(Map<String, dynamic> map) {
    return MockRoute(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      distance: (map['distance'] ?? 0.0).toDouble(),
      rating: (map['rating'] ?? 0.0).toDouble(),
      createdAt: map['createdAt'] is DateTime 
          ? map['createdAt'] 
          : DateTime.now(),
      difficulty: map['difficulty'] ?? 'Moderate',
      elevation: (map['elevation'] ?? 0.0).toDouble(),
      estimatedTimeMinutes: map['estimatedTimeMinutes'] ?? 0,
      waypoints: List<String>.from(map['waypoints'] ?? []),
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  MockRoute copyWith({
    String? id,
    String? title,
    String? description,
    double? distance,
    double? rating,
    DateTime? createdAt,
    String? difficulty,
    double? elevation,
    int? estimatedTimeMinutes,
    List<String>? waypoints,
    bool? isFavorite,
  }) {
    return MockRoute(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      difficulty: difficulty ?? this.difficulty,
      elevation: elevation ?? this.elevation,
      estimatedTimeMinutes: estimatedTimeMinutes ?? this.estimatedTimeMinutes,
      waypoints: waypoints ?? this.waypoints,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class MockRouteService {
  static final MockRouteService _instance = MockRouteService._internal();
  factory MockRouteService() => _instance;
  MockRouteService._internal();

  final List<MockRoute> _routes = [];
  bool _isInitialized = false;

  // Configuration flag
  static bool useMockData = true;

  // Initialize with dummy data
  Future<void> initializeMockData() async {
    if (_isInitialized) return;

    _routes.addAll([
      MockRoute(
        id: '1',
        title: 'Lake Morning Ride',
        description: 'Beautiful scenic route around the lake with fresh morning air. Perfect for beginners.',
        distance: 5.2,
        rating: 4.5,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        difficulty: 'Beginner',
        elevation: 25.0,
        estimatedTimeMinutes: 18,
        waypoints: ['Lake View Point', 'Sunset Bridge', 'Morning Pier'],
        isFavorite: true,
      ),
      MockRoute(
        id: '2',
        title: 'City Safe Loop',
        description: 'Safe urban loop through the city center with dedicated bike lanes.',
        distance: 8.7,
        rating: 4.2,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        difficulty: 'Moderate',
        elevation: 45.0,
        estimatedTimeMinutes: 32,
        waypoints: ['Central Square', 'Bike Lane Avenue', 'City Park'],
        isFavorite: false,
      ),
      MockRoute(
        id: '3',
        title: 'Park Cycling Track',
        description: 'Professional cycling track in the park with various difficulty levels.',
        distance: 12.3,
        rating: 4.8,
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        difficulty: 'Pro',
        elevation: 80.0,
        estimatedTimeMinutes: 45,
        waypoints: ['Park Entrance', 'Professional Track', 'Hill Section'],
        isFavorite: true,
      ),
      MockRoute(
        id: '4',
        title: 'Riverside Trail',
        description: 'Peaceful trail along the river with beautiful nature views.',
        distance: 7.8,
        rating: 4.6,
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        difficulty: 'Moderate',
        elevation: 30.0,
        estimatedTimeMinutes: 28,
        waypoints: ['River Bridge', 'Nature Reserve', 'Picnic Area'],
        isFavorite: false,
      ),
      MockRoute(
        id: '5',
        title: 'Hill Challenge Route',
        description: 'Challenging hilly terrain for experienced cyclists seeking adventure.',
        distance: 15.6,
        rating: 4.9,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        difficulty: 'Pro',
        elevation: 250.0,
        estimatedTimeMinutes: 58,
        waypoints: ['Base Camp', 'Hill Summit', 'Valley View'],
        isFavorite: true,
      ),
    ]);

    _isInitialized = true;
    
    if (kDebugMode) {
      print('Mock data initialized with ${_routes.length} routes');
    }
  }

  // Get all routes
  Future<List<MockRoute>> getRoutes() async {
    await initializeMockData();
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return List.from(_routes);
  }

  // Add new route
  Future<MockRoute> addRoute({
    required String title,
    required String description,
    double? distance,
    double? rating,
  }) async {
    await initializeMockData();
    
    final newRoute = MockRoute(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      distance: distance ?? 0.0,
      rating: rating ?? 0.0,
      createdAt: DateTime.now(),
      difficulty: _calculateDifficulty(distance ?? 0.0),
      elevation: _generateElevation(distance ?? 0.0),
      estimatedTimeMinutes: _calculateEstimatedTime(distance ?? 0.0),
      waypoints: _generateWaypoints(),
      isFavorite: (rating ?? 0.0) >= 4.5,
    );

    _routes.add(newRoute);
    
    if (kDebugMode) {
      print('Added new route: ${newRoute.title}');
    }
    
    return newRoute;
  }

  // Update route
  Future<void> updateRoute(String id, Map<String, dynamic> data) async {
    await initializeMockData();
    
    final index = _routes.indexWhere((route) => route.id == id);
    if (index != -1) {
      final existingRoute = _routes[index];
      _routes[index] = existingRoute.copyWith(
        title: data['title'] ?? existingRoute.title,
        description: data['description'] ?? existingRoute.description,
        distance: (data['distance'] ?? existingRoute.distance).toDouble(),
        rating: (data['rating'] ?? existingRoute.rating).toDouble(),
        difficulty: data['distance'] != null 
            ? _calculateDifficulty(data['distance'])
            : existingRoute.difficulty,
        elevation: data['distance'] != null 
            ? _generateElevation(data['distance'])
            : existingRoute.elevation,
        estimatedTimeMinutes: data['distance'] != null 
            ? _calculateEstimatedTime(data['distance'])
            : existingRoute.estimatedTimeMinutes,
        isFavorite: data['rating'] != null 
            ? (data['rating'] >= 4.5)
            : existingRoute.isFavorite,
      );
      
      if (kDebugMode) {
        print('Updated route: ${_routes[index].title}');
      }
    }
  }

  // Delete route
  Future<void> deleteRoute(String id) async {
    await initializeMockData();
    
    _routes.removeWhere((route) => route.id == id);
    
    if (kDebugMode) {
      print('Deleted route with id: $id');
    }
  }

  // Get route by id
  Future<MockRoute?> getRoute(String id) async {
    await initializeMockData();
    
    try {
      return _routes.firstWhere((route) => route.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get routes count
  int get routesCount => _routes.length;

  // Clear all routes (for testing)
  Future<void> clearAllRoutes() async {
    _routes.clear();
    _isInitialized = false;
    
    if (kDebugMode) {
      print('Cleared all mock routes');
    }
  }

  // Dynamic aggregation methods
  MockRouteStatistics getStatistics() {
    if (_routes.isEmpty) {
      return MockRouteStatistics(
        totalRoutes: 0,
        totalDistance: 0.0,
        averageRating: 0.0,
        favoriteRoutes: 0,
        averageDistance: 0.0,
        longestRoute: 0.0,
        shortestRoute: 0.0,
        totalEstimatedTime: 0,
        averageEstimatedTime: 0,
        difficultyDistribution: {'Beginner': 0, 'Moderate': 0, 'Pro': 0},
        elevationGain: 0.0,
        averageElevation: 0.0,
      );
    }

    final totalDistance = _routes.fold<double>(0.0, (sum, route) => sum + route.distance);
    final totalRating = _routes.fold<double>(0.0, (sum, route) => sum + route.rating);
    final favoriteCount = _routes.where((route) => route.isFavorite).length;
    final longestRoute = _routes.map((r) => r.distance).reduce(max);
    final shortestRoute = _routes.map((r) => r.distance).reduce(min);
    final totalTime = _routes.fold<int>(0, (sum, route) => sum + route.estimatedTimeMinutes);
    final totalElevation = _routes.fold<double>(0.0, (sum, route) => sum + route.elevation);

    final difficultyDistribution = <String, int>{};
    for (final route in _routes) {
      difficultyDistribution[route.difficulty] = (difficultyDistribution[route.difficulty] ?? 0) + 1;
    }

    return MockRouteStatistics(
      totalRoutes: _routes.length,
      totalDistance: totalDistance,
      averageRating: totalRating / _routes.length,
      favoriteRoutes: favoriteCount,
      averageDistance: totalDistance / _routes.length,
      longestRoute: longestRoute,
      shortestRoute: shortestRoute,
      totalEstimatedTime: totalTime,
      averageEstimatedTime: totalTime ~/ _routes.length,
      difficultyDistribution: difficultyDistribution,
      elevationGain: totalElevation,
      averageElevation: totalElevation / _routes.length,
    );
  }

  // Helper methods
  String _calculateDifficulty(double distance) {
    if (distance < 5) {
      return 'Beginner';
    } else if (distance < 10) {
      return 'Moderate';
    } else {
      return 'Pro';
    }
  }

  double _generateElevation(double distance) {
    final random = Random();
    final baseElevation = distance * 5; // 5m elevation per km base
    final variation = random.nextDouble() * distance * 3; // Random variation
    return baseElevation + variation;
  }

  int _calculateEstimatedTime(double distance) {
    // Average cycling speed: 15 km/h for moderate terrain
    final baseSpeed = 15.0;
    final adjustedSpeed = baseSpeed - (distance * 0.1); // Slower on longer routes
    final timeInHours = distance / adjustedSpeed;
    return (timeInHours * 60).round(); // Convert to minutes
  }

  List<String> _generateWaypoints() {
    final random = Random();
    final allWaypoints = [
      'Starting Point', 'Scenic View', 'Rest Area', 'Historic Landmark',
      'Nature Reserve', 'City Center', 'Park Entrance', 'Bridge Crossing',
      'Hill Summit', 'Valley View', 'Lake Shore', 'Forest Trail'
    ];
    
    final count = random.nextInt(3) + 2; // 2-4 waypoints
    final selected = <String>[];
    
    for (int i = 0; i < count; i++) {
      final index = random.nextInt(allWaypoints.length);
      if (!selected.contains(allWaypoints[index])) {
        selected.add(allWaypoints[index]);
      }
    }
    
    return selected;
  }
}

class MockRouteStatistics {
  final int totalRoutes;
  final double totalDistance;
  final double averageRating;
  final int favoriteRoutes;
  final double averageDistance;
  final double longestRoute;
  final double shortestRoute;
  final int totalEstimatedTime;
  final int averageEstimatedTime;
  final Map<String, int> difficultyDistribution;
  final double elevationGain;
  final double averageElevation;

  MockRouteStatistics({
    required this.totalRoutes,
    required this.totalDistance,
    required this.averageRating,
    required this.favoriteRoutes,
    required this.averageDistance,
    required this.longestRoute,
    required this.shortestRoute,
    required this.totalEstimatedTime,
    required this.averageEstimatedTime,
    required this.difficultyDistribution,
    required this.elevationGain,
    required this.averageElevation,
  });

  // Computed properties
  double get safetyScore {
    double score = 50.0; // Base score
    
    // Rating component (40% of score)
    score += (averageRating / 5.0) * 40.0;
    
    // Distance component (20% of score, max at 50km)
    score += (totalDistance / 50.0).clamp(0.0, 1.0) * 20.0;
    
    // Route variety component (10% of score, max at 10 routes)
    score += (totalRoutes / 10.0).clamp(0.0, 1.0) * 10.0;
    
    return score.clamp(0.0, 100.0);
  }

  String get experienceLevel {
    if (totalDistance >= 100 || totalRoutes >= 10) {
      return 'Pro';
    } else if (totalDistance >= 50 || totalRoutes >= 5) {
      return 'Advanced';
    } else if (totalDistance >= 20 || totalRoutes >= 3) {
      return 'Intermediate';
    } else {
      return 'Beginner';
    }
  }

  double get experienceProgress {
    switch (experienceLevel) {
      case 'Pro':
        return 1.0;
      case 'Advanced':
        return 0.75;
      case 'Intermediate':
        return 0.5;
      case 'Beginner':
        return 0.25;
      default:
        return 0.0;
    }
  }

  String get totalDistanceFormatted => '${totalDistance.toStringAsFixed(1)} km';
  String get averageDistanceFormatted => '${averageDistance.toStringAsFixed(1)} km';
  String get averageRatingFormatted => '${averageRating.toStringAsFixed(1)} ⭐';
  String get safetyScoreFormatted => '${safetyScore.toStringAsFixed(0)}%';
  String get totalTimeFormatted {
    final hours = totalEstimatedTime ~/ 60;
    final minutes = totalEstimatedTime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
