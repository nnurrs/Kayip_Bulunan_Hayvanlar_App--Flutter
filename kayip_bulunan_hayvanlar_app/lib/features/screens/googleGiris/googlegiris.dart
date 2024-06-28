import 'package:flutter/widgets.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/googleGiris/auth_service.dart';

Future<void> authenticateWithGoogle({required BuildContext context}) async {
  try {
    await AuthService.signInWithGoogle();
  } catch (e) {
    if (!context.mounted) return;
    print(e);
  }
}
