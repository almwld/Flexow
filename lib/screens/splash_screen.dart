import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _particleController;
  late AnimationController _textController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 40,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOutBack,
      ),
    );

    _logoRotationAnimation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _logoController.forward();
    _textController.forward();

    // الانتقال المباشر إلى شاشة تسجيل الدخول بعد 5 ثوانٍ
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => 
                const LoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _particleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          _buildParticles(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Transform.scale(
                        scale: _logoScaleAnimation.value,
                        child: Transform.rotate(
                          angle: _logoRotationAnimation.value,
                          child: _buildLogo(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                _buildAppName()
                  .animate(controller: _textController)
                  .fadeIn(duration: 600.ms, delay: 800.ms)
                  .slideY(begin: 0.5, end: 0, duration: 600.ms, delay: 800.ms),
                const SizedBox(height: 20),
                _buildTagline()
                  .animate(controller: _textController)
                  .fadeIn(duration: 600.ms, delay: 1200.ms)
                  .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 1200.ms),
                const SizedBox(height: 60),
                _buildLoadingIndicator()
                  .animate(controller: _textController)
                  .fadeIn(duration: 600.ms, delay: 1500.ms),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: _buildVersionInfo()
              .animate()
              .fadeIn(duration: 800.ms, delay: 2000.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A1A2E),
                const Color(0xFF16213E),
                Color.lerp(
                  const Color(0xFF16213E),
                  const Color(0xFF0F3460),
                  _particleController.value,
                )!,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildParticles() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Stack(
          children: List.generate(20, (index) {
            final random = math.Random(index);
            final x = random.nextDouble() * MediaQuery.of(context).size.width;
            final y = (random.nextDouble() * MediaQuery.of(context).size.height +
                _particleController.value * 100) %
                MediaQuery.of(context).size.height;
            final size = random.nextDouble() * 4 + 2;
            final opacity = random.nextDouble() * 0.5 + 0.2;

            return Positioned(
              left: x,
              top: y,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.goldPrimary.withOpacity(opacity),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.goldPrimary.withOpacity(opacity * 0.5),
                      blurRadius: size * 2,
                      spreadRadius: size * 0.5,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.goldPrimary, AppTheme.goldLight, AppTheme.goldAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppTheme.goldPrimary.withOpacity(0.5),
            blurRadius: 40,
            spreadRadius: 10,
          ),
          BoxShadow(
            color: AppTheme.goldPrimary.withOpacity(0.3),
            blurRadius: 80,
            spreadRadius: 20,
          ),
        ],
      ),
      child: const Icon(
        Icons.shopping_bag,
        size: 80,
        color: Colors.black,
      ),
    );
  }

  Widget _buildAppName() {
    return const Column(
      children: [
        Text(
          'FLEX',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: AppTheme.goldPrimary,
            letterSpacing: 12,
            fontFamily: 'Changa',
            shadows: [
              Shadow(
                color: AppTheme.goldPrimary,
                blurRadius: 20,
              ),
            ],
          ),
        ),
        Text(
          'YEMEN',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppTheme.goldLight,
            letterSpacing: 16,
            fontFamily: 'Changa',
          ),
        ),
      ],
    );
  }

  Widget _buildTagline() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.goldPrimary.withOpacity(0.3),
        ),
      ),
      child: const Text(
        'السوق الإلكتروني اليمني الأول',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white70,
          fontFamily: 'Changa',
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          AppTheme.goldPrimary.withOpacity(0.8),
        ),
        strokeWidth: 3,
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Column(
      children: [
        Text(
          'الإصدار 2.0.0',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.5),
            fontFamily: 'Changa',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'تم التطوير بكل ❤️ في اليمن',
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.4),
            fontFamily: 'Changa',
          ),
        ),
      ],
    );
  }
}
