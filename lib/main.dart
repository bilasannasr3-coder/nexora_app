
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'welcome_screen.dart';
import 'package:nexora_app/home_screen.dart';
import 'package:nexora_app/l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NexoraApp());
}

class NexoraApp extends StatefulWidget {
  const NexoraApp({super.key});

  @override
  State<NexoraApp> createState() => _NexoraAppState();
}

class _NexoraAppState extends State<NexoraApp> {
  // اللغة الافتراضية هي العربية.
  Locale _locale = const Locale('ar');

  ThemeMode _themeMode = ThemeMode.light;

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void toggleLanguage() {
    setState(() {
      _locale = _locale.languageCode == 'en'
          ? const Locale('ar')
          : const Locale('en');
    });
  }

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = _themeMode == ThemeMode.dark;

    const lightBackground = Color(0xFFF7F8FC);
    const darkBackground = Color(0xFF0B1020);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NEXORA',

      themeMode: _themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightBackground,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: lightBackground,
          foregroundColor: Color(0xFF171A2C),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkBackground,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: darkBackground,
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),

      // ضبط ألوان شريط الحالة وشريط التنقل في الهاتف.
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
            statusBarBrightness:
            isDarkMode ? Brightness.dark : Brightness.light,
            systemNavigationBarColor:
            isDarkMode ? darkBackground : lightBackground,
            systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarDividerColor: Colors.transparent,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],

      locale: _locale,

      // الصفحة الرئيسية بعد تسجيل الدخول أو حسب التدفق الحالي للمشروع.
      home: HomeScreen(
        isDarkMode: isDarkMode,
        onToggleTheme: toggleTheme,
        onToggleLanguage: toggleLanguage,
      ),
    );
  }
}

// =========================================================
// NEXORA SPLASH SCREEN
// =========================================================

class NexoraSplash extends StatefulWidget {
  final void Function(Locale locale) onLanguageChanged;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final VoidCallback onToggleLanguage;

  const NexoraSplash({
    super.key,
    required this.onLanguageChanged,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.onToggleLanguage,
  });

  @override
  State<NexoraSplash> createState() => _NexoraSplashState();
}

class _NexoraSplashState extends State<NexoraSplash> {
  late final VideoPlayerController _videoController;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset(
      'assets/videos/nexora_intro.mp4',
    );

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      await _videoController.initialize();

      if (!mounted) return;

      await _videoController.setLooping(false);

      _videoController.addListener(_checkVideoFinished);

      setState(() {});

      await _videoController.play();
    } catch (e) {
      debugPrint('NEXORA Video Error: $e');
    }
  }

  void _checkVideoFinished() {
    if (!mounted || _hasNavigated) return;

    final value = _videoController.value;

    if (value.isInitialized &&
        value.duration > Duration.zero &&
        value.position >= value.duration &&
        !value.isPlaying) {
      _hasNavigated = true;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(
            onLanguageChanged: widget.onLanguageChanged,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _videoController.removeListener(_checkVideoFinished);
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: const Color(0xFF02030A),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF02030A),
        body: SizedBox.expand(
          child: _videoController.value.isInitialized
              ? FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videoController.value.size.width,
              height: _videoController.value.size.height,
              child: VideoPlayer(_videoController),
            ),
          )
              : const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF4A6CF7),
            ),
          ),
        ),
      ),
    );
  }
}
