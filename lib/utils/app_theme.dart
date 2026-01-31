import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Discord-inspired Colors
  static const Color primaryBlue = Color(0xFF5865F2); // Discord Blurple
  static const Color lightBlue = Color(0xFF7289DA);
  static const Color darkBlue = Color(0xFF4752C4);
  
  // Discord Dark Theme
  static const Color backgroundDark = Color(0xFF36393F); // Discord Dark
  static const Color surfaceDark = Color(0xFF2F3136); // Discord Darker
  static const Color cardDark = Color(0xFF202225); // Discord Darkest
  
  // Light Theme (for auth screens)
  static const Color backgroundColor = Color(0xFFF2F3F5);
  static const Color cardBackground = Colors.white;
  
  // Text Colors
  static const Color textPrimary = Color(0xFFDCDDDE); // Discord Light Text
  static const Color textSecondary = Color(0xFF96989D); // Discord Muted Text
  static const Color textDark = Color(0xFF2E3338); // For light backgrounds
  
  // Accent Colors
  static const Color errorColor = Color(0xFFED4245); // Discord Red
  static const Color successColor = Color(0xFF3BA55D); // Discord Green
  static const Color onlineGreen = Color(0xFF3BA55D);
  static const Color warningColor = Color(0xFFFAA81A); // Discord Yellow
  
  // Telegram-inspired Chat Colors
  static const Color telegramBlue = Color(0xFF0088CC);
  static const Color telegramGreen = Color(0xFF34C759);
  static const Color chatBubbleOutgoing = Color(0xFF0088CC); // Telegram outgoing
  static const Color chatBubbleIncoming = Color(0xFF40444B); // Discord-style incoming
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF5865F2), Color(0xFF4752C4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient discordGradient = LinearGradient(
    colors: [Color(0xFF7289DA), Color(0xFF5865F2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Telegram-style chat bubble gradient
  static const LinearGradient telegramBubbleGradient = LinearGradient(
    colors: [Color(0xFF0088CC), Color(0xFF0077B5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Styles with Discord's font feeling
  static TextStyle get headingLarge => GoogleFonts.notoSans(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get headingMedium => GoogleFonts.notoSans(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    letterSpacing: -0.3,
  );

  static TextStyle get headingSmall => GoogleFonts.notoSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle get bodyLarge => GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );

  static TextStyle get bodyMedium => GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );

  static TextStyle get bodySmall => GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );

  static TextStyle get buttonText => GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        secondary: lightBlue,
        error: errorColor,
        background: backgroundColor,
        surface: cardBackground,
      ),
      
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: headingMedium,
        iconTheme: const IconThemeData(color: textPrimary),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        hintStyle: bodyMedium,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: buttonText,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: textPrimary,
        size: 24,
      ),
    );
  }

  // Animations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // Border Radius - Discord Style (more subtle)
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;

  // Spacing
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  // Discord Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: primaryBlue,
        secondary: lightBlue,
        error: errorColor,
        background: backgroundDark,
        surface: surfaceDark,
        onSurface: textPrimary,
      ),
      
      // AppBar Theme - Discord Style
      appBarTheme: AppBarTheme(
        backgroundColor: cardDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: headingMedium.copyWith(color: textPrimary),
        iconTheme: const IconThemeData(color: textPrimary),
      ),

      // Card Theme - Discord Dark Cards
      cardTheme: CardThemeData(
        color: surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        hintStyle: bodyMedium,
      ),

      // Elevated Button Theme - Discord Style
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: buttonText,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: textPrimary,
        size: 24,
      ),

      // Bottom Navigation Bar - Discord Style
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardDark,
        indicatorColor: primaryBlue.withOpacity(0.15),
        labelTextStyle: MaterialStateProperty.all(
          bodySmall.copyWith(fontSize: 12),
        ),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: primaryBlue);
          }
          return IconThemeData(color: textSecondary);
        }),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: surfaceDark,
        thickness: 1,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        tileColor: surfaceDark,
        textColor: textPrimary,
        iconColor: textPrimary,
      ),
    );
  }
}
