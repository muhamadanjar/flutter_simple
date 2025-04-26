import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    await Future.delayed(const Duration(seconds: 2));

    // Check if the widget is still mounted before proceeding
    if (!mounted) return;

    // Gunakan authRepository untuk mendapatkan Stream authStateChanges
    final authRepository = ref.read(authRepositoryProvider);

    // Listen one time to the stream for navigation
    authRepository.authStateChanges.first.then((authResult) {
      if (!mounted) return;

      if (authResult.isAuthenticated) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    });
    context.go('/login');

    // Alternatif: bisa juga menggunakan currentUserProvider
    // final user = await ref.read(currentUserProvider.future);
    // if (!mounted) return;
    //
    // if (user != null) {
    //   context.go('/home');
    // } else {
    //   context.go('/login');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo or icon
            Icon(
              Icons.lock,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),

            // App name
            Text(
              'Flutter Auth App',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 48),

            // Loading indicator
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}