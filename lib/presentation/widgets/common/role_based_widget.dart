import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/auth_provider.dart';

/// Widget yang hanya menampilkan kontennya jika user memiliki role yang sesuai
class RoleBasedWidget extends ConsumerWidget {
  final String role;
  final Widget child;
  final Widget? fallbackWidget;

  const RoleBasedWidget({
    super.key,
    required this.role,
    required this.child,
    this.fallbackWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return currentUser.when(
      data: (user) {
        if (user == null) {
          return fallbackWidget ?? const SizedBox.shrink();
        }

        // Periksa jika user memiliki role yang diperlukan
        if (user.roles.any((role) => role.name == role)) {
          return child;
        }

        return fallbackWidget ?? const SizedBox.shrink();
      },
      loading: () => fallbackWidget ?? const SizedBox.shrink(),
      error: (_, __) => fallbackWidget ?? const SizedBox.shrink(),
    );
  }
}

/// Widget yang membatasi akses ke halaman hanya untuk role tertentu
class RoleGateScreen extends ConsumerWidget {
  final String requiredRole;
  final Widget authorizedScreen;
  final Widget unauthorizedScreen;

  const RoleGateScreen({
    super.key,
    required this.requiredRole,
    required this.authorizedScreen,
    required this.unauthorizedScreen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthorized = ref.watch(authorizationNotifierProvider(requiredRole));

    return isAuthorized.when(
      data: (authorized) {
        if (authorized) {
          return authorizedScreen;
        } else {
          return unauthorizedScreen;
        }
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => unauthorizedScreen,
    );
  }
}

/// Route guard untuk Go Router yang memastikan hanya user dengan role
/// tertentu yang dapat mengakses rute yang dilindungi
class RoleGuard {
  final String requiredRole;

  RoleGuard(this.requiredRole);

  Future<bool> canNavigate(WidgetRef ref) async {
    final user = await ref.read(currentUserProvider.future);

    if (user == null) {
      return false;
    }

    final isAuthorized = await ref.read(
      authorizationNotifierProvider(requiredRole).future,
    );

    return isAuthorized;
  }
}