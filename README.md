# 🚴 SafeRide - Responsive Mobile UI

SafeRide is a Flutter + Firebase mobile app that helps runners and cyclists discover safe, community-reviewed routes.

## 📌 Problem
Urban runners and cyclists lack access to trusted, safety-focused route recommendations. Most apps prioritize speed over safety.

## 💡 Solution
SafeRide enables users to:
- Discover community-verified routes
- Add and rate routes
- View real-time updates

## 📱 Responsive UI Implementation

### Overview
This project demonstrates a fully responsive mobile interface that adapts seamlessly across different screen sizes, orientations, and device types using Flutter's powerful layout system.

### New Responsive Layout Screen
We've implemented a dedicated **Responsive Layout Dashboard** (`/responsive-layout`) that showcases advanced responsive design techniques using **Rows, Columns, and Containers**.

#### Key Implementation Details:

**Screen Detection Using MediaQuery:**
```dart
final screenWidth = MediaQuery.of(context).size.width;
final screenHeight = MediaQuery.of(context).size.height;
final isTablet = screenWidth > 600;
final isLargeScreen = screenWidth > 1200;
```

**Three Layout Strategies:**
1. **Phone Layout** (< 600px): Vertical stacking with compact design
2. **Tablet Layout** (600px - 1200px): Split-screen with side-by-side panels
3. **Large Screen Layout** (> 1200px): Multi-column dashboard layout

**Container Usage Examples:**
```dart
// Header container with gradient and shadow
Container(
  padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.grey.shade50, Colors.grey.shade100],
    ),
  ),
  child: // content
)

// Feature cards with rounded corners and shadows
Container(
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
  child: // card content
)
```

**Row and Column Implementations:**
```dart
// Phone: Vertical Column layout
Column(
  children: [
    Container(header),
    SizedBox(height: 16),
    Expanded(child: Row(features)), // Horizontal feature row
    SizedBox(height: 16),
    Container(status panel),
  ],
)

// Tablet: Side-by-side Row layout
Row(
  children: [
    Expanded(child: Column(header + features)),
    SizedBox(width: 20),
    Expanded(child: Container(status panel)),
  ],
)
```

### Key Features
- **Adaptive Layout**: Automatically adjusts between phone, tablet, and large screen layouts
- **Orientation Support**: Optimized for both portrait and landscape modes
- **Dynamic Sizing**: Text, padding, and components scale based on screen dimensions
- **Flexible Grids**: Uses different grid configurations for various screen sizes

### Code Implementation

#### MediaQuery for Screen Detection
```dart
// Get screen dimensions using MediaQuery
final screenWidth = MediaQuery.of(context).size.width;
final screenHeight = MediaQuery.of(context).size.height;
final orientation = MediaQuery.of(context).orientation;

// Determine device type and layout strategy
final bool isTablet = screenWidth > 600;
final bool isLandscape = orientation == Orientation.landscape;
```

#### LayoutBuilder for Dynamic Layouts
```dart
LayoutBuilder(
  builder: (context, constraints) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
      child: Column(
        children: [
          _buildHeaderSection(context, isTablet, isLandscape),
          _buildMainContent(context, isTablet, isLandscape, constraints),
          _buildFeatureCards(context, isTablet, isLandscape),
          _buildFooterSection(context, isTablet),
        ],
      ),
    );
  },
)
```

#### Responsive Grid Implementation
```dart
// Tablet: Use GridView
GridView.count(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  crossAxisCount: isLandscape ? 4 : 2,
  childAspectRatio: 1.5,
  mainAxisSpacing: 16,
  crossAxisSpacing: 16,
  children: [
    _buildStatsCard('Active Rides', '247', Icons.directions_car, Colors.green, isTablet),
    _buildStatsCard('Safe Journeys', '1,842', Icons.security, Colors.blue, isTablet),
    // ... more cards
  ],
)
```

### Responsive Features Demonstrated

1. **Header Section**: Scales text and icon sizes based on device type
2. **Stats Cards**: 
   - Phones: Single column layout
   - Tablets: 2x2 grid (portrait) or 4x1 grid (landscape)
   - Landscape phones: Horizontal row layout
3. **Feature Cards**: Adaptive grid layout with flexible wrapping
4. **Footer Buttons**: Side-by-side on tablets, stacked on phones

### Screenshots

#### Phone - Portrait Mode
![Phone Portrait](assets/phone_portrait.png)

#### Phone - Landscape Mode  
![Phone Landscape](assets/phone_landscape.png)

#### Tablet - Portrait Mode
![Tablet Portrait](assets/tablet_portrait.png)

#### Tablet - Landscape Mode
![Tablet Landscape](assets/tablet_landscape.png)

## 🚀 MVP Features
- Firebase Authentication (Sign Up / Login / Logout)
- Add Route (name, description, distance, rating)
- View Routes (real-time Firestore data)
- User Profile

## 🛠 Tech Stack
- Flutter & Dart
- Firebase Authentication
- Cloud Firestore

## ⚙️ Setup
```bash
git clone https://github.com/<your-username>/S85-0226-TLE-FlutterFirebase-SafeRide.git
cd S85-0226-TLE-FlutterFirebase-SafeRide
flutter pub get
flutter run
```

Configure Firebase:
- Enable Email/Password Authentication
- Create Firestore database
- Add `google-services.json` to `android/app/`

## 🎯 Goal
Deliver a demo-ready MVP with working Auth + Firestore integration by the end of Sprint 2.

## 💭 Reflection on Responsive Design

### Challenges Faced
1. **Layout Complexity**: Managing multiple layout conditions (phone/tablet × portrait/landscape) required careful state management
2. **Content Overflow**: Ensuring text and components don't overflow on smaller screens while utilizing space efficiently on larger screens
3. **Consistent Spacing**: Maintaining visual hierarchy across different screen sizes while keeping proportions balanced
4. **Performance**: Optimizing layout calculations to prevent jank during orientation changes

### How Responsive Design Improves Usability
1. **Consistent Experience**: Users get a familiar, optimized interface regardless of their device
2. **Better Content Utilization**: Larger screens display more information efficiently, smaller screens focus on essential content
3. **Accessibility**: Text remains readable and touch targets stay appropriately sized across all devices
4. **Future-Proof**: The app adapts to new screen sizes and form factors without requiring redesign

### Key Learnings
- **MediaQuery** is essential for detecting screen dimensions and orientation
- **LayoutBuilder** provides powerful constraints-based design capabilities
- **Flexible widgets** (Expanded, Flexible, Wrap) are crucial for adaptive layouts
- **Conditional rendering** based on screen size creates truly responsive experiences

---

Built as part of Kalvium Simulated Work – Sprint 2 (Flutter & Firebase).



This PR implements a responsive layout for the SafeRide home screen using core Flutter layout widgets like Container, Row and Column.

The UI adapts dynamically to different screen sizes and orientations using MediaQuery, LayoutBuilder and Expanded widgets.

Key Features:
- Header section with gradient background
- Responsive stats cards layout (Column for portrait, Row for landscape, Grid for tablet)
- Feature cards displayed using Wrap/GridView
- Footer section with responsive buttons
- SafeArea added for better device compatibility
- Improved card spacing and rounded design

Responsiveness was achieved by detecting screen width and orientation and switching layout strategies accordingly.

Screenshots and demo video are added in the README.