import '../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


abstract class AppTheme{
  static ThemeData darkTheme=ThemeData(

    //application colors
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.darkText,
        secondary: AppColors.primaryDark,
        onSecondary: AppColors.darkText,
        error: AppColors.error,
        onError: AppColors.white,
        surface: AppColors.cardDark,
        onSurface: AppColors.white,
      ),

      //buttons colors
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.darkText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
          textStyle: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.darkText,
        ),
        ),
      ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.error,
        side: const BorderSide(
          color: AppColors.error,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        textStyle: GoogleFonts.manrope(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          letterSpacing: 3,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle:GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0
      ),

      //app text styles
      textTheme: TextTheme(
        // Very big title
        // Example: DESIGN YOUR DAILY
        displayLarge: const TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          height: 1.1,
        ),

        // Article details big title / big profile numbers
        displayMedium: const TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          height: 1.15,
        ),

        // Page titles
        // Example: Search, Saved, Sports Feed, Your daily briefing
        displaySmall: const TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),

        // Logo
        // Example: INSIGHTLY
        headlineLarge: const TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: AppColors.primary,
          letterSpacing: 1.2,
        ),

        // Section titles
        // Example: Trending Now, For You, Comments
        headlineMedium: const TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),

        // Article/card titles
        headlineSmall: const TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 21,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
          height: 1.25,
        ),

        // Auth page logo/title
        // Example: INSIGHTLY, JOIN INSIGHTLY
        titleLarge: const TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 34,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: AppColors.primary,
          letterSpacing: 1,
        ),

        // Buttons, chips, settings titles
        titleMedium: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),

        // Categories
        // Example: Technology, Sports, Business
        titleSmall: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
          letterSpacing: 1.2,
        ),

        // Article paragraphs
        bodyLarge: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.mutedText,
          height: 1.7,
        ),

        // Descriptions, subtitles, input hints
        bodyMedium: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.mutedText,
          height: 1.5,
        ),

        // Small source/time/read text
        bodySmall: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.mutedText,
          height: 1.4,
        ),

        // Main button text
        labelLarge: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.darkText,
        ),

        // Uppercase labels
        // Example: EMAIL ADDRESS, PASSWORD, TECHNOLOGY
        labelMedium: GoogleFonts.manrope(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.mutedText,
          letterSpacing: 1.8,
        ),

        // Very small metadata/nav labels
        // Example: HOME, SEARCH, SAVED, PROFILE
        labelSmall: GoogleFonts.manrope(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.mutedText,
          letterSpacing: 1,
        ),
      ),

      // APP BAR STYLE
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color: AppColors.primary,
          letterSpacing: 1,
        ),
        iconTheme: IconThemeData(
          color: AppColors.primary,
          size: 24,
        ),
      ),

      //app input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputFill,
      hintStyle: GoogleFonts.manrope(
        fontSize: 16,
        color: AppColors.mutedText,
      ),
      labelStyle:GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.mutedText,
        letterSpacing: 1.8,
      ),
      prefixIconColor: AppColors.mutedText,
      suffixIconColor: AppColors.mutedText,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 1.5,
        ),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.cardDark,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.mutedText,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: GoogleFonts.manrope(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
      ),
      unselectedLabelStyle: GoogleFonts.manrope(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
      ),
    ),

      // CARD STYLE
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
  );
}
/*static ThemeData lightTheme=ThemeData(
    //application colors
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.purple,
          onPrimary: AppColors.white,
          secondary: AppColors.black,
          onSecondary: AppColors.white,
          error: Colors.red,
          onError: AppColors.white,
          surface: AppColors.lightBlue,
          onSurface: AppColors.purple
      ),

      //buttons colors
      filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              padding: EdgeInsets.all(16),
              textStyle:TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              )
          )
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              padding: EdgeInsets.all(16),
              textStyle:TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              )
          )
      ),
      textButtonTheme:TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontSize: 20,
              fontStyle:FontStyle.italic ,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            padding: EdgeInsets.all(16),
            shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),

          )
      ) ,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0
      ),

      //app text styles
      textTheme: TextTheme(
        titleLarge: TextStyle(color:AppColors.purple),
        titleMedium: TextStyle(color:AppColors.purple),
        titleSmall: TextStyle(color:AppColors.purple),
        bodyLarge: TextStyle(color:AppColors.black),
        bodyMedium: TextStyle(color:AppColors.black),
        bodySmall: TextStyle(color:AppColors.black),
        labelLarge: TextStyle(color:AppColors.black),
        labelMedium: TextStyle(color:AppColors.black),
        labelSmall: TextStyle(color:AppColors.black),
      ),

      //app bar style
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBlue,
        foregroundColor: AppColors.purple,
        surfaceTintColor: Colors.transparent,
      ),

      //app input decoration
      inputDecorationTheme: InputDecorationTheme(
        iconColor: AppColors.grey,
        prefixIconColor: AppColors.grey,
        suffixIconColor: AppColors.grey,
        hintStyle: TextStyle(
          fontSize: 14,
          color: AppColors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color:AppColors.grey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color:AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color:AppColors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color:Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color:Colors.red),
        ),
      )
  );
*/