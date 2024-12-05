import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taskmanager/features/auth/presentation/screens/auth_screen.dart';
import 'package:taskmanager/features/auth/presentation/screens/auth_wrapper.dart';
import 'package:taskmanager/features/auth/presentation/screens/splash_screen.dart';
import 'package:taskmanager/features/task/view/screens/task_list_screen.dart';
import 'package:taskmanager/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/shared/widgets/task_card.dart';

Future<void> main() async {
  await dotenv.load(fileName: "key.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task Manager',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          useMaterial3: true,
        ),
        home: const TaskListScreen() //StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const SplashScreen();
        //     }
        //     if (snapshot.hasData) {
        //       return const HomePage();
        //     }
        //     return const AuthScreen();
        //   },
        // ),
        );
  }
}
