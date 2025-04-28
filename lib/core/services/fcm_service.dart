import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_simple/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../constants/storage_constants.dart';

// Top-level function untuk background messaging handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Ensure firebase is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  print("Handling a background message: ${message.messageId}");
}

class FCMService {
  static final FCMService _instance = FCMService._internal();
  late final FirebaseMessaging _messaging;
  late final FlutterLocalNotificationsPlugin _flutterLocalNotifications;
  late final ApiClient _apiClient;

  // Singleton pattern
  factory FCMService({required ApiClient apiClient}) {
    _instance._apiClient = apiClient;
    return _instance;
  }

  FCMService._internal();

  Future<void> init() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Initialize messaging
    _messaging = FirebaseMessaging.instance;

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission for iOS
    if (Platform.isIOS) {
      await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // Initialize local notifications
    _flutterLocalNotifications = FlutterLocalNotificationsPlugin();
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _flutterLocalNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );

    // Get the token
    await _getAndSaveFCMToken();

    // Listen for token refresh
    _messaging.onTokenRefresh.listen(_updateFCMToken);

    // Configure message handling
    _configureMessaging();
  }

  void _onSelectNotification(NotificationResponse response) async{
    // Handle notification tap
    final payload = response.payload;
    if (payload != null) {
      // Process payload data for navigation or other actions

      // Here you would implement navigation based on the payload
      // For example:
      // if (payload.contains('profile')) {
      //   navigatorKey.currentState?.pushNamed('/profile');
      // }


    }
  }

  Future<void> _getAndSaveFCMToken() async {
    final token = await _messaging.getToken();
    if (token != null) {
      print('FCM Token: $token');

      // Save token locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(StorageConstants.fcmToken, token);

      // Send token to backend
      await _sendTokenToServer(token);
    }
  }

  Future<void> _updateFCMToken(String token) async {
    print('FCM Token refreshed: $token');

    // Save token locally
    final prefs = await SharedPreferences.getInstance();
    final oldToken = prefs.getString(StorageConstants.fcmToken);
    if (oldToken != token){
      await prefs.setString(StorageConstants.fcmToken, token);

      // Send token to backend
      await _sendTokenToServer(token);
    }
  }

  Future<void> _sendTokenToServer(String token) async {
    try {
      // Check if user is logged in
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(StorageConstants.accessToken);

      if (accessToken != null && accessToken.isNotEmpty) {
        // Send token to backend
        await _apiClient.post(
          '/auth/metas',
          data: {
            'key': 'fcm_token',
            'value': token
          },
        );
      }
    } catch (e) {
      print('Failed to send FCM token to server: $e');
    }
  }

  void _configureMessaging() {
    // Handle incoming messages when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _showLocalNotification(message);
      }
    });

    // Handle message when app is in background but opened
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Handle navigation based on message data
      _handleMessageNavigation(message);
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = notification?.android;

    if (notification != null) {
      // Android channel for notification
      const androidChannel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

      // Create the channel if needed
      await _flutterLocalNotifications
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);

      // Show notification
      await _flutterLocalNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            icon: android?.smallIcon ?? '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data.toString(),
      );
    }
  }

  void _handleMessageNavigation(RemoteMessage message) {
    // Implement navigation based on message data
    // For example:
    // if (message.data.containsKey('screen')) {
    //   final screen = message.data['screen'];
    //   if (screen == 'profile') {
    //     navigatorKey.currentState?.pushNamed('/profile');
    //   }
    // }
  }

  // Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }
}