import 'package:cruzadista/components/colors.dart';
import 'package:cruzadista/components/fonte_size.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../config/constants.dart';
import '../config/preferences.dart';
import '../config/requests.dart';
import '../model/user.dart';
import 'home.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  List<User> notifications = [];

  final requestsWebServices = RequestsWebServices(WSConstantes.URLBASE);

  Future<void> getNotificaiton() async {
    try {
      await Preferences.init();
      final userId = Preferences.getUserData()?.id;
      final body = {
        WSConstantes.ID: userId,
        WSConstantes.TOKENID: WSConstantes.TOKEN
      };

      final List<dynamic> decodedResponse = await requestsWebServices
          .sendPostRequestList(WSConstantes.NOTIFICATION, body);
      if (decodedResponse.isNotEmpty) {

        setState(() {
          notifications.clear();
          for (final item in decodedResponse) {
            final notification = User(
              id: item['id'],
              title: item['titulo'],
              description: item['descricao'],
              date: item['data'],
              rows: item['rows'],
            );
            print('rows: ${notification.rows}');
            if(notification.rows == 0){
              notifications.clear();
            }else{
            notifications.add(notification);
            }

          }
        });
      } else {
        print('NULO');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificaiton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "Notificações",
                      style: TextStyle(
                        fontSize: FontSizes.titulo,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: notifications.length > 0
                    ? SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: notifications.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                // ação a ser executada quando o item for clicado
                                print('Item $index clicado!');
                              },
                              child: ItensNotification(
                                notification: notifications[index],
                              ),
                            );
                          },
                        ),
                      )
                    : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset('animation/empty.json',
                              repeat: true,
                              reverse: true,
                              animate: true,
                            width: 250,
                            height: 250),
                            Text('Nenhuma notificação',
                              style: TextStyle(
                                fontSize: FontSizes.subTitulo,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),),
                          ],
                        ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItensNotification extends StatelessWidget {
  User notification;

  ItensNotification({Key? key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 2),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notification.title!,
                          style: TextStyle(
                              color: MyColors.colorPrimary,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          notification.date!,
                          style: TextStyle(color: MyColors.colorPrimary),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      notification.description!,
                      maxLines: 2,
                      style: TextStyle(
                          color: MyColors.colorPrimary,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
