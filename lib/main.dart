import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'welcome_screen.dart';
import 'package:nexora_app/home_screen.dart';
import 'package:nexora_app/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  Locale _locale = const Locale('en');

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NEXORA',

      themeMode: _themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor:
        const Color(0xFFF7F8FC),
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor:
        const Color(0xFF0B1020),
        useMaterial3: true,
      ),

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],

      locale: _locale,

      home: HomeScreen(
        isDarkMode: isDarkMode,
        onToggleTheme: toggleTheme,
        onToggleLanguage: toggleLanguage,
      ),
    );
  }
}

// =========================================================
// SPLASH
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
  State<NexoraSplash> createState() =>
      _NexoraSplashState();
}

class _NexoraSplashState extends State<NexoraSplash> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    _videoController =
        VideoPlayerController.asset(
          'assets/videos/nexora_intro.mp4',
        );

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      await _videoController.initialize();

      if (!mounted) return;

      setState(() {});

      await _videoController.setLooping(false);
      await _videoController.play();

      _videoController.addListener(() {
        if (!_videoController.value.isInitialized) {
          return;
        }

        final position =
            _videoController.value.position;
        final duration =
            _videoController.value.duration;

        if (position >= duration &&
            !_videoController.value.isPlaying &&
            mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeScreen(
                onLanguageChanged:
                widget.onLanguageChanged,
              ),
            ),
          );
        }
      });
    } catch (e) {
      debugPrint(
        'NEXORA Video Error: $e',
      );
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF02030A),

      body: Center(
        child: _videoController.value.isInitialized
            ? SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videoController
                  .value
                  .size
                  .width,
              height: _videoController
                  .value
                  .size
                  .height,
              child: VideoPlayer(
                _videoController,
              ),
            ),
          ),
        )
            : const CircularProgressIndicator(),
      ),
    );
  }
}