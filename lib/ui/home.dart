import 'dart:convert';
import 'dart:io';

import 'package:cruzadista/components/fonte_size.dart';
import 'package:cruzadista/model/cruzada.dart';
import 'package:cruzadista/ui/game/game.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../components/alert_dialog_dific.dart';
import '../components/colors.dart';
import '../config/constants.dart';
import '../config/preferences.dart';
import '../config/requests.dart';
import '../model/user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var nameUser = 'Joao Victor';
  var avatarUser = '';
  var dific = '';
  int unreadNotificationsCount = 0;
  String notificationsCount = "0";
  String? totalValue = '';
  String? finalizadasValue = '';
  String? pendentesValue = '';
  bool _listTyper = false;
  bool _dificScreen = false;
  List<Cruzada> niveis = [];

  final List<Cruzada> crossWords = [];
  final List<Cruzada> crossWordsFinalizadas = [];
  final List<User> notifications = [];
  final requestsWebServices = RequestsWebServices(WSConstantes.URLBASE);
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getFCM() async {
    await Preferences.init();
    String? savedFcmToken = await Preferences.getInstanceTokenFcm();
    //nameUser = (await Preferences.getUserData()!.name)!;
    String? currentFcmToken = await _firebaseMessaging.getToken();
    if (savedFcmToken != null && savedFcmToken == currentFcmToken) {
      print('FCM: não salvou');
      return savedFcmToken;
    }
    var _userId = await Preferences.getUserData()!.id;
    var _type = '';
    if (Platform.isAndroid) {
      _type = WSConstantes.FCM_TYPE_ANDROID;
    } else if (Platform.isIOS) {
      _type = WSConstantes.FCM_TYPE_IOS;
    }
    final body = {
      WSConstantes.ID_USER: _userId,
      WSConstantes.TYPE: _type,
      WSConstantes.REGIST_ID: currentFcmToken,
      WSConstantes.TOKENID: WSConstantes.TOKEN
    };
    final response =
        await requestsWebServices.sendPostRequest(WSConstantes.SAVE_FCM, body);

    print('FCM: $currentFcmToken');
    print('RESPOSTA: $response');

    // Salvamos o FCM atual nas preferências.
    await Preferences.saveInstanceTokenFcm("token", currentFcmToken!);

    return currentFcmToken;
  }

  Future<String?> getUserData() async {
    await Preferences.init();
    var _userId = await Preferences.getUserData()!.id;
    final body = {
      WSConstantes.ID: _userId,
      WSConstantes.TOKENID: WSConstantes.TOKEN
    };

    final response = await requestsWebServices.sendPostRequest(
        WSConstantes.PERFIL_USER, body);
    final decodedResponse = jsonDecode(response);
    if (decodedResponse.isNotEmpty) {
      final user = User();
      user.id = decodedResponse['id'];
      user.name = decodedResponse['nome'];
      user.avatar = decodedResponse['avatar'];

      setState(() {
        nameUser = user.name!;
        // avatarUser = WSConstantes.URL_AVATAR + user.avatar!;
      });

      print(
          'meu id ${user.id}, meu nome: ${user.name}, avatar: ${user.avatar}');
    }
    getStatistics();
  }

  Future<void> getStatistics() async {
    try {
      await Preferences.init();
      final userId = Preferences.getUserData()?.id;
      final body = {
        WSConstantes.ID: userId,
        WSConstantes.TOKENID: WSConstantes.TOKEN
      };

      //final Map<String, dynamic> decodedResponse = await requestsWebServices.sendPostRequestList(WSConstantes.STATISTICS, body);
      final List<dynamic> decodedResponse = await requestsWebServices
          .sendPostRequestList(WSConstantes.STATISTICS, body);
      if (decodedResponse.isNotEmpty) {
        final cruzada = Cruzada();
        cruzada.total = decodedResponse[0]['total']['rows'];
        cruzada.finalizadas = decodedResponse[0]['finalizadas']['rows'];
        cruzada.pendentes = decodedResponse[0]['pendentes']['rows'];
        print(
            "total: ${cruzada.total}  finalizadas: ${cruzada.finalizadas}  Pendentes: ${cruzada.pendentes}");
        setState(() {
          totalValue = cruzada.total.toString();
          finalizadasValue = cruzada.finalizadas.toString();
          pendentesValue = cruzada.pendentes.toString();
        });
      } else {
        print('NULO');
      }
      getNotificaiton();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getListNiveis() async {
    try {
      await Preferences.init();
      final body = {WSConstantes.TOKENID: WSConstantes.TOKEN};

      //final Map<String, dynamic> decodedResponse = await requestsWebServices.sendPostRequestList(WSConstantes.STATISTICS, body);
      final List<dynamic> decodedResponse = await requestsWebServices
          .sendPostRequestList(WSConstantes.LISTNIVEIS, body);
      if (decodedResponse.isNotEmpty) {
        niveis.clear();
        for (final iten in decodedResponse) {
          final nivel = Cruzada(
            name: iten['nome'],
            id: iten['id'],
          );
          niveis.add(nivel);
        }
      } else {
        print('NULO');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getListCruazadist(int type, int idNivel) async {
    try {
      await Preferences.init();
      final userId = Preferences.getUserData()?.id;

      if (!_listTyper) {
        final body = {
          WSConstantes.ID: userId,
          WSConstantes.TYPE: type,
          WSConstantes.ID_NIVEL: idNivel,
          WSConstantes.TOKENID: WSConstantes.TOKEN
        };
        final List<dynamic> decodedResponse = await requestsWebServices
            .sendPostRequestList(WSConstantes.LIST_CRUZADISTA, body);
        if (decodedResponse.isNotEmpty) {
          setState(() {
            crossWords.clear();
            for (final item in decodedResponse) {
              final crossWord = Cruzada(
                name: item['nome'],
                image: 'images/logoadapter.png',
                id: item['id'],
                url: item['url'],
                rows: item['rows'],
              );
              if (crossWord.rows != 0) {
                crossWords.add(crossWord);
              } else {
                crossWords.clear();
              }

              print(crossWords);
            }
          });
        } else {
          print('NULO');
        }
      } else {
        final body = {
          WSConstantes.ID: userId,
          WSConstantes.TYPE: type,
          WSConstantes.ID_NIVEL: idNivel,
          WSConstantes.TOKENID: WSConstantes.TOKEN
        };
        final List<dynamic> decodedResponse = await requestsWebServices
            .sendPostRequestList(WSConstantes.LIST_CRUZADISTA, body);
        if (decodedResponse.isNotEmpty) {
          setState(() {
            crossWordsFinalizadas.clear();
            for (final item in decodedResponse) {
              final crossWord = Cruzada(
                name: item['nome'],
                image: 'images/logoadapter.png',
                id: item['id'],
                url: item['url'],
                status: item['status'].toString(),
                rows: item['rows'],
              );
              if (crossWord.rows != 0) {
                crossWordsFinalizadas.add(crossWord);
              } else {
                crossWordsFinalizadas.clear();
              }
            }
          });
        } else {
          crossWordsFinalizadas.clear();
          print('NULO');
        }
      }
      getStatistics();
    } catch (e) {
      print(e);
    }
  }

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
            if (notification.rows == 0) {
              notifications.clear();
            } else {
              notifications.add(notification);
            }
          }

          int getListNotifyDataCompare =
              Preferences.getUnreadNotificationsCount();
          print(
              "$getListNotifyDataCompare aqui e o que ta salvo no preference");
          if (getListNotifyDataCompare != 0) {
            unreadNotificationsCount =
                (notifications.length - getListNotifyDataCompare);
            print(
                "cai aqui (_notifications.length - getListNotifyDataCompare) =  $unreadNotificationsCount");
          } else {
            unreadNotificationsCount = notifications.length;
          }
          print(
              "$unreadNotificationsCount aqui e total antes de chega no badge");
          print("Tamanho da tela:${MediaQuery.of(context).size.width}");
        });
        getListNiveis();
      } else {
        print('NULO');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getFCM();
    getUserData();
    getListCruazadist(1, 0);
  }

  List<String> _tabs = ['Pendentes', 'Finalizadas'];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (unreadNotificationsCount == null) {
      notificationsCount = "0";
    } else {
      if (unreadNotificationsCount! > 9) {
        notificationsCount = "9+";
      } else {
        notificationsCount = unreadNotificationsCount.toString();
      }
    }
    print(avatarUser);
    return Scaffold(
      backgroundColor: MyColors.colorOnPrimary,
      body: Padding(
        padding: EdgeInsets.only(top: 60),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/ui/menu");
                    },
                    //avatar.png
                    child: Material(
                      elevation: 8,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundImage:
                        ExactAssetImage('images/usercruzadista.png'),

                        // ExactAssetImage('images/avatar.png'),
                        radius: 22,
                        backgroundColor: MyColors.grayLite,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      'Olá,\n$nameUser',
                      style: TextStyle(
                          fontSize: FontSizes.titulo,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/ui/notification");
                    },
                    child: Card(
                      margin: EdgeInsets.all(0),
                      // Define a margem do card como zero
                      color: MyColors.colorOnPrimary,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SvgPicture.asset(
                                'icons/notification.svg',
                                color: Color(0xff000000),
                                width: 24,
                                height: 24,
                              ),
                            ),
                            if (unreadNotificationsCount! > 0)
                              Positioned(
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 12,
                                    minHeight: 12,
                                  ),
                                  child: Text(
                                    notificationsCount,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      borderOnForeground: false,
                      clipBehavior: Clip.antiAlias,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MediaQuery.of(context).size.width > 380
                      ? buildContainer(
                          width: 130,
                          totalValue: totalValue!,
                          nameValeu: "Total",
                          fontSize: 15,
                    fontSizeNumber: 16,
                        )
                      : buildContainer(
                          width: 100,
                          totalValue: totalValue!,
                          nameValeu: "Total",
                          fontSize: 9,
                    fontSizeNumber: 13,
                        ),
                  MediaQuery.of(context).size.width > 380
                      ? buildContainer(
                          width: 130,
                          totalValue: finalizadasValue!,
                          nameValeu: "Finalizadas",
                          fontSize: 15,
                    fontSizeNumber: 16,
                        )
                      : buildContainer(
                          width: 100,
                          totalValue: finalizadasValue!,
                          nameValeu: "Finalizadas",
                          fontSize: 9,
                    fontSizeNumber: 13,
                        ),
                  MediaQuery.of(context).size.width > 380
                      ? buildContainer(
                          width: 130,
                          totalValue: pendentesValue!,
                          nameValeu: "Pendentes",
                          fontSize: 15,
                    fontSizeNumber: 16,
                        )
                      : buildContainer(
                          width: 100,
                          totalValue: pendentesValue!,
                          nameValeu: "Pendentes",
                          fontSize: 9,
                    fontSizeNumber: 13,
                        ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Visibility(
                      visible: _dificScreen,
                      child: InkWell(
                        onTap: () {
                          _dificScreen = false;
                          if (_selectedIndex == 0) {
                            getListCruazadist(1, 0);
                          } else {
                            getListCruazadist(2, 0);
                          }
                        },
                        child: Card(
                          margin: EdgeInsets.all(0),
                          // Define a margem do card como zero
                          color: MyColors.colorOnPrimary,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  dific,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          borderOnForeground: false,
                          clipBehavior: Clip.antiAlias,
                        ),
                      )),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => DialogDific(
                          listNiveis: niveis,
                          screenType: _selectedIndex,
                          onDifficultySelected:
                              (int type, int level, String nameDific) {
                            getListCruazadist(type, level);
                            _dificScreen = true;
                            dific = nameDific;
                          },
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.all(0),
                      // Define a margem do card como zero
                      color: MyColors.colorOnPrimary,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Filtrar",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SvgPicture.asset('icons/filtro.svg'),
                          ],
                        ),
                      ),
                      borderOnForeground: false,
                      clipBehavior: Clip.antiAlias,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                        getListCruazadist(1, 0);
                        _listTyper = false;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          _tabs[0],
                          style: TextStyle(
                            fontSize: FontSizes.titulo,
                            color: _selectedIndex == 0
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 2,
                          width: _selectedIndex == 0 ? _tabs[0].length * 12 : 0,
                          color: _selectedIndex == 0
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ],
                    ),
                    splashColor: Colors.transparent,
                    highlightColor:
                        _selectedIndex == 0 ? Colors.black : Colors.transparent,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                        getListCruazadist(2, 0);
                        _listTyper = true;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          _tabs[1],
                          style: TextStyle(
                            fontSize: FontSizes.titulo,
                            color: _selectedIndex == 1
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 2,
                          width: _selectedIndex == 1 ? _tabs[1].length * 10 : 0,
                          color: _selectedIndex == 1
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ],
                    ),
                    splashColor: Colors.transparent,
                    highlightColor:
                        _selectedIndex == 1 ? Colors.black : Colors.transparent,
                  ),
                ],
              ),
              if (_selectedIndex == 0)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      if (crossWords.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset('animation/empty.json',
                                  repeat: true,
                                  reverse: true,
                                  animate: true,
                                  width: 150,
                                  height: 150),
                              Text(
                                'Nenhuma cruzada encontrada',
                                style: TextStyle(
                                  fontSize: FontSizes.subTitulo,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return GridView.count(
                          crossAxisCount: 2, // Define duas colunas
                          children: List.generate(crossWords.length, (index) {
                            return MyCard(crossWordL: crossWords[index]);
                          }),
                        );
                      }
                    }),
                  ),
                ),
              if (_selectedIndex == 1)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        if (crossWordsFinalizadas.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.asset('animation/empty.json',
                                    repeat: true,
                                    reverse: true,
                                    animate: true,
                                    width: 150,
                                    height: 150),
                                Text(
                                  'Nenhuma cruzada encontrada',
                                  style: TextStyle(
                                    fontSize: FontSizes.subTitulo,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(
                                crossWordsFinalizadas.length, (index) {
                              return MyCard(
                                  crossWordL: crossWordsFinalizadas[index]);
                            }),
                          );
                        }
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

class CrossWordL {
  final String title;
  final String image;

  CrossWordL(this.title, this.image);
}

class MyCard extends StatelessWidget {
  final Cruzada crossWordL;

  MyCard({required this.crossWordL});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(crossWordL.url);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Game(
                      cruzada: crossWordL,
                    )));
        // Navigator.pushNamed(context, "/ui/game");
      },
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                crossWordL.image!,
                width: 80,
                height: 80,
              ),
              Text(
                crossWordL.name!,
                style: TextStyle(
                    fontSize: FontSizes.subTitulo,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
    Widget buildContainer(double width, String totalValue) {
      return Container(
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Color(0xff424242),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  totalValue!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class buildContainer extends StatelessWidget {
  double width;
  String totalValue;
  String nameValeu;
  double fontSize;
  double fontSizeNumber;

  buildContainer(
      {super.key,
      required this.width,
      required this.totalValue,
      required this.nameValeu,
      required this.fontSize,
      required this.fontSizeNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Color(0xff424242),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                totalValue!,
                style: TextStyle(
                  fontSize: fontSizeNumber,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                nameValeu,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
