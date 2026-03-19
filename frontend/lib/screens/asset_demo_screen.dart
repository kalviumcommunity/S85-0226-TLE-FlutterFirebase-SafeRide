import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AssetDemoScreen extends StatelessWidget {
  const AssetDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'App Logo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Use SVG logo
                    Image.asset(
                      'assets/images/logo.svg',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'SAFE RIDE\nLogo',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Banner Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Welcome Banner',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Image.asset(
                      'assets/images/banner.svg',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Welcome to SafeRide\nBanner',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Background Image Section
            Card(
              elevation: 4,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: const AssetImage('assets/images/background.svg'),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {},
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Background Image Demo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Icons Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Flutter Built-in Icons',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Material Icons Row
                    const Text(
                      'Material Icons:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 36),
                            const SizedBox(height: 4),
                            const Text('Star', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.favorite, color: Colors.red, size: 36),
                            const SizedBox(height: 4),
                            const Text('Heart', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.home, color: Colors.blue, size: 36),
                            const SizedBox(height: 4),
                            const Text('Home', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.settings, color: Colors.grey, size: 36),
                            const SizedBox(height: 4),
                            const Text('Settings', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Platform-specific Icons Row
                    const Text(
                      'Platform Icons:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.flutter_dash, color: Colors.blue, size: 36),
                            const SizedBox(height: 4),
                            const Text('Flutter', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.android, color: Colors.green, size: 36),
                            const SizedBox(height: 4),
                            const Text('Android', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.apple, color: Colors.grey, size: 36),
                            const SizedBox(height: 4),
                            const Text('Apple', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(CupertinoIcons.heart_fill, color: Colors.red, size: 36),
                            const SizedBox(height: 4),
                            const Text('Cupertino', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Custom Asset Icons Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Custom Asset Icons',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/icons/star.svg',
                              width: 48,
                              height: 48,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.star, color: Colors.amber, size: 48);
                              },
                            ),
                            const SizedBox(height: 4),
                            const Text('Star Icon', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/icons/profile.svg',
                              width: 48,
                              height: 48,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.person, color: Colors.blue, size: 48);
                              },
                            ),
                            const SizedBox(height: 4),
                            const Text('Profile', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Combined Demo Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Combined Assets Demo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.svg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.app_shortcut, color: Colors.deepPurple),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.arrow_forward, color: Colors.grey),
                        const SizedBox(width: 16),
                        Icon(Icons.star, color: Colors.amber, size: 32),
                        const SizedBox(width: 8),
                        Icon(Icons.favorite, color: Colors.red, size: 32),
                        const SizedBox(width: 8),
                        Icon(Icons.thumb_up, color: Colors.green, size: 32),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'SafeRide - Your Trusted Transportation Partner',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
