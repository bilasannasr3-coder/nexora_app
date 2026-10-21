
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'grade_entry_screen.dart';

class ResultsScreen extends StatelessWidget {
  final bool isDarkMode;
  final GradeEntryResult? gradeEntryResult;

  const ResultsScreen({
    super.key,
    this.isDarkMode = false,
    this.gradeEntryResult,
  });

  static const Color _blue = Color(0xFF4A6CF7);
  static const Color _purple = Color(0xFF7C4DFF);
  static const Color _lightText = Color(0xFF172033);
  static const Color _softText = Color(0xFF6B7280);
  static const Color _darkText = Color(0xFFF7F8FF);
  static const Color _darkSoft = Color(0xFFD0D5E5);

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode == 'ar';

    final background = isDarkMode
        ? const Color(0xFF0B0D18)
        : const Color(0xFFF7F8FC);
    final card = isDarkMode
        ? const Color(0xFF191D30)
        : Colors.white;
    final titleColor = isDarkMode ? _darkText : _lightText;
    final mutedColor = isDarkMode ? _darkSoft : _softText;
    final borderColor = isDarkMode
        ? const Color(0xFF343A55)
        : const Color(0xFFE7E9F2);

    final fontTheme = isArabic
        ? GoogleFonts.cairoTextTheme(
      Theme.of(context).textTheme,
    )
        : GoogleFonts.poppinsTextTheme(
      Theme.of(context).textTheme,
    );

    return Theme(
      data: Theme.of(context).copyWith(textTheme: fontTheme),
      child: Container(
        color: background,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? 'نتائج رحلتك' : 'Your Journey Results',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isArabic
                      ? 'راجع معدلاتك وتعرّف على العوامل التي ستدعم توجيهك الأكاديمي.'
                      : 'Review your grades and the factors that will support your academic guidance.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    color: mutedColor,
                  ),
                ),
                const SizedBox(height: 20),

                _recommendationCard(isArabic),

                const SizedBox(height: 18),

                _gradesCard(
                  isArabic: isArabic,
                  card: card,
                  titleColor: titleColor,
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                ),

                const SizedBox(height: 24),

                Text(
                  isArabic
                      ? 'العوامل التي ستُبنى عليها التوصية'
                      : 'What Shapes Your Recommendation',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 12),

                _assessmentCard(
                  icon: Icons.favorite_rounded,
                  iconColor: const Color(0xFFEC4899),
                  tint: const Color(0xFFFFEEF7),
                  title: isArabic ? 'الميول والاهتمامات' : 'Interests',
                  description: isArabic
                      ? 'تساعد على تحديد المجالات والأنشطة التي تجذب الطالب.'
                      : 'Helps identify fields and activities that interest the student.',
                  isArabic: isArabic,
                  card: card,
                  titleColor: titleColor,
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                ),
                const SizedBox(height: 11),

                _assessmentCard(
                  icon: Icons.person_search_rounded,
                  iconColor: _purple,
                  tint: const Color(0xFFF0E9FF),
                  title: isArabic ? 'الشخصية' : 'Personality',
                  description: isArabic
                      ? 'تساعد على فهم السمات والتفضيلات المرتبطة بالتعلّم والعمل.'
                      : 'Helps understand traits and preferences related to learning and work.',
                  isArabic: isArabic,
                  card: card,
                  titleColor: titleColor,
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                ),
                const SizedBox(height: 11),

                _assessmentCard(
                  icon: Icons.psychology_alt_rounded,
                  iconColor: _blue,
                  tint: const Color(0xFFEEF2FF),
                  title: isArabic ? 'المهارات والقدرات' : 'Skills & Abilities',
                  description: isArabic
                      ? 'تساعد على استكشاف جوانب القوة في التفكير وحل المشكلات.'
                      : 'Helps explore strengths in thinking and problem-solving.',
                  isArabic: isArabic,
                  card: card,
                  titleColor: titleColor,
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                ),

                const SizedBox(height: 20),

