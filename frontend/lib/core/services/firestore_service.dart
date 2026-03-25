import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String routesCollection = 'routes';

  // Routes CRUD operations
  Future<DocumentReference> addRoute(Map<String, dynamic> routeData) async {
    try {
      return await _db.collection(routesCollection).add(routeData);
    } catch (e) {
      if (kDebugMode) {
        print('Error adding route: $e');
      }
      throw 'Failed to add route. Please try again.';
    }
  }

  Future<QuerySnapshot> getRoutes() async {
    try {
      return await _db
          .collection(routesCollection)
          .orderBy('createdAt', descending: true)
          .get();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching routes: $e');
      }
      throw 'Failed to fetch routes. Please try again.';
    }
  }

  Stream<QuerySnapshot> getRoutesStream() {
    return _db
        .collection(routesCollection)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateRoute(String routeId, Map<String, dynamic> routeData) async {
    try {
      await _db.collection(routesCollection).doc(routeId).update(routeData);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating route: $e');
      }
      throw 'Failed to update route. Please try again.';
    }
  }

  Future<void> deleteRoute(String routeId) async {
    try {
      await _db.collection(routesCollection).doc(routeId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting route: $e');
      }
      throw 'Failed to delete route. Please try again.';
    }
  }

  Future<DocumentSnapshot> getRoute(String routeId) async {
    try {
      return await _db.collection(routesCollection).doc(routeId).get();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching route: $e');
      }
      throw 'Failed to fetch route. Please try again.';
    }
  }
}
