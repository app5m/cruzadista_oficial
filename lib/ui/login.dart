import 'package:cruzadista/components/colors.dart';
import 'package:cruzadista/components/fonte_size.dart';
import 'package:flutter/material.dart';

import '../components/alert_dialog_recovery_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _colorBtnLogin = MyColors.colorPrimary;
  var _colorBtnRegistre = MyColors.gray;
  bool _screenLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 56.0, left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Center(
                child: Image.asset(
                  'images/logo.png',
                  height: 120,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _colorBtnLogin = MyColors.colorPrimary;
                          _colorBtnRegistre = MyColors.gray;
                          _screenLogin = false;
                        });
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: _colorBtnLogin,
                            fontSize: FontSizes.titulo,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      )),
                  TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _colorBtnLogin = MyColors.gray;
                          _colorBtnRegistre = MyColors.colorPrimary;
                          _screenLogin = true;
                        });
                      },
                      child: Text(
                        "Cadastro",
                        style: TextStyle(
                            color: _colorBtnRegistre,
                            fontSize: FontSizes.titulo,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
              if (!_screenLogin)
                Container(
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                                filled: false),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Senha',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/ui/home");
                            },
                            child: Text(
                              "ENTRAR",
                              style: TextStyle(
                                  color: MyColors.colorOnPrimary,
                                  fontFamily: 'Poppins',
                                  fontSize: 16),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  MyColors.colorPrimary),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 16)),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent,
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogRecoveryPassword();
                                  },
                                );
                              },
                              child: Text(
                                "Esqueceu a Senha?",
                                style: TextStyle(
                                    color: _colorBtnLogin,
                                    fontSize: FontSizes.textoNormal,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              if (_screenLogin)
                Container(
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nome',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Celular',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Senha',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirmar Senha',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Ao clicar no botão Cadastrar, você aceita os'),
                      Text(
                        'termos de privacidade do aplicativo.',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/ui/home");
                            },
                            child: Text(
                              "CADASTRA-SE",
                              style: TextStyle(
                                  color: MyColors.colorOnPrimary,
                                  fontFamily: 'Poppins',
                                  fontSize: 16),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  MyColors.colorPrimary),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 16)),
                            ),
                          ),
                        ),
                      )
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
