import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoop_app/app/customers/auth/customer_login_page.dart';
import 'package:shoop_app/app/customers/auth/customer_signup_page.dart';
import 'package:shoop_app/app/customers/main_pages/customer/customer_page.dart';
import 'package:shoop_app/app/home_page.dart';
import 'package:shoop_app/app/suppliers/auth/supplaers_login.dart';
import 'package:shoop_app/app/suppliers/auth/supplaers_signup.dart';
import 'package:shoop_app/app/suppliers/main_pages/upload/upload_page.dart';
import 'package:shoop_app/app/suppliers/supplaers_page.dart';
import 'package:shoop_app/app/welcome_page/welcome_page.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
  runApp(const ShoopApp());
}

class ShoopApp extends StatelessWidget {
  const ShoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: UploadPage(),
      // home: SuppliersPage(),

      initialRoute: '/welcome_page',
      routes: {
        '/welcome_page': (context) => const WelcomePage(),
        '/home_page': (context) => const HomePage(),
        '/customer_signup_page': (context) => const CustomerSignUpPage(),
        '/customer_page': (context) => const CustomerPage(),
        '/customer_login_page': (context) => const CustomerLogInPage(),
        '/suppliers_page': (context) => const SuppliersPage(),
        '/suppliers_signup': (context) => const SuppliersSignUp(),
        '/suppliers_login': (context) => const SuppliersLogIn(),
      },
    );
  }
}
