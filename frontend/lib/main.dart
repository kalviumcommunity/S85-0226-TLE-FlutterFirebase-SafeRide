import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'core/services/firebase_service.dart';
import 'core/theme/theme_provider.dart';
import 'core/theme/app_colors.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/routes/providers/route_provider.dart';
import 'navigation/app_router.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'navigation/bottom_nav.dart';
import 'widgets/common/loading_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");
                                           
  // Initialize Firebase
  await FirebaseService.initializeFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RouteProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'SafeRide',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            onGenerateRoute: AppRouter.generateRoute,
            home: StreamBuilder(
              stream: Provider.of<AuthProvider>(context).authStateChanges,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    backgroundColor: AppColors.primaryBackground,
                    body: Center(
                      child: LoadingWidget(
                        message: 'Initializing SafeRide...',
                        size: 80,
                      ),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  return const BottomNavigation();
                }

                return const LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}