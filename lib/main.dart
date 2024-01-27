import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meetx/firebase_options.dart';
import 'package:meetx/resources/auth_methods.dart';
import 'package:meetx/screens/home_screen.dart';
import 'package:meetx/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const meetx());
}

class meetx extends StatefulWidget {
  const meetx({super.key});

  @override
  State<meetx> createState() => _meetxState();
}

class _meetxState extends State<meetx> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meetx',
      theme: ThemeData.dark().copyWith(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home_screen': (context) => const HomeScreen()
      },
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
