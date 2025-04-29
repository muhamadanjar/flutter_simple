import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/validators.dart';
import '../../../../presentation/providers/auth_provider.dart';
import '../../../../presentation/widgets/auth/auth_button.dart';
import '../../../../presentation/widgets/auth/auth_textfield.dart';


class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final nameController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isLoading = useState(false);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    void signUp() async {
      if (!formKey.currentState!.validate()) return;

      isLoading.value = true;

      final result = await authNotifier.signUp(
        emailController.text,
        passwordController.text,
        nameController.text.isNotEmpty ? nameController.text : null,
      );

      isLoading.value = false;

      if (!result.isAuthenticated && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.errorMessage ?? 'Sign up failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.person_add_outlined,
                    size: 80.0,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Create Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'Sign up to get started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  AuthTextField(
                    controller: nameController,
                    hintText: 'Name',
                    prefixIcon: Icons.person_outlined,
                  ),
                  const SizedBox(height: 16.0),
                  AuthTextField(
                    controller: emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 16.0),
                  AuthTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outlined,
                    obscureText: true,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 32.0),
                  AuthButton(
                    text: 'Sign Up',
                    isLoading: isLoading.value,
                    onPressed: signUp,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}