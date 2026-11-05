import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_selection_screen.dart';
//import 'home_screen.dart'; // We'll create this later

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();

    // Navigate after delay
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Check if user has already selected language and logged in
    final prefs = await SharedPreferences.getInstance();
    final hasSelectedLanguage = prefs.getString('preferred_language') != null;
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    final userRole = prefs.getString('user_role');

    if (!mounted) return;

    if (isLoggedIn && userRole != null) {
      // User is logged in, go to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else if (hasSelectedLanguage) {
      // Language selected but not logged in, go to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      // First time user, go to language selection
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LanguageSelectionScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6B46C1),
              Color(0xFF9F7AEA),
              Color(0xFFB794F4),
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App Icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            '🌱',
                            style: TextStyle(fontSize: 60),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // App Name
                      const Text(
                        'KaamSetu',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Tagline
                      Text(
                        'Work from Home, Earn with Pride',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 60),

                      // Loading indicator
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white.withOpacity(0.8),
                          ),
                          strokeWidth: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Placeholder for LoginScreen (we'll build this next)
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Screen - Coming Next'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simulate login for testing
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text('Go to Home (Demo)'),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for HomeScreen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KaamSetu Home'),
        backgroundColor: const Color(0xFF6B46C1),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Home Screen - Coming Next'),
      ),
    );
  }
}