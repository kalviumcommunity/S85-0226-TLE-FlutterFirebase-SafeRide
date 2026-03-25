import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/services/mock_route_service.dart';

class RouteProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final MockRouteService _mockService = MockRouteService();
  
  bool _isLoading = false;
  String? _errorMessage;
  List<QueryDocumentSnapshot> _routes = [];
  List<Map<String, dynamic>> _mockRoutes = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<QueryDocumentSnapshot> get routes => _routes;
  List<Map<String, dynamic>> get mockRoutes => _mockRoutes;

  // Configuration flag - switch between Firebase and Mock data
  static bool get useMockData => MockRouteService.useMockData;

  Future<void> addRoute(Map<String, dynamic> routeData) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      if (useMockData) {
        // Use mock service
        final mockRoute = await _mockService.addRoute(
          title: routeData['name'] ?? routeData['title'] ?? '',
          description: routeData['description'] ?? '',
          distance: routeData['distance']?.toDouble(),
          rating: routeData['rating']?.toDouble(),
        );
        
        // Convert to map format for UI
        _mockRoutes.add(mockRoute.toMap());
        notifyListeners();
      } else {
        // Use Firebase
        await _firestoreService.addRoute(routeData);
        await fetchRoutes(); // Refresh the routes list
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchRoutes() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      if (useMockData) {
        // Use mock service
        final mockRoutesList = await _mockService.getRoutes();
        _mockRoutes = mockRoutesList.map((route) => route.toMap()).toList();
        notifyListeners();
      } else {
        // Use Firebase
        final snapshot = await _firestoreService.getRoutes();
        _routes = snapshot.docs;
        notifyListeners();
      }
    } catch (e) {
      // Fallback to mock data if Firebase fails
      if (!useMockData) {
        if (kDebugMode) {
          print('Firebase failed, falling back to mock data: $e');
        }
        await _fetchMockRoutesAsFallback();
      } else {
        _errorMessage = e.toString();
        notifyListeners();
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _fetchMockRoutesAsFallback() async {
    try {
      final mockRoutesList = await _mockService.getRoutes();
      _mockRoutes = mockRoutesList.map((route) => route.toMap()).toList();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load routes: $e';
      notifyListeners();
    }
  }

  Stream<QuerySnapshot<Object?>> getRoutesStream() {
    if (RouteProvider.useMockData) {
      // Return a mock stream that updates when notifyListeners is called
      return Stream.value(QuerySnapshotSnapshot() as QuerySnapshot<Object?>);
    } else {
      return _firestoreService.getRoutesStream();
    }
  }

  Future<void> updateRoute(String routeId, Map<String, dynamic> routeData) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      if (useMockData) {
        // Use mock service
        await _mockService.updateRoute(routeId, routeData);
        
        // Update local list
        final index = _mockRoutes.indexWhere((route) => route['id'] == routeId);
        if (index != -1) {
          _mockRoutes[index] = {..._mockRoutes[index], ...routeData};
          notifyListeners();
        }
      } else {
        // Use Firebase
        await _firestoreService.updateRoute(routeId, routeData);
        await fetchRoutes(); // Refresh the routes list
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteRoute(String routeId) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      if (useMockData) {
        // Use mock service
        await _mockService.deleteRoute(routeId);
        
        // Update local list
        _mockRoutes.removeWhere((route) => route['id'] == routeId);
        notifyListeners();
      } else {
        // Use Firebase
        await _firestoreService.deleteRoute(routeId);
        await fetchRoutes(); // Refresh the routes list
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Helper method to get routes data regardless of source
  List<dynamic> get allRoutes {
    if (RouteProvider.useMockData) {
      return _mockRoutes;
    } else {
      return _routes;
    }
  }

  // Helper method to get route count
  int get routesCount {
    if (RouteProvider.useMockData) {
      return _mockRoutes.length;
    } else {
      return _routes.length;
    }
  }
}

// Mock QuerySnapshotSnapshot for stream compatibility
class QuerySnapshotSnapshot {
  final List<QueryDocumentSnapshot> docs = [];
}
