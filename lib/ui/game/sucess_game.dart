import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../components/fonte_size.dart';

class SucessGame extends StatefulWidget {
  const SucessGame({super.key});

  @override
  State<SucessGame> createState() => _SucessGameState();
}

class _SucessGameState extends State<SucessGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: const EdgeInsets.only(top: 76, left: 16, right: 16),
      child: Center(
        child: Column(

          children: [
            Lottie.asset('animation/a_confetti.json',
                repeat: true,
                reverse: true,
                animate: true,
                width: 450,
                height: 300),
            SizedBox(height: 16,),
            Text(
              'Parabéns!!!',
              style: TextStyle(
                fontSize: FontSizes.textoGrande,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16,),
            Text(
              'Você concluiu a cruzada com sucesso! Agora é hora de voltar, concluir as outras e testar seu conhecimento ainda mais!',
              style: TextStyle(
                fontSize: FontSizes.textoNormal,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/ui/home', (Route<dynamic> route) => false,);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: Text(
                "Voltar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSizes.textoNormal,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
