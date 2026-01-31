import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/otp_verification_screen.dart';
import 'screens/profile_setup_screen.dart';
import 'screens/pin_setup_screen.dart';
import 'screens/fingerprint_setup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const HiChatApp());
}

class HiChatApp extends StatelessWidget {
  const HiChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HiChat',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Use dark theme by default for Discord feel
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/otp': (context) => const OTPVerificationScreen(),
        '/profile-setup': (context) => const ProfileSetupScreen(),
        '/pin-setup': (context) => const PinSetupScreen(),
        '/fingerprint-setup': (context) => const FingerprintSetupScreen(),
        '/home': (context) => const HomeScreen(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