                _infoBanner(
                  isArabic: isArabic,
                  titleColor: titleColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _recommendationCard(bool isArabic) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3F62E9),
            Color(0xFF7350E8),
            Color(0xFF9B4FC7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: _purple.withOpacity(0.20),
            blurRadius: 24,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.17),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.explore_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  isArabic
                      ? 'مسارك الأكاديمي المقترح'
                      : 'Your Suggested Academic Path',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            isArabic
                ? 'رحلتك الأكاديمية قيد الإعداد'
                : 'Your academic recommendation is in progress',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              height: 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            isArabic
                ? 'ستظهر هنا توصية موحّدة بعد تحليل معدلاتك ونتائج اختبارات الميول والشخصية والمهارات.'
                : 'A combined recommendation will appear here after your grades and interests, personality, and skills assessments are analyzed.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.90),
              fontSize: 12,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 17),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.hourglass_top_rounded,
                  color: Colors.white,
                  size: 17,
                ),
                const SizedBox(width: 7),
                Flexible(
                  child: Text(
                    isArabic
                        ? 'بانتظار اكتمال النتائج والتحليل'
                        : 'Awaiting assessment results and analysis',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _gradesCard({
    required bool isArabic,
    required Color card,
    required Color titleColor,
    required Color mutedColor,
    required Color borderColor,
  }) {
    final result = gradeEntryResult;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF173E3D)
                      : const Color(0xFFEAFBF9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: Color(0xFF0EA5A4),
                  size: 23,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  isArabic ? 'المعدلات الدراسية' : 'School Grades',
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (result != null)
                const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF0EA5A4),
                  size: 21,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            result == null
                ? (isArabic
                ? 'لم تُدخل المعدلات بعد. يمكنك إدخالها من الصفحة الرئيسية.'
                : 'No grades entered yet. You can add them from the home screen.')
                : (isArabic
                ? 'المعدلات التي أدخلتها في ملفك الأكاديمي.'
                : 'The grades entered in your academic profile.'),
            style: TextStyle(
              color: mutedColor,
              fontSize: 12,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          if (result == null)
            _emptyGradesState(isArabic, mutedColor)
          else ...[
            _gradeRow(
              label: isArabic ? 'الصف السابع — المعدل السنوي' : 'Grade 7 — Annual Average',
              value: result.grade7AnnualAverage,
              titleColor: titleColor,
              mutedColor: mutedColor,
              borderColor: borderColor,
            ),
            const SizedBox(height: 10),
            _gradeRow(
              label: isArabic ? 'الصف الثامن — المعدل السنوي' : 'Grade 8 — Annual Average',
              value: result.grade8AnnualAverage,
              titleColor: titleColor,
              mutedColor: mutedColor,
              borderColor: borderColor,
            ),
            const SizedBox(height: 10),
            _gradeRow(
              label: result.grade9AverageType == Grade9AverageType.annual
                  ? (isArabic
                  ? 'الصف التاسع — المعدل السنوي'
                  : 'Grade 9 — Annual Average')
                  : (isArabic
                  ? 'الصف التاسع — معدل الفصل الأول'
                  : 'Grade 9 — First-Semester Average'),
              value: result.grade9Average,
              titleColor: titleColor,
              mutedColor: mutedColor,
              borderColor: borderColor,
            ),
          ],
        ],
      ),
    );
  }

  Widget _gradeRow({
    required String label,
    required double value,
    required Color titleColor,
    required Color mutedColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: mutedColor,
                fontSize: 11,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${_formatAverage(value)}%',
            style: TextStyle(
              color: titleColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyGradesState(bool isArabic, Color mutedColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(0xFF202438)
            : const Color(0xFFF5F6FB),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: mutedColor,
            size: 21,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              isArabic
                  ? 'ستظهر معدلاتك هنا بعد إدخالها.'
                  : 'Your grades will appear here after you enter them.',
              style: TextStyle(
                color: mutedColor,
                fontSize: 12,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAverage(double value) {
    return value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(2).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  }

  Widget _assessmentCard({
    required IconData icon,
    required Color iconColor,
    required Color tint,
    required String title,
    required String description,
    required bool isArabic,
    required Color card,
    required Color titleColor,
    required Color mutedColor,
    required Color borderColor,
  }) {
    final iconBackground = isDarkMode
        ? Color.lerp(tint, const Color(0xFF191D30), 0.72)!
        : tint;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: mutedColor,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.sync_rounded,
                      color: Color(0xFF9A7AE8),
                      size: 14,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        isArabic
                            ? 'سيظهر ملخص النتيجة بعد الربط'
                            : 'Result summary available after integration',
                        style: const TextStyle(
                          color: Color(0xFF9A7AE8),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBanner({
    required bool isArabic,
    required Color titleColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(0xFF172B2B)
            : const Color(0xFFEAFBF9),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline_rounded,
            color: Color(0xFF0EA5A4),
            size: 23,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isArabic
                  ? 'التوصية الأكاديمية أداة إرشادية تساعدك على اتخاذ قرار واعٍ، وليست حكمًا نهائيًا على مستقبلك أو قدراتك.'
                  : 'The academic recommendation is guidance to support an informed decision, not a final judgment about your future or abilities.',
              style: TextStyle(
                color: titleColor,
                fontSize: 12,
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
