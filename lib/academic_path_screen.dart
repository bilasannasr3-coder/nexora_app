
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexora_app/grade_entry_screen.dart';

class AcademicPathScreen extends StatelessWidget {
  final bool isDarkMode;
  final GradeEntryResult? gradeEntryResult;

  const AcademicPathScreen({
    super.key,
    required this.isDarkMode,
    this.gradeEntryResult,
  });

  static const Color nexoraBlue = Color(0xFF4A6CF7);
  static const Color nexoraPurple = Color(0xFF7C4DFF);

  static const Color lightBackground = Color(0xFFF7F8FC);
  static const Color darkBackground = Color(0xFF0B0D18);
  static const Color darkCard = Color(0xFF191D30);

  static const Color lightText = Color(0xFF172033);
  static const Color lightSoftText = Color(0xFF6B7280);
  static const Color darkText = Color(0xFFF7F8FF);
  static const Color darkSoftText = Color(0xFFD0D5E5);

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode == 'ar';

    final backgroundColor =
    isDarkMode ? darkBackground : lightBackground;
    final cardColor = isDarkMode ? darkCard : Colors.white;
    final titleColor = isDarkMode ? darkText : lightText;
    final subtitleColor = isDarkMode ? darkSoftText : lightSoftText;

    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: nexoraPurple,
        ),
        textTheme: isArabic
            ? GoogleFonts.cairoTextTheme(Theme.of(context).textTheme)
            : GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      child: Directionality(
        textDirection:
        isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              tooltip: isArabic ? 'رجوع' : 'Back',
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                isArabic
                    ? Icons.arrow_forward_ios_rounded
                    : Icons.arrow_back_ios_new_rounded,
                color: titleColor,
                size: 20,
              ),
            ),
            title: Text(
              isArabic ? 'المسار الأكاديمي' : 'Academic Path',
              style: TextStyle(
                color: titleColor,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroCard(isArabic),
                  const SizedBox(height: 25),
                  Text(
                    isArabic
                        ? 'كيف سيتم تحديد مسارك؟'
                        : 'How will your path be determined?',
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    isArabic
                        ? 'تعتمد التوصية على مجموعة من المعلومات، وليس على المعدل وحده.'
                        : 'Your recommendation will consider several factors, not grades alone.',
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 17),
                  _buildStepCard(
                    number: '01',
                    icon: Icons.school_outlined,
                    title: isArabic
                        ? 'المعدلات الدراسية'
                        : 'School Grades',
                    description: isArabic
                        ? 'معدلات الصفوف السابع والثامن والتاسع.'
                        : 'Your Grade 7, Grade 8 and Grade 9 averages.',
                    isComplete: gradeEntryResult != null,
                    isArabic: isArabic,
                    cardColor: cardColor,
                    titleColor: titleColor,
                    subtitleColor: subtitleColor,
                  ),
                  const SizedBox(height: 12),
                  _buildStepCard(
                    number: '02',
                    icon: Icons.psychology_outlined,
                    title: isArabic
                        ? 'نتائج الاختبارات الثلاثة'
                        : 'Three Assessment Results',
                    description: isArabic
                        ? 'الميول والاهتمامات، الشخصية، والمهارات والقدرات.'
                        : 'Interests, personality, and skills and abilities.',
                    isComplete: false,
                    isArabic: isArabic,
                    cardColor: cardColor,
                    titleColor: titleColor,
                    subtitleColor: subtitleColor,
                  ),
                  const SizedBox(height: 12),
                  _buildStepCard(
                    number: '03',
                    icon: Icons.auto_awesome_outlined,
                    title: isArabic
                        ? 'تحليل البيانات والتوصية'
                        : 'Analysis and Recommendation',
                    description: isArabic
                        ? 'تحليل البيانات معًا لتحديد المسار الأنسب وتوضيح أسباب التوصية.'
                        : 'Analyze the information together and explain the recommended path.',
                    isComplete: false,
                    isArabic: isArabic,
                    cardColor: cardColor,
                    titleColor: titleColor,
                    subtitleColor: subtitleColor,
                  ),
                  const SizedBox(height: 22),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(0xFF202A52)
                          : const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: nexoraBlue.withOpacity(0.18),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: nexoraBlue,
                          size: 23,
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Text(
                            isArabic
                                ? 'لن نعرض مسارًا على أنه توصية نهائية قبل اكتمال ربط المعدلات ونتائج الاختبارات بآلية التحليل.'
                                : 'No path will be presented as a final recommendation until grades and assessment results are connected to the analysis process.',
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 12,
                              height: 1.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 51,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.home_outlined),
                      label: Text(
                        isArabic ? 'العودة إلى الرئيسية' : 'Back to Home',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: nexoraPurple,
                        side: BorderSide(
                          color: nexoraPurple.withOpacity(0.45),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(bool isArabic) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF596FF6),
            Color(0xFF7552E8),
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: nexoraBlue.withOpacity(0.22),
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.route_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 19),
          Text(
            isArabic
                ? 'مستقبلك يبدأ بفهم إمكانياتك'
                : 'Your Future Starts with Understanding Your Potential',
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
                ? 'نعمل على جمع مؤشراتك الدراسية ونتائج اختباراتك لبناء توصية أكاديمية تناسبك.'
                : 'Your academic information and assessment results will help build a recommendation suited to you.',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 17),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.22),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.hourglass_top_rounded,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 7),
                Text(
                  isArabic
                      ? 'التوصية قيد الإعداد'
                      : 'Recommendation in Progress',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard({
    required String number,
    required IconData icon,
    required String title,
    required String description,
    required bool isComplete,
    required bool isArabic,
    required Color cardColor,
    required Color titleColor,
    required Color subtitleColor,
  }) {
    final statusColor = isComplete
        ? const Color(0xFF16A36A)
        : nexoraPurple;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDarkMode
              ? const Color(0xFF343A55)
              : const Color(0xFFEAECF2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.08 : 0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.11),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: statusColor,
              size: 25,
            ),
          ),
          const SizedBox(width: 13),
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
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 12,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Icon(
                      isComplete
                          ? Icons.check_circle_rounded
                          : Icons.schedule_rounded,
                      size: 15,
                      color: statusColor,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        isComplete
                            ? (isArabic
                            ? 'تم إدخال المعدلات'
                            : 'Grades Entered')
                            : (isArabic
                            ? 'بانتظار اكتمال الربط'
                            : 'Integration Pending'),
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            number,
            style: TextStyle(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.15)
                  : const Color(0xFFE4E7F0),
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
