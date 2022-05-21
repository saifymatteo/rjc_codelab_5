import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjc_codelab_5/data/providers/bank_service.dart';
import 'package:rjc_codelab_5/data/providers/deposit_service.dart';
import 'package:rjc_codelab_5/data/providers/login_service.dart';
import 'package:rjc_codelab_5/data/providers/withdrawal_service.dart';
import 'package:rjc_codelab_5/views/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY']!,
      authDomain: "rjc-codelab-5.firebaseapp.com",
      projectId: "rjc-codelab-5",
      storageBucket: "rjc-codelab-5.appspot.com",
      messagingSenderId: dotenv.env['FIREBASE_MESSENGER_SENDER_ID']!,
      appId: dotenv.env['FIREBASE_APP_ID']!,
      measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID']!,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => FlutterBankService()),
        ChangeNotifierProvider(create: (_) => DepositService()),
        ChangeNotifierProvider(create: (_) => WithdrawalService()),
      ],
      child: const FlutterBankApp(),
    ),
  );
}

class FlutterBankApp extends StatelessWidget {
  const FlutterBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      routes: AppRoutes.routes,
    );
  }
}
