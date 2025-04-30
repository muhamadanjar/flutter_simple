import 'package:flutter/material.dart';
import 'package:flutter_simple/features/home/presentation/widgets/slider_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/role_constants.dart';
import '../../../../presentation/providers/auth_provider.dart';
import '../../../../presentation/widgets/common/role_based_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home 1'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final success = await authNotifier.signOut();
              if (success && context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: currentUserAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(
              child: Text('Not authenticated'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey[300],
                            child: Text(
                              user.name.substring(0, 1).toUpperCase() ??
                                  user.email.substring(0, 1).toUpperCase(),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            user.name ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            user.email,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Chip(
                            label: Text(
                              user.roles.join(",").toUpperCase() ?? 'USER',
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                HomeSliderWdiget(),
                const SizedBox(height: 24),
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Content for all users
                _buildFeatureCard(
                  context,
                  'Your Profile',
                  'View and update your profile information',
                  Icons.person_outline,
                      () => context.push('/profile'),
                ),

                // Admin-only content
                RoleBasedWidget(
                  role: RoleConstants.ADMIN,
                  child: _buildFeatureCard(
                    context,
                    'Admin Panel',
                    'Manage users and application settings',
                    Icons.admin_panel_settings_outlined,
                        () {
                      // Navigate to admin panel
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Admin panel is not implemented yet'),
                        ),
                      );
                    },
                  ),
                ),

                // Moderator-only content
                RoleBasedWidget(
                  role: RoleConstants.MODERATOR,
                  child: _buildFeatureCard(
                    context,
                    'Content Moderation',
                    'Review and moderate user content',
                    Icons.content_paste_outlined,
                        () {
                      // Navigate to moderation panel
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Moderation panel is not implemented yet'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context,
      String title,
      String description,
      IconData icon,
      VoidCallback onTap,
      ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}