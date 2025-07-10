import 'package:baby_monitor/routing/route_const.dart';
import 'package:get/get.dart';
import 'package:baby_monitor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class FcmCallkitService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    var phoneStatus = await Permission.phone.status;
    if (!phoneStatus.isGranted) {
      await Permission.phone.request();
    }

    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Local bildirimleri başlat
    await _initializeLocalNotifications();

    // CallKit event listener'larını ayarla
    _setupCallKitListeners();

    //Önplan bildrimleri
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Uygulama kapalıyken gelen ilk açılış bildirimini dinle
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }
  }

  //Call listeners
  static void _setupCallKitListeners() {
    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) {
      if (event!.event == Event.actionCallAccept) {
        _handleCallAccepted(event.body);
      }
    });
  }

  static Future<void> _initializeLocalNotifications() async {
    // Android ayarları
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
          '@mipmap/launcher_icon',
        ); //İcon control edilecek!!

    // iOS ayarları
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {
            // iOS'ta bildirim tıklandığında yapılacak işlemler
            // Örneğin bir sayfaya yönlendirme yapabilirsiniz
          },
        );

    // Başlatma ayarları (Android ve iOS)
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
          // macOS için de ayar eklenebilir
          macOS: initializationSettingsIOS,
        );

    // Bildirim pluginini başlat
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) async {
        // Bildirim tıklandığında yapılacak işlemler (hem Android hem iOS)
        final String? payload = notificationResponse.payload;
        // Payload'a göre navigasyon işlemleri yapabilirsiniz
        if (payload != null && payload.isNotEmpty) {
          // Örneğin: Navigator.pushNamed(context, payload);
        }
      },
    );

    // iOS için izin iste (isteğe bağlı, zaten FCM'de izin istiyoruz)
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }

    // macOS için izin iste (isteğe bağlı)
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  //Arka PLan bildirimleri işlemler
  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    print('Arka plan bildirimi: ${message.messageId}');

    // Eğer bildirim bir çağrı içeriyorsa
    if (message.data['type'] == 'call') {
      await showIncomingCall(message);
    } else {
      await showNotification(message);
    }
  }

  //ön plan bilidirileri call gösteilmelim ?
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print('Ön plan bildirimi: ${message.messageId}');

    // Eğer bildirim bir çağrı içeriyorsa
    if (message.data['type'] == 'call') {
      await showIncomingCall(message);
    } else {
      await showNotification(message);
    }
  }

  //Cağrıyı göster
  static Future<void> showIncomingCall(RemoteMessage message) async {
    final deviceId = message.data['deviceId'] ?? "";
    final callerName = message.data['deviceName'] ?? 'Bilinmeyen';
    CallKitParams callKitParams = CallKitParams(
      id: deviceId,
      nameCaller: callerName,
      appName: 'Babay Monitor',
      avatar: "https://babymonitor.cagnaz.com/icons/and_icon.png",
      //handle: '0123456789',
      type: 0,
      textAccept: 'Watch',
      textDecline: 'Dismiss',
      callingNotification: const NotificationParams(
        showNotification: false,
        isShowCallback: false,
        subtitle: 'Baby is crying',
        //callbackText: 'Hang Up',
      ),
      duration: 30000,
      extra: <String, dynamic>{'deviceId': deviceId},
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: true, //Logi flse
        logoUrl: 'https://babymonitor.cagnaz.com/icons/and_icon.png',
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        //backgroundUrl: 'https://i.pravatar.cc/500',
        actionColor: '#4CAF50',
        textColor: '#ffffff',
        incomingCallNotificationChannelName: "Incoming Call",
        missedCallNotificationChannelName: "Missed Call",
        isShowCallID: false,
      ),
      ios: IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
  }

  //Bilidirm Göster
  static Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'Channel Name',
            channelDescription: 'Channel Description',
            importance: Importance.max,
            priority: Priority.high,
            icon: android.smallIcon,
          ),
        ),
      );
    }
  }

  static void _handleMessageOpenedApp(RemoteMessage message) {
    print('Bildirim açıldı: ${message.messageId}');
    // Eğer bir çağrı bildirimi ise
    if (message.data['type'] == 'call') {
      // Çağrı ekranına yönlendirme yapabilirsiniz
    } else {
      // Normal bildirim işlemleri
    }
  }

  static void _handleCallAccepted(body) {
    print(body);
    final extras = body?['extra'];

    Get.toNamed(
      RouteConst.viewerScrean,
      arguments: {"deviceId": extras['deviceId']},
    );
    //İleme sayfasına device id ile yönlendirip connection işlemleri halledilecek
  }
}
