import 'package:flutter/material.dart';

enum SocialAuthProvider {
  google,
  microsoft,
  apple,
}

class SocialAuthButton extends StatelessWidget {
  final SocialAuthProvider provider;
  final VoidCallback onPressed;
  final bool isLoading;

  const SocialAuthButton({
    super.key,
    required this.provider,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getBackgroundColor(),
        foregroundColor: _getForegroundColor(),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 1,
      ),
      child: isLoading
          ? const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getIcon(),
          const SizedBox(width: 12),
          Text(
            _getButtonText(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIcon() {
    switch (provider) {
      case SocialAuthProvider.google:
        return Image.asset(
          'assets/images/google_logo.png',
          height: 24,
          width: 24,
        );
      case SocialAuthProvider.microsoft:
        return Image.asset(
          'assets/images/microsoft_logo.png',
          height: 24,
          width: 24,
        );
      case SocialAuthProvider.apple:
        return Image.asset(
          'assets/images/apple_logo.png',
          height: 24,
          width: 24,
        );
    }
  }

  String _getButtonText() {
    switch (provider) {
      case SocialAuthProvider.google:
        return 'Sign in with Google';
      case SocialAuthProvider.microsoft:
        return 'Sign in with Microsoft';
      case SocialAuthProvider.apple:
        return 'Sign in with Apple';
    }
  }

  Color _getBackgroundColor() {
    switch (provider) {
      case SocialAuthProvider.google:
        return Colors.white;
      case SocialAuthProvider.microsoft:
        return const Color(0xFF2F2F2F);
      case SocialAuthProvider.apple:
        return Colors.black;
    }
  }

  Color _getForegroundColor() {
    switch (provider) {
      case SocialAuthProvider.google:
        return Colors.black87;
      case SocialAuthProvider.microsoft:
      case SocialAuthProvider.apple:
        return Colors.white;
    }
  }
}