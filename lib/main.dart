import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_simple/presentation/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/router/app_router.dart';
import 'core/services/fcm_service.dart';

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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Flutter Firebase Auth App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );

  }
}

