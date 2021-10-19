import 'package:demoapp/cubit/ml_page/ml_page_cubit.dart';
import 'package:demoapp/services/fb_service.dart';
import 'package:demoapp/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login/ph_login_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MlPageCubit(),
      child: BlocProvider(
          create: (context) => PhLoginCubit(firebaseService: FirebaseService()),
          child: MaterialApp(
            home: FutureBuilder(
              // Initialize FlutterFire:
              future: _initialization,
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("oops"),
                    ),
                  );
                }

                // Once complete, show your application
                if (snapshot.connectionState == ConnectionState.done) {
                  return Home();
                }

                // Otherwise, show something whilst waiting for initialization to complete
                return Scaffold(
                  body: Center(
                    child: Text("Loading"),
                  ),
                );
              },
            ),
          )),
    );
  }
}
