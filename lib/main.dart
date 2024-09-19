import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/language_selection_screen.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/tutors_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/classroom_screen.dart';
import 'screens/schedule_class_screen.dart';
import 'screens/support_screen.dart';
import 'screens/shop_screen.dart'; // Importando a tela da loja

void main() {
  runApp(ScamblyApp());
}

class ScamblyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scambly',
      theme: ThemeData(
        primaryColor: Color(0xFF5B21B6),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF5B21B6),
          onPrimary: Colors.white, // Corrigido
          secondary: Color(0xFF7C3AED),
          surface: Color(0xFFF3E8FF),
          background: Color(0xFFFAF5FF),
        ),
        scaffoldBackgroundColor: Color(0xFFFAF5FF),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(
                0xFF5B21B6), // Atualizado para "backgroundColor" em vez de "primary"
            foregroundColor: Colors
                .white, // Atualizado para "foregroundColor" em vez de "onPrimary"
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC4B5FD)),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF7C3AED)),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            // Corrigido para "titleLarge"
            color: Color(0xFF4B0082),
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            // Corrigido para "bodyLarge"
            color: Color(0xFF333333),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/language-selection': (context) => LanguageSelectionScreen(),
        '/home': (context) => HomeScreen(),
        '/chat': (context) => ChatScreen(),
        '/tutors': (context) => TutorsScreen(),
        '/profile': (context) => ProfileScreen(),
        '/classroom': (context) => ClassroomScreen(),
        '/schedule': (context) => ScheduleClassScreen(),
        '/support': (context) => SupportScreen(), // Rota para suporte
        '/shop': (context) => ShopScreen(), // Rota para loja
      },
    );
  }
}
