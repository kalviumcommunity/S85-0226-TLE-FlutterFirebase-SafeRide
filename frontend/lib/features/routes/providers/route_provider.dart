import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/services/firestore_service.dart';

class RouteProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  
  bool _isLoading = false;
  String? _errorMessage;
  List<QueryDocumentSnapshot> _routes = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<QueryDocumentSnapshot> get routes => _routes;

  Future<void> addRoute(Map<String, dynamic> routeData) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _firestoreService.addRoute(routeData);
      await fetchRoutes(); // Refresh the routes list
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
      final snapshot = await _firestoreService.getRoutes();
      _routes = snapshot.docs;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Stream<QuerySnapshot> getRoutesStream() {
    return _firestoreService.getRoutesStream();
  }

  Future<void> updateRoute(String routeId, Map<String, dynamic> routeData) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _firestoreService.updateRoute(routeId, routeData);
      await fetchRoutes(); // Refresh the routes list
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
      await _firestoreService.deleteRoute(routeId);
      await fetchRoutes(); // Refresh the routes list
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
}
