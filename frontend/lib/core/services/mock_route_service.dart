import 'package:flutter/foundation.dart';

class MockRoute {
  final String id;
  final String title;
  final String description;
  final double distance;
  final double rating;
  final DateTime createdAt;

  MockRoute({
    required this.id,
    required this.title,
    required this.description,
    required this.distance,
    required this.rating,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'distance': distance,
      'rating': rating,
      'createdAt': createdAt,
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
      ),
      MockRoute(
        id: '2',
        title: 'City Safe Loop',
        description: 'Safe urban loop through the city center with dedicated bike lanes.',
        distance: 8.7,
        rating: 4.2,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      MockRoute(
        id: '3',
        title: 'Park Cycling Track',
        description: 'Professional cycling track in the park with various difficulty levels.',
        distance: 12.3,
        rating: 4.8,
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
      MockRoute(
        id: '4',
        title: 'Riverside Trail',
        description: 'Peaceful trail along the river with beautiful nature views.',
        distance: 7.8,
        rating: 4.6,
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      ),
      MockRoute(
        id: '5',
        title: 'Hill Challenge Route',
        description: 'Challenging hilly terrain for experienced cyclists seeking adventure.',
        distance: 15.6,
        rating: 4.9,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
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
      _routes[index] = MockRoute(
        id: existingRoute.id,
        title: data['title'] ?? existingRoute.title,
        description: data['description'] ?? existingRoute.description,
        distance: (data['distance'] ?? existingRoute.distance).toDouble(),
        rating: (data['rating'] ?? existingRoute.rating).toDouble(),
        createdAt: existingRoute.createdAt,
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
}
