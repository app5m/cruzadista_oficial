import 'dart:io';

import 'package:cruzadista/config/constants.dart';
import 'package:cruzadista/ui/game/game.dart';
import 'package:cruzadista/ui/home.dart';
import 'package:cruzadista/ui/login.dart';
import 'package:cruzadista/ui/menu.dart';
import 'package:cruzadista/ui/my_notifications.dart';
import 'package:cruzadista/ui/my_profile.dart';
import 'package:cruzadista/ui/onboarding.dart';
import 'package:cruzadista/ui/splash.dart';
import 'package:cruzadista/ui/update_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'config/notification_config.dart';
import 'config/preferences.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  LocalNotification.showNotification(message);
  print("Handling a background message: $message");
}

main() async {
  var theme = ThemeMode.light;
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  await Preferences.init();

  if(Platform.isAndroid){
    await Firebase.initializeApp();
  }else{
    await Firebase.initializeApp();
  }
  LocalNotification.initialize();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotification.showNotification(message);
    print('Mensagem recebida: ${message.data}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Mensagem abertaaaaaaaaa: ${message.data}');

  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: theme,
    title: "Cruzadista",
    initialRoute: '/ui/splash',
    routes: {
      '/ui/splash': (context) => Splash(),
      '/ui/onboarding': (context) => Onboarding(),
      // VAI NA LINHA 68
      '/ui/login': (context) => Login(),
      '/ui/home': (context) => Home(),
      // AQUI EU USO NAVEGAÇAO DIFERENTES DAS ROTAS VAI NA LINHAS: 55, 161, 192 e 221
      '/ui/notification': (context) => MyNotifications(),
      // AQUI EU USO NAVEGAÇAO DIFERENTES DAS ROTAS VAI NA LINHAS: 55, 161, 192 e 221
      '/ui/menu': (context) => Menu(),
      '/ui/myProfile': (context) => MyProfile(),
      '/ui/updatePassword': (context) => UpdatePassword(),
      // '/ui/game': (context) => Game(),
      // //EU SO ESTOU USANDO AS ROTAS ate a HOME
      // '/ui/view_pdf': (context) => ViewPdf(),
      // '/ui/menu': (context) => Menu(),
    },
  ));
}
