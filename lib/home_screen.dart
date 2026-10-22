import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexora_app/l10n/app_localizations.dart';
import 'package:nexora_app/tests_screen.dart';
import 'package:nexora_app/grade_entry_screen.dart';
import 'package:nexora_app/results_screen.dart';
import 'package:nexora_app/academic_path_screen.dart';
import 'package:nexora_app/account_screen.dart';
import 'package:nexora_app/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback? onToggleTheme;
  final VoidCallback? onToggleLanguage;

  const HomeScreen({
    super.key,
    this.isDarkMode = false,
    this.onToggleTheme,
    this.onToggleLanguage,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Keeps the entered averages in memory while the app session is active.
  GradeEntryResult? _gradeEntryResult;
  String? _profileImagePath;

// NEXORA COLORS
  static const Color nexoraBlue = Color(0xFF4A6CF7);
  static const Color nexoraPurple = Color(0xFF7C4DFF);

  static const Color lightText = Color(0xFF172033);
  static const Color lightSoftText = Color(0xFF6B7280);
  static const Color lightBackground = Color(0xFFF7F8FC);

  static const Color darkBackground = Color(0xFF0B0D18);
  static const Color darkCard = Color(0xFF191D30);
  static const Color darkText = Color(0xFFF7F8FF);
  static const Color darkSoftText = Color(0xFFD0D5E5);


  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final isArabic =
        Localizations.localeOf(context).languageCode == 'ar';

    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: isArabic
            ? GoogleFonts.cairoTextTheme(
          Theme.of(context).textTheme,
        )
            : GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: nexoraPurple,
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: nexoraPurple,
          secondary: nexoraPurple,
        ),
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: widget.isDarkMode
              ? const Color(0xFF30234F)
              : const Color(0xFFF0E9FF),
          labelTextStyle:
          WidgetStateProperty.resolveWith<TextStyle>((states) {
            final selected =
            states.contains(WidgetState.selected);

            return TextStyle(
              fontWeight: selected
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: selected
                  ? nexoraPurple
                  : (widget.isDarkMode
                  ? darkSoftText
                  : lightSoftText),
            );
          }),
        ),
      ),
      child: Directionality(
        textDirection:
        isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: widget.isDarkMode
              ? darkBackground
              : lightBackground,
          body: SafeArea(
            child: _buildCurrentPage(local, isArabic),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(local),
        ),
      ),
    );
  }

  Future<void> _openGradeEntry() async {
    final result = await Navigator.of(context).push<GradeEntryResult>(
      MaterialPageRoute(
        builder: (_) => GradeEntryScreen(),
      ),
    );

    if (!mounted || result == null) return;

    setState(() {
      _gradeEntryResult = result;
    });
  }

  Future<void> _openAcademicPath() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AcademicPathScreen(
          isDarkMode: widget.isDarkMode,
          gradeEntryResult: _gradeEntryResult,
        ),
      ),
    );
  }

  // CURRENT PAGE

  Widget _buildCurrentPage(
      AppLocalizations local,
      bool isArabic,
      ) {
    switch (_currentIndex) {
      case 0:
        return _buildHome(local, isArabic);
      case 1:
        return const TestsScreen();
      case 2:
        return ResultsScreen(
          isDarkMode: widget.isDarkMode,
          gradeEntryResult: _gradeEntryResult,
        );
      case 3:
        return DashboardScreen(
          isDarkMode: widget.isDarkMode,
          isArabic: isArabic,
          onOpenResults: () => setState(() => _currentIndex = 2),
          onOpenTests: () => setState(() => _currentIndex = 1),
          onOpenGrades: _openGradeEntry,
          onOpenAcademicPath: _openAcademicPath,
        );
      case 4:
        return AccountScreen(
          isDarkMode: widget.isDarkMode,
          onToggleTheme: widget.onToggleTheme,
          onToggleLanguage: widget.onToggleLanguage,
          onOpenGrades: _openGradeEntry,
          gradeEntryResult: _gradeEntryResult,
          profileImagePath: _profileImagePath,
          onProfileImageChanged: (path) {
            setState(() => _profileImagePath = path);
          },
        );
      default:
        return _buildHome(local, isArabic);
    }
  }

