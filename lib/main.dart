import 'package:flutter/material.dart';
import 'package:pixora/controllers/controllers.dart';
import 'package:pixora/views/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context) => ImagePickController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagePreviewController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImageUploadController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryController(),
        ),
      ], child: const HomeScreen()),
    );
  }
}
