
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  static const Color nexoraBlue = Color(0xFF4A6CF7);
  static const Color nexoraPurple = Color(0xFF7B4DFF);

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar';

  TextStyle _textStyle(
      BuildContext context, {
        double size = 14,
        FontWeight weight = FontWeight.normal,
        Color? color,
      }) {
    final isArabic = _isArabic(context);

    return (isArabic
        ? GoogleFonts.cairo(
      fontSize: size,
      fontWeight: weight,
      color: color,
    )
        : GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: color,
    ))
        .copyWith(height: 1.5);
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final background = isDark
        ? const Color(0xFF10121C)
        : const Color(0xFFF7F8FC);

    final cardColor = isDark
        ? const Color(0xFF1B1E2B)
        : Colors.white;

    final primaryText = isDark
        ? Colors.white
        : const Color(0xFF20243A);

    final secondaryText = isDark
        ? Colors.white70
        : const Color(0xFF747B91);

    final tests = <_TestInfo>[
      _TestInfo(
        title: isArabic ? 'الميول والاهتمامات' : 'Interests Assessment',
        description: isArabic
            ? 'اكتشف المجالات والأنشطة التي تناسب اهتماماتك.'
            : 'Discover the activities and fields that interest you.',
        icon: Icons.explore_outlined,
        color: const Color(0xFF4A6CF7),
        duration: isArabic ? 'المدة ستُحدَّد لاحقًا' : 'Duration to be determined',
      ),
      _TestInfo(
        title: isArabic ? 'اختبار الشخصية' : 'Personality Assessment',
        description: isArabic
            ? 'تعرّف على جوانب شخصيتك التي قد تساعد في توجيه مسارك.'
            : 'Explore personality traits that may help guide your path.',
        icon: Icons.psychology_outlined,
        color: const Color(0xFF8A55E8),
        duration: isArabic ? 'المدة ستُحدَّد لاحقًا' : 'Duration to be determined',
      ),
      _TestInfo(
        title: isArabic ? 'المهارات والقدرات' : 'Skills & Abilities',
        description: isArabic
            ? 'استكشف مهاراتك وقدراتك لدعم اختيار مسارك الدراسي.'
            : 'Explore your abilities to support your academic path choice.',
        icon: Icons.lightbulb_outline_rounded,
        color: const Color(0xFF16A6A0),
        duration: isArabic ? 'المدة ستُحدَّد لاحقًا' : 'Duration to be determined',
      ),
    ];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            tooltip: isArabic ? 'رجوع' : 'Back',
            icon: Icon(
              isArabic
                  ? Icons.arrow_forward_rounded
                  : Icons.arrow_back_rounded,
              color: primaryText,
            ),
            onPressed: () => Navigator.maybePop(context),
          ),
          title: Text(
            isArabic ? 'الاختبارات' : 'Assessments',
            style: _textStyle(
              context,
              size: 20,
              weight: FontWeight.bold,
              color: primaryText,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [nexoraBlue, nexoraPurple],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: nexoraBlue.withValues(alpha: 0.18),
                      blurRadius: 22,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.track_changes_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isArabic
                          ? 'اكتشف مسارك مع NEXORA'
                          : 'Discover Your Path with NEXORA',
                      style: _textStyle(
                        context,
                        size: 21,
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isArabic
                          ? 'ابدأ بالتعرّف على ميولك وشخصيتك وقدراتك لتساعدك النتائج في التفكير بمسارك الدراسي.'
                          : 'Explore your interests, personality, and abilities to help you think about your academic path.',
                      style: _textStyle(
                        context,
                        size: 13,
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Text(
                isArabic ? 'اختباراتك' : 'Your Assessments',
                style: _textStyle(
                  context,
                  size: 19,
                  weight: FontWeight.bold,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                isArabic
                    ? 'اختَر اختبارًا لقراءة مقدمته قبل البدء.'
                    : 'Choose an assessment to read its introduction before starting.',
                style: _textStyle(
                  context,
                  size: 12,
                  color: secondaryText,
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(tests.length, (index) {
                final test = tests[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _TestCard(
                    test: test,
                    cardColor: cardColor,
                    primaryText: primaryText,
                    secondaryText: secondaryText,
                    textStyle: _textStyle,
                    isArabic: isArabic,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TestIntroScreen(
                            test: test,
                            isArabic: isArabic,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 19,
                    color: secondaryText,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isArabic
                          ? 'محتوى الأسئلة والنتائج قيد التجهيز والمراجعة قبل اعتماده.'
                          : 'Assessment questions and results are being prepared and reviewed before approval.',
                      style: _textStyle(
                        context,
                        size: 11,
                        color: secondaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestInfo {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String duration;

  const _TestInfo({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.duration,
  });
}

class _TestCard extends StatelessWidget {
  final _TestInfo test;
  final Color cardColor;
  final Color primaryText;
  final Color secondaryText;
  final TextStyle Function(
      BuildContext, {
      double size,
      FontWeight weight,
      Color? color,
      }) textStyle;
  final bool isArabic;
  final VoidCallback onTap;

  const _TestCard({
    required this.test,
    required this.cardColor,
    required this.primaryText,
    required this.secondaryText,
    required this.textStyle,
    required this.isArabic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: test.color.withValues(alpha: 0.13),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: test.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  test.icon,
                  color: test.color,
                  size: 29,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      test.title,
                      style: textStyle(
                        context,
                        size: 15,
                        weight: FontWeight.bold,
                        color: primaryText,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      test.description,
                      style: textStyle(
                        context,
                        size: 11,
                        color: secondaryText,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      test.duration,
                      style: textStyle(
                        context,
                        size: 10,
                        weight: FontWeight.w600,
                        color: test.color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                isArabic
                    ? Icons.chevron_left_rounded
                    : Icons.chevron_right_rounded,
                color: secondaryText,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestIntroScreen extends StatelessWidget {
  final _TestInfo test;
  final bool isArabic;

  const TestIntroScreen({
    super.key,
    required this.test,
    required this.isArabic,
  });

  TextStyle _style(
      BuildContext context, {
        double size = 14,
        FontWeight weight = FontWeight.normal,
        Color? color,
      }) {
    return (isArabic
        ? GoogleFonts.cairo(
      fontSize: size,
      fontWeight: weight,
      color: color,
    )
        : GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: color,
    ))
        .copyWith(height: 1.6);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background =
    isDark ? const Color(0xFF10121C) : const Color(0xFFF7F8FC);
    final cardColor =
    isDark ? const Color(0xFF1B1E2B) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF20243A);
    final secondaryText =
    isDark ? Colors.white70 : const Color(0xFF747B91);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0,
          title: Text(
            isArabic ? 'مقدمة الاختبار' : 'Assessment Introduction',
            style: _style(
              context,
              size: 18,
              weight: FontWeight.bold,
              color: primaryText,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: test.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Icon(test.icon, color: test.color, size: 52),
                ),
                const SizedBox(height: 24),
                Text(
                  test.title,
                  textAlign: TextAlign.center,
                  style: _style(
                    context,
                    size: 23,
                    weight: FontWeight.bold,
                    color: primaryText,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  test.description,
                  textAlign: TextAlign.center,
                  style: _style(
                    context,
                    size: 14,
                    color: secondaryText,
                  ),
                ),
                const SizedBox(height: 26),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: test.color,
                        size: 26,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isArabic
                            ? 'قبل البدء'
                            : 'Before You Begin',
                        style: _style(
                          context,
                          size: 16,
                          weight: FontWeight.bold,
                          color: primaryText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isArabic
                            ? 'ستظهر الأسئلة المعتمدة هنا بعد تجهيزها ومراجعتها. لا توجد أسئلة فعلية مضافة لهذا الاختبار حتى الآن.'
                            : 'Approved questions will appear here once they are prepared and reviewed. Actual assessment questions have not been added yet.',
                        textAlign: TextAlign.center,
                        style: _style(
                          context,
                          size: 12,
                          color: secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AssessmentQuestionScreen(
                            test: test,
                            isArabic: isArabic,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: test.color,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      isArabic ? 'عرض واجهة الأسئلة' : 'Preview Question Screen',
                      style: _style(
                        context,
                        size: 14,
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    isArabic ? 'العودة للاختبارات' : 'Back to Assessments',
                    style: _style(
                      context,
                      size: 13,
                      weight: FontWeight.w600,
                      color: secondaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AssessmentQuestionScreen extends StatelessWidget {
  final _TestInfo test;
  final bool isArabic;

  const AssessmentQuestionScreen({
    super.key,
    required this.test,
    required this.isArabic,
  });

  TextStyle _style(
      BuildContext context, {
        double size = 14,
        FontWeight weight = FontWeight.normal,
        Color? color,
      }) {
    return (isArabic
        ? GoogleFonts.cairo(
      fontSize: size,
      fontWeight: weight,
      color: color,
    )
        : GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: color,
    ))
        .copyWith(height: 1.6);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background =
    isDark ? const Color(0xFF10121C) : const Color(0xFFF7F8FC);
    final cardColor =
    isDark ? const Color(0xFF1B1E2B) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF20243A);
    final secondaryText =
    isDark ? Colors.white70 : const Color(0xFF747B91);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0,
          title: Text(
            test.title,
            style: _style(
              context,
              size: 16,
              weight: FontWeight.bold,
              color: primaryText,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const LinearProgressIndicator(
                          value: 0,
                          minHeight: 7,
                          backgroundColor: Color(0xFFE2E5EF),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            TestsScreen.nexoraBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isArabic ? 'بانتظار الأسئلة' : 'Awaiting questions',
                      style: _style(
                        context,
                        size: 10,
                        weight: FontWeight.w600,
                        color: secondaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: test.color.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        size: 45,
                        color: test.color,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        isArabic
                            ? 'واجهة السؤال'
                            : 'Question Screen',
                        style: _style(
                          context,
                          size: 20,
                          weight: FontWeight.bold,
                          color: primaryText,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isArabic
                            ? 'سيظهر السؤال المعتمد هنا، وتحته خيارات الإجابة التي سيتم تحميلها من بيانات الاختبار.'
                            : 'The approved question will appear here, followed by answer options loaded from the assessment data.',
                        textAlign: TextAlign.center,
                        style: _style(
                          context,
                          size: 13,
                          color: secondaryText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: test.color.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          isArabic
                              ? 'الأسئلة وخيارات الإجابة قيد التجهيز'
                              : 'Questions and answer options are being prepared',
                          textAlign: TextAlign.center,
                          style: _style(
                            context,
                            size: 12,
                            weight: FontWeight.w600,
                            color: test.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          foregroundColor: secondaryText,
                          side: BorderSide(
                            color: secondaryText.withValues(alpha: 0.35),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          isArabic ? 'السابق' : 'Previous',
                          style: _style(
                            context,
                            size: 13,
                            weight: FontWeight.w600,
                            color: secondaryText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          backgroundColor: test.color,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor:
                          test.color.withValues(alpha: 0.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          isArabic ? 'التالي' : 'Next',
                          style: _style(
                            context,
                            size: 13,
                            weight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}