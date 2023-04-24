import 'package:cruzadista/components/fonte_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/alert_dialog_dific.dart';
import '../components/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _tabs = ['Pendentes', 'Finalizadas'];
  int _selectedIndex = 0;
  final List<CrossWordL> crossWords = [
    CrossWordL(
      'Podcast 1',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 2',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 3',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 4',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 5',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 6',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 7',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 8',
      'images/logoadapter.png',
    ),
  ];
  final List<CrossWordL> crossWords2 = [
    CrossWordL(
      'Podcast 9',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 10',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 11',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 12',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 13',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 14',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 15',
      'images/logoadapter.png',
    ),
    CrossWordL(
      'Podcast 16',
      'images/logoadapter.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Olá,\nJoão Victor',
                      style: TextStyle(
                          fontSize: FontSizes.titulo,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/ui/menu");
                    },
                    //avatar.png
                    child: Material(
                    elevation: 8,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundImage: ExactAssetImage('images/avatar.png'),
                      radius: 30,
                      backgroundColor: MyColors.grayLite,
                    ),
                  ),),
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(onTap: (){
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
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('icons/notification.svg'),
                    ),
                    borderOnForeground: false,
                    clipBehavior: Clip
                        .antiAlias,
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
                  Container(
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
                              '15',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              'Resolvidas',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                              '15',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              'Melhor',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                              '15',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              'Média',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Spacer(),
                  InkWell(onTap: (){
                    showDialog(
                      context: context,
                      builder: (_) => DialogDific(),
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
                    clipBehavior: Clip
                        .antiAlias,
                  ),),
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
                          width: _selectedIndex == 0 ? _tabs[0].length * 10 : 0,
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
                    padding: const EdgeInsets.only( left: 16, right: 16),
                    child: GridView.count(
                      crossAxisCount: 2, // Define duas colunas
                      children: List.generate(crossWords.length, (index) {
                        return MyCard(crossWordL: crossWords[index]);
                        ;
                      }),
                    ),
                  ),
                ),
              if (_selectedIndex == 1)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: GridView.count(
                      crossAxisCount: 2, // Define duas colunas
                      children: List.generate(crossWords2.length, (index) {
                        return MyCard(crossWordL: crossWords2[index]);
                        ;
                      }),
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
  final CrossWordL crossWordL;

  MyCard({required this.crossWordL});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                crossWordL.image,
                width: 80,
                height: 80,
              ),
              Text(
                crossWordL.title,
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
  }
}
