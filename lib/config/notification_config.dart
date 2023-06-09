
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../model/notification.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin _notiPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initialSettings = InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
    );
    _notiPlugin.initialize(initialSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
          print('onDidReceiveNotificationResponse Function');
          print(details.payload);
          print(details.payload != null);
        });
  }

  static void showNotification(RemoteMessage message) {
    // {titulo: Atualização do status do pedido, type: new_ticket, descricao: O pedido de número #212 foi atualizado para Enviado}

    NotificationPop notification = NotificationPop.fromJson(message.data);

    print(" dados da notificaçao ${message.data}");

    final NotificationDetails notiDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'br.com.cruzadista.app.push_notification',
        'push_notification',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    _notiPlugin.show(
      DateTime
          .now()
          .microsecond,
      notification.title,
      notification.description,
      notiDetails,
      payload: message.data.toString(),
    );
  }
}

//ADAS