import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CREATE: Add user data to Firestore
  Future<void> addUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(uid).set(data, SetOptions(merge: true));
    } catch (e) {
      print('Error adding user data: $e');
    }
  }

  // READ: Get user data by UID
  Future<DocumentSnapshot?> getUserData(String uid) async {
    try {
      return await _db.collection('users').doc(uid).get();
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  // READ: Get all users (for admin purposes)
  Stream<QuerySnapshot> getAllUsers() {
    return _db.collection('users').snapshots();
  }

  // UPDATE: Update user data
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(uid).update(data);
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  // DELETE: Delete user data
  Future<void> deleteUserData(String uid) async {
    try {
      await _db.collection('users').doc(uid).delete();
    } catch (e) {
      print('Error deleting user data: $e');
    }
  }

  // CREATE: Add a document to any collection
  Future<void> addDocument(String collectionPath, Map<String, dynamic> data) async {
    try {
      await _db.collection(collectionPath).add(data);
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  // READ: Get documents from a collection with optional query
  Stream<QuerySnapshot> getCollection(String collectionPath, {Query? query}) {
    if (query != null) {
      return query.snapshots();
    }
    return _db.collection(collectionPath).snapshots();
  }

  // UPDATE: Update a document in any collection
  Future<void> updateDocument(String collectionPath, String docId, Map<String, dynamic> data) async {
    try {
      await _db.collection(collectionPath).doc(docId).update(data);
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  // DELETE: Delete a document from any collection
  Future<void> deleteDocument(String collectionPath, String docId) async {
    try {
      await _db.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  // SEARCH: Query documents by field
  Stream<QuerySnapshot> queryByField(String collectionPath, String field, dynamic value) {
    return _db.collection(collectionPath).where(field, isEqualTo: value).snapshots();
  }

  // REAL-TIME: Listen to specific document changes
  Stream<DocumentSnapshot> listenToDocument(String collectionPath, String docId) {
    return _db.collection(collectionPath).doc(docId).snapshots();
  }
}