// HOME

  Widget _buildHome(
      AppLocalizations local,
      bool isArabic,
      ) {
    final isDark = widget.isDarkMode;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(isArabic, isDark),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeText(local, isDark),
                const SizedBox(height: 20),
                _buildMainTestCard(local),
                const SizedBox(height: 16),
                _buildGradeEntryCard(
                  isArabic: isArabic,
                  isDark: isDark,
                  gradeResult: _gradeEntryResult,
                ),
                const SizedBox(height: 28),
                _buildSectionTitle(
                  title: local.journeyTitle,
                  subtitle: local.journeySubtitle,
                  isDark: isDark,
                ),
                const SizedBox(height: 14),
                _buildJourneyGrid(local, isDark),
                const SizedBox(height: 28),
                _buildProgressCard(local, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

// TOP BAR - REDUCED HEIGHT

  Widget _buildTopBar(
      bool isArabic,
      bool isDark,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [
            Color(0xFF080B1A),
            Color(0xFF171B3A),
            Color(0xFF21153D),
          ]
              : const [
            Color(0xFF263A9B),
            Color(0xFF4A4FC4),
            Color(0xFF693FAD),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.25)
                : nexoraPurple.withOpacity(0.20),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: isArabic
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Image.asset(
                'assets/images/nexora_logo.png',
                width: 110,
                height: 54,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _buildTopButton(
            icon: Icons.language_rounded,
            isDark: isDark,
            onPressed: widget.onToggleLanguage,
          ),
          const SizedBox(width: 7),
          _buildTopButton(
            icon: isDark
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            isDark: isDark,
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
    );
  }

// TOP BUTTON

  Widget _buildTopButton({
    required IconData icon,
    required bool isDark,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: 38,
      height: 38,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(
            isDark ? 0.10 : 0.16,
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.25),
          ),
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 19,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

// WELCOME TEXT

  Widget _buildWelcomeText(
      AppLocalizations local,
      bool isDark,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          local.homeWelcome,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: isDark ? darkText : lightText,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          local.homeDescription,
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: isDark ? darkSoftText : lightSoftText,
          ),
        ),
      ],
    );
  }

// MAIN TEST CARD

  Widget _buildMainTestCard(AppLocalizations local) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(23),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF596FF6),
            Color(0xFF7552E8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: nexoraBlue.withOpacity(0.22),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.explore_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            local.readyToDiscover,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            local.testDescription,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: nexoraPurple,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                local.startTests,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// GRADE ENTRY CARD
  Widget _buildGradeEntryCard({
    required bool isArabic,
    required bool isDark,
    required GradeEntryResult? gradeResult,
  }) {
    final cardColor = isDark ? darkCard : Colors.white;
    final titleColor = isDark ? darkText : lightText;
    final subtitleColor = isDark ? darkSoftText : lightSoftText;

    final subtitle = gradeResult == null
        ? (isArabic
        ? 'أدخل معدلات الصفوف السابع والثامن والتاسع'
        : 'Enter your Grade 7, 8 and 9 averages')
        : (isArabic
        ? 'تم إدخال المعدلات: السابع ${_formatAverage(gradeResult.grade7AnnualAverage)}%، الثامن ${_formatAverage(gradeResult.grade8AnnualAverage)}%، التاسع ${_formatAverage(gradeResult.grade9Average)}%'
        : 'Averages entered: Grade 7 ${_formatAverage(gradeResult.grade7AnnualAverage)}%, Grade 8 ${_formatAverage(gradeResult.grade8AnnualAverage)}%, Grade 9 ${_formatAverage(gradeResult.grade9Average)}%');

    return InkWell(
      onTap: _openGradeEntry,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isDark
                ? const Color(0xFF343A55)
                : const Color(0xFFEAECF2),
          ),
          boxShadow: [
            BoxShadow(
              color: nexoraPurple.withOpacity(isDark ? 0.08 : 0.05),
              blurRadius: 16,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF30234F)
                    : const Color(0xFFF0E9FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.school_outlined,
                color: nexoraPurple,
                size: 27,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'المعدلات الدراسية' : 'School Grades',
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              isArabic
                  ? Icons.arrow_back_ios_new_rounded
                  : Icons.arrow_forward_ios_rounded,
              color: nexoraPurple,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  String _formatAverage(double value) {
    return value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(1);
  }

  // SECTION TITLE

  Widget _buildSectionTitle({
    required String title,
    required String subtitle,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: isDark ? darkText : lightText,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? darkSoftText : lightSoftText,
          ),
        ),
      ],
    );
  }

// JOURNEY GRID - MORE VERTICAL SPACE

  Widget _buildJourneyGrid(
      AppLocalizations local,
      bool isDark,
      ) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,

// Lower ratio = taller cards.
// This helps prevent English text overflow.
      childAspectRatio: 0.95,

      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildJourneyCard(
          icon: Icons.assignment_outlined,
          title: local.tests,
          subtitle: local.discoverAbilities,
          iconColor: nexoraBlue,
          lightColor: const Color(0xFFEEF2FF),
          darkColor: const Color(0xFF202A52),
          isDark: isDark,
          onTap: () {
            setState(() {
              _currentIndex = 1;
            });
          },
        ),
        _buildJourneyCard(
          icon: Icons.analytics_outlined,
          title: local.results,
          subtitle: local.reviewResults,
          iconColor: const Color(0xFF8B5CF6),
          lightColor: const Color(0xFFF3EEFF),
          darkColor: const Color(0xFF30234F),
          isDark: isDark,
          onTap: () {
            setState(() {
              _currentIndex = 2;
            });
          },
        ),
        _buildJourneyCard(
          icon: Icons.route_outlined,
          title: local.academicPath,
          subtitle: local.recommendedPath,
          iconColor: const Color(0xFF0EA5A4),
          lightColor: const Color(0xFFEAFBF9),
          darkColor: const Color(0xFF173E3D),
          isDark: isDark,
          onTap: _openAcademicPath,
        ),
        _buildJourneyCard(
          icon: Icons.school_outlined,
          title: local.specializations,
          subtitle: local.exploreFuture,
          iconColor: const Color(0xFFEC4899),
          lightColor: const Color(0xFFFFEEF7),
          darkColor: const Color(0xFF47243B),
          isDark: isDark,
          onTap: () {},
        ),
      ],
    );
  }

