import 'package:cruzadista/components/colors.dart';
import 'package:cruzadista/components/fonte_size.dart';
import 'package:flutter/material.dart';

class DialogRecoveryPassword extends StatefulWidget {
  const DialogRecoveryPassword({Key? key}) : super(key: key);

  @override
  State<DialogRecoveryPassword> createState() => _DialogRecoveryPasswordState();
}

class _DialogRecoveryPasswordState extends State<DialogRecoveryPassword> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 280,
        child: Card(
          color: MyColors.grayLite,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Recuperar senha',
                  style: TextStyle(
                      fontSize: FontSizes.titulo, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16,),
                Text(
                  'Todas as intruções para alterar a senha serão enviadas via email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FontSizes.subTitulo, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 16,),
                Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                      //  Navigator.pushNamed(context, "/ui/login");
                      },
                      child: Text(
                        "REDEFINIR SENHA",
                        style: TextStyle(
                            color: MyColors.colorOnPrimary,
                            fontFamily: 'Poppins',
                            fontSize: 16),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            MyColors.colorPrimary),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 12)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
