import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final bool isDarkMode;
  final bool isArabic;
  final VoidCallback? onOpenResults;
  final VoidCallback? onOpenTests;
  final VoidCallback? onOpenGrades;
  final VoidCallback? onOpenAcademicPath;

  const DashboardScreen({
    super.key,
    required this.isDarkMode,
    this.isArabic = true,
    this.onOpenResults,
    this.onOpenTests,
    this.onOpenGrades,
    this.onOpenAcademicPath,
  });

  @override
  Widget build(BuildContext context) {
    final ar = isArabic;
    final background = isDarkMode ? const Color(0xFF0B0D18) : const Color(0xFFF7F8FC);
    final card = isDarkMode ? const Color(0xFF191D30) : Colors.white;
    final text = isDarkMode ? const Color(0xFFF7F8FF) : const Color(0xFF172033);
    final muted = isDarkMode ? const Color(0xFFD0D5E5) : const Color(0xFF6B7280);
    const blue = Color(0xFF4A6CF7);
    const purple = Color(0xFF7C4DFF);

    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        color: background,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
          children: [
            Text(ar ? 'سجل رحلتك' : 'Journey History',
                style: TextStyle(color: text, fontSize: 26, fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            Text(
              ar ? 'راجع محاولاتك السابقة وتابع تطوّرك مع الوقت.'
                  : 'Review your past attempts and track your progress over time.',
              style: TextStyle(color: muted, fontSize: 13, height: 1.6),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [blue, purple],
                    begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(ar ? 'تقدّمك محفوظ هنا' : 'Your progress belongs here',
                      style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Text(
                    ar ? 'ستجد هنا سجل محاولاتك وتوصياتك السابقة عند تفعيل حفظ البيانات.'
                        : 'Your assessment attempts and past recommendations will appear here once history saving is connected.',
                    style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.6),
                  ),
                ])),
                const SizedBox(width: 12),
                const Icon(Icons.history_rounded, color: Colors.white, size: 40),
              ]),
            ),
            const SizedBox(height: 25),
            _sectionTitle(ar ? 'سجل المحاولات' : 'Attempt history', text),
            const SizedBox(height: 11),
            _emptyPanel(
              icon: Icons.assignment_turned_in_outlined,
              title: ar ? 'لا توجد محاولات محفوظة' : 'No saved attempts yet',
              description: ar
                  ? 'بعد إكمال الاختبارات وتفعيل حفظ النتائج، ستظهر محاولاتك هنا مع تاريخ كل محاولة.'
                  : 'After assessments are completed and result saving is connected, each attempt and its date will appear here.',
              card: card, text: text, muted: muted,
            ),
            const SizedBox(height: 22),
            _sectionTitle(ar ? 'تغيّر النتائج عبر الوقت' : 'Progress over time', text),
            const SizedBox(height: 11),
            _emptyPanel(
              icon: Icons.trending_up_rounded,
              title: ar ? 'المقارنة غير متاحة بعد' : 'Comparison is not available yet',
              description: ar
                  ? 'ستتمكن من مقارنة محاولاتك عندما تتوفر نتائج محفوظة من أكثر من مرة.'
                  : 'You will be able to compare attempts when results from more than one session have been saved.',
              card: card, text: text, muted: muted,
            ),
            const SizedBox(height: 22),
            _sectionTitle(ar ? 'سجل التوصيات' : 'Recommendation history', text),
            const SizedBox(height: 11),
            _emptyPanel(
              icon: Icons.route_outlined,
              title: ar ? 'لا توجد توصيات محفوظة بعد' : 'No saved recommendations yet',
              description: ar
                  ? 'عند ربط نظام التوصية وحفظ نتائجه، ستتمكن من الرجوع إلى توصياتك السابقة وتفسيراتها.'
                  : 'Once the recommendation system is connected and its results are saved, you can revisit previous recommendations and their explanations.',
              card: card, text: text, muted: muted,
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: muted.withOpacity(0.16)),
              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(Icons.info_outline_rounded, color: blue, size: 24),
                const SizedBox(width: 12),
                Expanded(child: Text(
                  ar
                      ? 'ملاحظة: هذه الصفحة تعرض السجل والتغيّرات فقط. لا تُنشأ نتائج سابقة تلقائيًا؛ ستظهر البيانات بعد ربط الحفظ الفعلي.'
                      : 'Note: This page is for history and changes only. Past results are not generated automatically; they will appear after persistent data saving is connected.',
                  style: TextStyle(color: muted, fontSize: 12, height: 1.6),
                )),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, Color textColor) {
    return Text(title, style: TextStyle(color: textColor, fontSize: 17, fontWeight: FontWeight.w900));
  }

  Widget _emptyPanel({
    required IconData icon,
    required String title,
    required String description,
    required Color card,
    required Color text,
    required Color muted,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: muted.withOpacity(0.14)),
      ),
      child: Column(children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(color: muted.withOpacity(0.09), borderRadius: BorderRadius.circular(18)),
          child: Icon(icon, color: muted, size: 29),
        ),
        const SizedBox(height: 13),
        Text(title, textAlign: TextAlign.center,
            style: TextStyle(color: text, fontSize: 15, fontWeight: FontWeight.w800)),
        const SizedBox(height: 7),
        Text(description, textAlign: TextAlign.center,
            style: TextStyle(color: muted, fontSize: 12, height: 1.65)),
      ]),
    );
  }
}
