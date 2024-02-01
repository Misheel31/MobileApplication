import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocerystore/provider/productProvider.dart';
import 'package:grocerystore/screens/account/account_screen.dart';
import 'package:grocerystore/screens/pages/home_screen.dart';
import 'package:grocerystore/screens/pages/intro_page.dart';
import 'package:grocerystore/viewmodels/cartViewModel.dart';
import 'package:grocerystore/viewmodels/global_ui_viewmodel.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'viewmodels/auth_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => GlobalUIViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Grocery Store',
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => HomeScreen(),
          '/profile': (context) => AccountScreen(),
        },
        home: IntroPage(),
      ),
    );
  }
}
