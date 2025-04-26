import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_textfield.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final userNotifier = ref.read(userNotifierProvider.notifier);

    final displayNameController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isLoading = useState(false);
    final isEditingMode = useState(false);

    // Set initial values when user data is loaded
    useEffect(() {
      if (currentUserAsync.value != null) {
        displayNameController.text = currentUserAsync.value!.name ?? '';
      }
      return null;
    }, [currentUserAsync.value]);

    void updateProfile() async {
      if (!formKey.currentState!.validate()) return;

      isLoading.value = true;

      final user = currentUserAsync.value;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found'),
            backgroundColor: Colors.red,
          ),
        );
        isLoading.value = false;
        return;
      }

      final updatedUser = await userNotifier.updateUserInfo(
        userId: user.id,
        displayName: displayNameController.text,
      );

      isLoading.value = false;

      if (updatedUser != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        isEditingMode.value = false;
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(
              isEditingMode.value ? Icons.close : Icons.edit,
            ),
            onPressed: () {
              if (isEditingMode.value) {
                // Cancel editing mode and reset values
                if (currentUserAsync.value != null) {
                  displayNameController.text =
                      currentUserAsync.value!.name ?? '';
                }
              }
              isEditingMode.value = !isEditingMode.value;
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
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      user.name?.substring(0, 1).toUpperCase() ??
                          user.email.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // User role badge
                  Chip(
                    label: Text(
                      user.roles.join(",").toUpperCase() ?? 'USER',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 32),

                  // Info or edit form
                  if (isEditingMode.value) ...[
                    // Edit form
                    AuthTextField(
                      controller: displayNameController,
                      hintText: 'Display Name',
                      prefixIcon: Icons.person_outlined,
                      validator: Validators.name,
                    ),
                    const SizedBox(height: 24),
                    AuthButton(
                      text: 'Save Changes',
                      isLoading: isLoading.value,
                      onPressed: updateProfile,
                    ),
                  ] else ...[
                    // Profile info
                    _buildProfileInfoItem(
                      context,
                      'Name',
                      user.name ?? 'Not set',
                      Icons.person_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildProfileInfoItem(
                      context,
                      'Email',
                      user.email,
                      Icons.email_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildProfileInfoItem(
                      context,
                      'Email Verification',
                      user.isActive ? 'Verified' : 'Not Verified',
                      Icons.verified_outlined,
                      iconColor: user.isActive ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    // _buildProfileInfoItem(
                    //   context,
                    //   'Account Created',
                    //   _formatDate(user.createdAt),
                    //   Icons.calendar_today_outlined,
                    // ),

                    // Edit button
                    const SizedBox(height: 32),
                    if (!isEditingMode.value)
                      AuthButton(
                        text: 'Edit Profile',
                        onPressed: () => isEditingMode.value = true,
                      ),
                  ],
                ],
              ),
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

  Widget _buildProfileInfoItem(
      BuildContext context,
      String label,
      String value,
      IconData icon, {
        Color? iconColor,
      }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}