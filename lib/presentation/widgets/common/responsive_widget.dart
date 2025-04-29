import 'package:flutter/material.dart';

import '../../../core/services/responsive_service.dart';

class ResponsiveWidget extends StatelessWidget {
  /// Child widget for extra small screens
  final Widget xs;

  /// Optional child widget for small screens
  final Widget? sm;

  /// Optional child widget for medium screens
  final Widget? md;

  /// Optional child widget for large screens
  final Widget? lg;

  /// Optional child widget for extra large screens
  final Widget? xl;

  /// Constructor
  const ResponsiveWidget({
    Key? key,
    required this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveService().responsive<Widget>(
      context,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    );
  }
}

/// A widget that renders different layouts based on the screen orientation
class OrientationResponsiveWidget extends StatelessWidget {
  /// Child widget for portrait orientation
  final Widget portrait;

  /// Child widget for landscape orientation
  final Widget landscape;

  /// Constructor
  const OrientationResponsiveWidget({
    Key? key,
    required this.portrait,
    required this.landscape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait ? portrait : landscape;
      },
    );
  }
}

/// A widget that renders different layouts based on the device type
class DeviceResponsiveWidget extends StatelessWidget {
  /// Child widget for mobile devices
  final Widget mobile;

  /// Child widget for tablet devices
  final Widget tablet;

  /// Child widget for desktop devices
  final Widget desktop;

  /// Constructor
  const DeviceResponsiveWidget({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveService();

    if (responsive.isDesktop(context)) {
      return desktop;
    } else if (responsive.isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }
}