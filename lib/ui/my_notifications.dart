import 'package:cruzadista/components/colors.dart';
import 'package:cruzadista/components/fonte_size.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('Minhas Notificações'),
      //   titleSpacing: 0,
      //   backgroundColor: MyColors.colorPrimary,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
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
                    child: Text("Notification", style: TextStyle(
                      fontSize: FontSizes.titulo,
                    fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // ação a ser executada quando o item for clicado
                          print('Item $index clicado!');
                        },
                        child: ItensNotification(),
                      );
                    },
                  ),
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
  const ItensNotification({Key? key}) : super(key: key);

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
                          "Titulo",
                          style: TextStyle(
                              color: MyColors.colorPrimary,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "13/01/2023",
                          style: TextStyle(color: MyColors.colorPrimary),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting",
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
