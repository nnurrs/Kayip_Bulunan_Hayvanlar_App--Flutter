import 'package:flutter/material.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/auth/views/sign_in.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/auth/views/sign_up.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/mailPasswordGiris/custom_scaffold.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/mailPasswordGiris/welcome_button.dart';

abstract class Welcomegiriskayitol extends StatelessWidget {
  const Welcomegiriskayitol({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Giriş Yap',
                      onTap: SignIn(),
                      color: Color(0xFFf9232c),
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Kayıt Ol',
                      onTap: SignUp(),
                      color: Colors.white,
                      textColor: Color(0xFFf9232c),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
