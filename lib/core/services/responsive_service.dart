import 'package:flutter/material.dart';

/// A service that provides responsive utilities for adapting UI based on screen size.
class ResponsiveService {
  /// Singleton instance
  static final ResponsiveService _instance = ResponsiveService._internal();

  /// Factory constructor
  factory ResponsiveService() => _instance;

  /// Private constructor
  ResponsiveService._internal();

  /// Returns true if the screen width is considered extra small (< 576px)
  bool isExtraSmall(BuildContext context) =>
      MediaQuery.of(context).size.width < 576;

  /// Returns true if the screen width is considered small (>= 576px and < 768px)
  bool isSmall(BuildContext context) =>
      MediaQuery.of(context).size.width >= 576 &&
          MediaQuery.of(context).size.width < 768;

  /// Returns true if the screen width is considered medium (>= 768px and < 992px)
  bool isMedium(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
          MediaQuery.of(context).size.width < 992;

  /// Returns true if the screen width is considered large (>= 992px and < 1200px)
  bool isLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= 992 &&
          MediaQuery.of(context).size.width < 1200;

  /// Returns true if the screen width is considered extra large (>= 1200px)
  bool isExtraLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  /// Returns a value based on the current screen size
  /// [xs] - Value for extra small screens
  /// [sm] - Value for small screens
  /// [md] - Value for medium screens
  /// [lg] - Value for large screens
  /// [xl] - Value for extra large screens
  T responsive<T>(
      BuildContext context, {
        required T xs,
        T? sm,
        T? md,
        T? lg,
        T? xl,
      }) {
    if (isExtraLarge(context) && xl != null) return xl;
    if (isLarge(context) && lg != null) return lg;
    if (isMedium(context) && md != null) return md;
    if (isSmall(context) && sm != null) return sm;
    return xs;
  }

  /// Returns the appropriate padding based on screen size
  EdgeInsets getPadding(BuildContext context) {
    return responsive<EdgeInsets>(
      context,
      xs: const EdgeInsets.all(8.0),
      sm: const EdgeInsets.all(12.0),
      md: const EdgeInsets.all(16.0),
      lg: const EdgeInsets.all(24.0),
      xl: const EdgeInsets.all(32.0),
    );
  }

  /// Returns a responsive font size based on screen size
  double getFontSize(
      BuildContext context, {
        required double base,
        double? sm,
        double? md,
        double? lg,
        double? xl,
      }) {
    return responsive<double>(
      context,
      xs: base,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    );
  }

  /// Checks if the device is in landscape orientation
  bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  /// Check if the device is a tablet (based on a width threshold)
  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  /// Check if the device is a desktop (based on a width threshold)
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  /// Check if the device is a mobile phone
  bool isMobile(BuildContext context) =>
      !isTablet(context) && !isDesktop(context);
}

extension ResponsiveExtension on BuildContext {
  /// Get the ResponsiveService instance
  ResponsiveService get responsive => ResponsiveService();

  /// Returns true if the screen width is considered extra small (< 576px)
  bool get isExtraSmall => responsive.isExtraSmall(this);

  /// Returns true if the screen width is considered small (>= 576px and < 768px)
  bool get isSmall => responsive.isSmall(this);

  /// Returns true if the screen width is considered medium (>= 768px and < 992px)
  bool get isMedium => responsive.isMedium(this);

  /// Returns true if the screen width is considered large (>= 992px and < 1200px)
  bool get isLarge => responsive.isLarge(this);

  /// Returns true if the screen width is considered extra large (>= 1200px)
  bool get isExtraLarge => responsive.isExtraLarge(this);

  /// Returns true if the device is in landscape orientation
  bool get isLandscape => responsive.isLandscape(this);

  /// Returns true if the device is a tablet
  bool get isTablet => responsive.isTablet(this);

  /// Returns true if the device is a desktop
  bool get isDesktop => responsive.isDesktop(this);

  /// Returns true if the device is a mobile phone
  bool get isMobile => responsive.isMobile(this);

  /// Returns a value based on the current screen size
  T responsiveValue<T>({
    required T xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) {
    return responsive.responsive(
      this,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    );
  }

  /// Returns responsive padding based on screen size
  EdgeInsets get responsivePadding => responsive.getPadding(this);

  /// Helper for responsive width calculation (percentage of screen width)
  double widthPercent(double percent) => MediaQuery.of(this).size.width * percent;

  /// Helper for responsive height calculation (percentage of screen height)
  double heightPercent(double percent) => MediaQuery.of(this).size.height * percent;
}