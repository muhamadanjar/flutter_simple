import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_textfield.dart';
import '../../widgets/auth/social_button.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isLoading = useState(false);
    final isSocialLoading = useState<SocialAuthProvider?>(null);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    void signIn() async {
      if (!formKey.currentState!.validate()) return;

      isLoading.value = true;

      final result = await authNotifier.signIn(
        emailController.text,
        passwordController.text,
      );

      isLoading.value = false;

      if (!result.isAuthenticated && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.errorMessage ?? 'Sign in failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    void signInWithGoogle() async {
      isSocialLoading.value = SocialAuthProvider.google;

      final result = await authNotifier.signInWithGoogle();

      isSocialLoading.value = null;

      if (!result.isAuthenticated && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.errorMessage ?? 'Google sign in failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    void signInWithMicrosoft() async {
      isSocialLoading.value = SocialAuthProvider.microsoft;

      final result = await authNotifier.signInWithMicrosoft();

      isSocialLoading.value = null;

      if (!result.isAuthenticated && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.errorMessage ?? 'Microsoft sign in failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    void signInWithApple() async {
      isSocialLoading.value = SocialAuthProvider.apple;

      final result = await authNotifier.signInWithApple();

      isSocialLoading.value = null;

      if (!result.isAuthenticated && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.errorMessage ?? 'Apple sign in failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
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
                    Icons.lock_outline,
                    size: 80.0,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'Sign in to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  AuthTextField(
                    controller: emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    // validator: Validators.email,
                  ),
                  const SizedBox(height: 16.0),
                  AuthTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outlined,
                    obscureText: true,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  AuthButton(
                    text: 'Sign In',
                    isLoading: isLoading.value,
                    onPressed: signIn,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  SocialAuthButton(
                    provider: SocialAuthProvider.google,
                    onPressed: signInWithGoogle,
                    isLoading: isSocialLoading.value == SocialAuthProvider.google,
                  ),
                  const SizedBox(height: 12.0),
                  SocialAuthButton(
                    provider: SocialAuthProvider.microsoft,
                    onPressed: signInWithMicrosoft,
                    isLoading: isSocialLoading.value == SocialAuthProvider.microsoft,
                  ),
                  if (Theme.of(context).platform == TargetPlatform.iOS) ...[
                    const SizedBox(height: 12.0),
                    SocialAuthButton(
                      provider: SocialAuthProvider.apple,
                      onPressed: signInWithApple,
                      isLoading: isSocialLoading.value == SocialAuthProvider.apple,
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () => context.go('/signup'),
                        child: const Text(
                          'Sign Up',
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