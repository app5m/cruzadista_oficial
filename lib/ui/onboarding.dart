import 'dart:async';

import 'package:cruzadista/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// VAI NA LINHA 68
class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController _pageController;
  int _pageIndex = 0;
  late Timer _timer;
  bool _isLastPage = false;

  @override
  void initState() {

    _pageController = PageController(initialPage: 0);
    super.initState();


  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.colorPrimary,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: MyColors.colorOnPrimary,
      body: Column(
        children: [
          Expanded(
              child: PageView.builder(
                  itemCount: demo_data.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                      _isLastPage = index == demo_data.length - 1;
                    });
                  },
                  itemBuilder: (context, index) => OnboardingContent(
                    image: demo_data[index].image,
                    title: demo_data[index].title,
                    subtitle: demo_data[index].subtitle,
                  ))),
          SizedBox(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                        demo_data.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: DotIndicator(
                            isActive: index == _pageIndex,
                          ),
                        )),

                  ],
                ),
              ),
            ),
          ),
          if (!_isLastPage)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/ui/login"); //AQUI ESTA UMA NAVEGAÇAO COM ROTA
                },
                child: Text(
                  "PULAR",
                  style: TextStyle(
                      color: MyColors.gray, fontFamily: 'Poppins', fontSize: 16),
                ),
                style: ButtonStyle(),
              ),
              TextButton(
                onPressed: () {
                  _pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn); //AQUI ESTA UMA NAVEGAÇAO COM ROTA
                },
                child: Text(
                  "AVANÇAR",
                  style: TextStyle(
                      color: MyColors.colorPrimary, fontFamily: 'Poppins', fontSize: 16),
                ),
                style: ButtonStyle(),
              )
            ],),
          ),
          if (_isLastPage)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/ui/login");
                  },
                  child: Text(
                    "INICIAR",
                    style: TextStyle(
                        color: MyColors.colorOnPrimary,
                        fontFamily: 'Poppins',
                        fontSize: 16),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    backgroundColor:
                    MaterialStateProperty.all(MyColors.colorPrimary),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class Onboard {
  final String image, title, subtitle;

  const Onboard(
      {required this.title, required this.image, required this.subtitle});
}

final List<Onboard> demo_data = [
  Onboard(
    image: 'images/crossword.png',
    title: "PASSATEMPO INTELIGENTE",
    subtitle: "",
  ),
  Onboard(
    image: 'images/playbutton.png',
    title: "SIMPLES E VICIANTE",
    subtitle: "Exemplo de subtitulo 2 funcionando page",
  ),
  Onboard(
    image: 'images/nightmode.png',
    title: "MODO NOTURNO",
    subtitle: "Exemplo de subtitulo 2 funcionando page",
  )
];

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, this.isActive = false}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isActive ? 20 : 10,
          width: 4,
          decoration: BoxDecoration(
              color: isActive ? MyColors.colorPrimary: MyColors.colorPrimary.withOpacity(0.4),
              borderRadius: BorderRadius.all(Radius.circular(12))
          )
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image, title, subtitle;

  const OnboardingContent(
      {Key? key,
        required this.title,
        required this.image,
        required this.subtitle});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      backgroundColor: MyColors.colorOnPrimary,
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                      child: Center(
                        child: Image.asset(
                          image,
                          height: 150,
                        ),
                      ),
                    ),
                SizedBox(height: 16,),
                Text(
                  title,
                  style: TextStyle(
                      color: MyColors.colorPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
              ],
            ),

        ),
      ),
    );
  }
}