// JOURNEY CARD

  Widget _buildJourneyCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color lightColor,
    required Color darkColor,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(21),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1B2035) : Colors.white,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: isDark
                ? const Color(0xFF343A55)
                : const Color(0xFFEAECF2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isDark ? darkColor : lightColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 23,
              ),
            ),
            const Spacer(),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDark ? darkText : lightText,
                fontSize: 14,
                height: 1.25,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDark ? darkSoftText : lightSoftText,
                fontSize: 11,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

// PROGRESS CARD

  Widget _buildProgressCard(
      AppLocalizations local,
      bool isDark,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: isDark ? darkCard : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isDark
              ? const Color(0xFF343A55)
              : const Color(0xFFEAECF2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF202A52)
                  : const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.auto_graph_rounded,
              color: nexoraBlue,
              size: 28,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  local.journeyNotStarted,
                  style: TextStyle(
                    color: isDark ? darkText : lightText,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  local.startTestsToSee,
                  style: TextStyle(
                    color: isDark ? darkSoftText : lightSoftText,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// BOTTOM NAVIGATION

  Widget _buildBottomNavigationBar(AppLocalizations local) {
    final isDark = widget.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? darkCard : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark
                ? const Color(0xFF343A55)
                : const Color(0xFFEDEEF3),
          ),
        ),
      ),
      child: NavigationBar(
        height: 70,
        backgroundColor: isDark ? darkCard : Colors.white,
        elevation: 0,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: isDark
            ? const Color(0xFF202A52)
            : const Color(0xFFEEF2FF),
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: isDark ? darkSoftText : lightSoftText,
            ),
            selectedIcon: const Icon(
              Icons.home_rounded,
              color: nexoraPurple,
            ),
            label: local.home,
          ),
          NavigationDestination(
            icon: Icon(
              Icons.assignment_outlined,
              color: isDark ? darkSoftText : lightSoftText,
            ),
            selectedIcon: const Icon(
              Icons.assignment_rounded,
              color: nexoraPurple,
            ),
            label: local.tests,
          ),
          NavigationDestination(
            icon: Icon(
              Icons.analytics_outlined,
              color: isDark ? darkSoftText : lightSoftText,
            ),
            selectedIcon: const Icon(
              Icons.analytics_rounded,
              color: nexoraPurple,
            ),
            label: local.results,
          ),
          NavigationDestination(
            icon: Icon(
              Icons.dashboard_outlined,
              color: isDark ? darkSoftText : lightSoftText,
            ),
            selectedIcon: const Icon(
              Icons.dashboard_rounded,
              color: nexoraPurple,
            ),
            label: Localizations.localeOf(context).languageCode == 'ar'
                ? 'لوحتي'
                : 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outline_rounded,
              color: isDark ? darkSoftText : lightSoftText,
            ),
            selectedIcon: const Icon(
              Icons.person_rounded,
              color: nexoraPurple,
            ),
            label: local.account,
          ),
        ],
      ),
    );
  }

// TEMPORARY PLACEHOLDER

  Widget _buildPlaceholder(
      String title,
      String message,
      ) {
    final isDark = widget.isDarkMode;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.construction_outlined,
            color: nexoraBlue,
            size: 50,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: isDark ? darkText : lightText,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              color: isDark ? darkSoftText : lightSoftText,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

