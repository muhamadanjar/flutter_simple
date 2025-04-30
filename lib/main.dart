import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_simple/presentation/providers/providers.dart';
import 'package:flutter_simple/presentation/providers/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'core/router/app_router.dart';
import 'core/services/fcm_service.dart';
import 'core/theme/app_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final fcmServiceProvider = Provider<FCMService>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return FCMService(apiClient: apiClient);
});

void main() async{
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(fcmServiceProvider).init();


  runApp(ProviderScope(child: const MyApp(),));
}



