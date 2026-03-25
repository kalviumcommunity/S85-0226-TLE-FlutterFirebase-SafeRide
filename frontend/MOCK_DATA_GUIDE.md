# SafeRide Mock Data Implementation Guide

## Overview

This document explains how the mock data system works in SafeRide to replace Firebase functionality when needed.

## 📍 Where Mock Data Lives

### Core Files:
- **`lib/core/services/mock_route_service.dart`** - Main mock data service
- **`lib/features/routes/providers/route_provider.dart`** - Enhanced with mock support

## 🎛️️ Mock Data Configuration

### Global Switch
```dart
// In mock_route_service.dart
static bool useMockData = true;
```

### How to Switch Between Firebase & Mock Data

**To use Mock Data:**
```dart
// Set this to true in mock_route_service.dart
static bool useMockData = true;
```

**To use Firebase:**
```dart
// Set this to false in mock_route_service.dart  
static bool useMockData = false;
```

## 📊 Mock Data Structure

### MockRoute Model
```dart
class MockRoute {
  final String id;           // Unique identifier
  final String title;         // Route name
  final String description;    // Route description  
  final double distance;      // Distance in km
  final double rating;        // Rating 0-5 stars
  final DateTime createdAt;   // Creation timestamp
}
```

### Pre-loaded Dummy Routes
1. **Lake Morning Ride** - 5.2 km, 4.5⭐
2. **City Safe Loop** - 8.7 km, 4.2⭐  
3. **Park Cycling Track** - 12.3 km, 4.8⭐
4. **Riverside Trail** - 7.8 km, 4.6⭐
5. **Hill Challenge Route** - 15.6 km, 4.9⭐

## 🔄 How It Works

### RouteProvider Logic
```dart
// Automatic fallback system
try {
  if (RouteProvider.useMockData) {
    // Use mock service
    await _mockService.getRoutes();
  } else {
    // Use Firebase
    await _firestoreService.getRoutes();
  }
} catch (e) {
  // Firebase fails → fallback to mock data
  if (!RouteProvider.useMockData) {
    await _fetchMockRoutesAsFallback();
  }
}
```

### UI Compatibility
- **Mobile**: ListView layout
- **Tablet**: 2-column GridView
- **Desktop**: 3-column GridView
- **Dark Mode**: Fully supported
- **Responsive**: All breakpoints maintained

## 🎯 Features Available

### ✅ Working with Mock Data
- [x] View all routes
- [x] Add new routes locally
- [x] Delete routes locally  
- [x] Edit route information
- [x] Responsive layouts
- [x] Dark mode toggle
- [x] Dashboard statistics
- [x] Route details dialog
- [x] Real-time UI updates

### 📝️ Add Route Dialog
```dart
// Fields available:
- Route Name (required)
- Description (optional)
- Distance in km (optional)
- Rating 0-5 (optional)
```

## 🔄 Switching Back to Firebase

### Step 1: Update Configuration
```dart
// In lib/core/services/mock_route_service.dart
static bool useMockData = false;
```

### Step 2: Ensure Firebase Setup
1. Add `google-services.json` to `android/app/`
2. Configure Firestore security rules
3. Enable billing if needed

### Step 3: Test Integration
```bash
flutter analyze
flutter run
```

## 🚨 Error Handling

### Mock Data Errors
- Network simulation (500ms delay)
- Input validation
- Duplicate ID prevention
- Graceful fallbacks

### Firebase Fallback
- Automatic mock data loading on Firebase failure
- Debug logging when fallback occurs
- User notification of data source

## 📱 UI Behavior

### Loading States
- Shows loading spinner during operations
- Simulated network delay for realism
- Error messages with retry options

### Empty States
- Friendly "No routes yet" message
- Call-to-action for adding first route
- Consistent across all layouts

### Statistics Dashboard
- **Routes Count**: Total number of routes
- **Total Distance**: Sum of all route distances  
- **Average Rating**: Mean of all route ratings
- **Real-time updates**: Instant UI refresh

## 🔧 Development Tips

### Adding New Mock Routes
```dart
// In MockRouteService.initializeMockData()
MockRoute(
  id: 'unique-id',
  title: 'Route Name',
  description: 'Route description',
  distance: 10.0,
  rating: 4.5,
  createdAt: DateTime.now(),
)
```

### Testing Both Data Sources
```dart
// Toggle between sources for testing
MockRouteService.useMockData = true;  // Test mock
MockRouteService.useMockData = false; // Test Firebase
```

## 🎉 Benefits

### Mock Data Advantages
- ✅ No Firebase dependency
- ✅ Instant UI response
- ✅ No billing requirements
- ✅ Offline development
- ✅ Consistent test data
- ✅ Firebase fallback safety

### Production Ready
- ✅ Easy Firebase switch
- ✅ Seamless data migration
- ✅ No UI changes needed
- ✅ Maintains all features

---

**Note**: This mock system ensures your SafeRide app works perfectly regardless of Firebase availability or billing status.
