import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kurakani/services/database_service.dart';
import 'package:kurakani/services/media_service.dart';
import 'package:kurakani/services/navigation_service.dart';
import 'package:kurakani/services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashScreen({
    required Key key,
    required this.onInitializationComplete,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then(
      (value) => _setUp().then((value) => widget.onInitializationComplete()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kurakani',
      theme: ThemeData(
          dialogBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
          scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0)),
      home: Scaffold(
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/appicon.png'),
                  fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setUp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _registerServices();
  }

  void _registerServices() {
    GetIt.instance.registerSingleton<NavigationService>(
      NavigationService(),
    );
    GetIt.instance.registerSingleton<MediaService>(MediaService());
    GetIt.instance.registerSingleton<StorageService>(StorageService());
    GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
  }
}


