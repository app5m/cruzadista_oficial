import 'package:cruzadista/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/ui/onboarding'); //AQUI ESTA UMA NAVEGAÇAO COM ROTA
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0x15478E),
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: MyColors.colorOnPrimary,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png',
                height: 250,
              ),
              SizedBox(height: 16,),
              CircularProgressIndicator(color: MyColors.colorPrimary,)
            ],
          ),

        ),
      ),
    );
  }
}