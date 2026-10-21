import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexora_app/grade_entry_screen.dart';

class AccountScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback? onToggleTheme;
  final VoidCallback? onToggleLanguage;
  final VoidCallback onOpenGrades;
  final GradeEntryResult? gradeEntryResult;
  final String? profileImagePath;
  final ValueChanged<String?> onProfileImageChanged;

  const AccountScreen({
    super.key,
    required this.isDarkMode,
    required this.onOpenGrades,
    required this.onProfileImageChanged,
    this.onToggleTheme,
    this.onToggleLanguage,
    this.gradeEntryResult,
    this.profileImagePath,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  static const Color _blue = Color(0xFF4A6CF7);
  static const Color _purple = Color(0xFF7C4DFF);
  final ImagePicker _imagePicker = ImagePicker();
  bool _isPickingImage = false;

  bool get _isArabic =>
      Localizations.localeOf(context).languageCode == 'ar';

  Color get _background => widget.isDarkMode
      ? const Color(0xFF0B0D18)
      : const Color(0xFFF7F8FC);
  Color get _card => widget.isDarkMode
      ? const Color(0xFF191D30)
      : Colors.white;
  Color get _text => widget.isDarkMode
      ? const Color(0xFFF7F8FF)
      : const Color(0xFF172033);
  Color get _softText => widget.isDarkMode
      ? const Color(0xFFD0D5E5)
      : const Color(0xFF6B7280);
  Color get _border => widget.isDarkMode
      ? const Color(0xFF343A55)
      : const Color(0xFFEAECF2);

  Future<void> _showImageOptions() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: _card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _softText.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  _isArabic ? 'تغيير الصورة الشخصية' : 'Change profile photo',
                  style: TextStyle(
                    color: _text,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined, color: _blue),
                  title: Text(_isArabic ? 'اختيار من المعرض' : 'Choose from gallery',
                      style: TextStyle(color: _text)),
                  onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined, color: _purple),
                  title: Text(_isArabic ? 'التقاط صورة بالكاميرا' : 'Take a photo',
                      style: TextStyle(color: _text)),
                  onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
                ),
                if (widget.profileImagePath != null)
                  ListTile(
                    leading: Icon(Icons.delete_outline, color: Colors.red.shade400),
                    title: Text(_isArabic ? 'إزالة الصورة' : 'Remove photo',
                        style: TextStyle(color: _text)),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      widget.onProfileImageChanged(null);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null || !mounted || _isPickingImage) return;
    setState(() => _isPickingImage = true);
    try {
      final XFile? picked = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
      );
      if (!mounted || picked == null) return;
      widget.onProfileImageChanged(picked.path);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isArabic
              ? 'تعذّر فتح الصورة. تحقّق من صلاحيات الكاميرا أو المعرض.'
              : 'Could not open the image. Check camera or gallery permissions.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isPickingImage = false);
    }
  }

  String _formatAverage(double value) => value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic;
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: isArabic
            ? GoogleFonts.cairoTextTheme(Theme.of(context).textTheme)
            : GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: Theme.of(context).colorScheme.copyWith(primary: _purple),
      ),
      child: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          color: _background,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isArabic ? 'حسابي' : 'My Account',
                    style: TextStyle(color: _text, fontSize: 26, fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                Text(isArabic ? 'مساحتك الشخصية في NEXORA' : 'Your personal space in NEXORA',
                    style: TextStyle(color: _softText, fontSize: 13)),
                const SizedBox(height: 20),
                _buildProfileCard(isArabic),
                const SizedBox(height: 22),
                _sectionTitle(isArabic ? 'رحلتك الأكاديمية' : 'Your Academic Journey',
                    isArabic ? 'بياناتك ومتابعة تقدّمك' : 'Your information and progress'),
                const SizedBox(height: 12),
                _buildAcademicCard(isArabic),
                const SizedBox(height: 22),
                _sectionTitle(isArabic ? 'عن NEXORA' : 'About NEXORA',
                    isArabic ? 'مستقبلك مش لازم يكون حيرة!' : 'Your future does not have to feel confusing.'),
                const SizedBox(height: 12),
                _buildAboutCard(isArabic),
                const SizedBox(height: 22),
                _sectionTitle(isArabic ? 'إعدادات التطبيق' : 'App Settings',
                    isArabic ? 'خصص التطبيق بالطريقة اللي بتناسبك' : 'Make the app work the way you prefer'),
                const SizedBox(height: 12),
                _buildSettingsCard(isArabic),
                const SizedBox(height: 18),
                Center(
                  child: Column(
                    children: [
                      Text('NEXORA', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 2).copyWith(color: _purple)),
                      const SizedBox(height: 4),
                      Text(isArabic ? 'ربط إمكانياتك بمستقبلك' : 'Connecting Your Potential to Your Future',
                          textAlign: TextAlign.center, style: TextStyle(color: _softText, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(bool isArabic) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF263A9B), Color(0xFF4A4FC4), Color(0xFF693FAD)],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: _purple.withOpacity(0.18), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _isPickingImage ? null : _showImageOptions,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.16),
                    border: Border.all(color: Colors.white.withOpacity(0.85), width: 2),
                    image: widget.profileImagePath == null
                        ? null
                        : DecorationImage(
                      image: FileImage(File(widget.profileImagePath!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: widget.profileImagePath == null
                      ? const Icon(Icons.person_rounded, size: 43, color: Colors.white)
                      : null,
                ),
                Positioned(
                  bottom: -1,
                  right: -1,
                  child: Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,
                        border: Border.all(color: _purple.withOpacity(0.2))),
                    child: _isPickingImage
                        ? const Padding(padding: EdgeInsets.all(6), child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.camera_alt_rounded, size: 15, color: _purple),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isArabic ? 'أهلًا فيك!' : 'Welcome!', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                Text(isArabic ? 'خلّينا نكتشف المسار الأنسب إلك.' : 'Let’s explore a path that may suit you.',
                    style: TextStyle(color: Colors.white.withOpacity(0.88), fontSize: 12, height: 1.45)),
                const SizedBox(height: 7),
                InkWell(
                  onTap: _showImageOptions,
                  child: Text(isArabic ? 'إضافة صورة شخصية' : 'Add a profile photo',
                      style: const TextStyle(color: Color(0xFFE2E7FF), fontSize: 11, fontWeight: FontWeight.w700, decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: _text, fontSize: 19, fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        Text(subtitle, style: TextStyle(color: _softText, fontSize: 12, height: 1.4)),
      ],
    );
  }

  Widget _buildAcademicCard(bool isArabic) {
    final result = widget.gradeEntryResult;
    final grade9Label = result == null
        ? ''
        : (result.grade9AverageType == Grade9AverageType.firstSemester
        ? (isArabic ? 'التاسع فصل أول' : 'Grade 9 semester 1')
        : (isArabic ? 'التاسع سنوي' : 'Grade 9 annual'));
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(22), border: Border.all(color: _border)),
      child: Column(
        children: [
          _academicRow(Icons.school_outlined, isArabic ? 'المعدلات الدراسية' : 'School averages',
              result == null
                  ? (isArabic ? 'لم تتم إضافة المعدلات بعد' : 'Averages have not been added yet')
                  : (isArabic
                  ? 'السابع ${_formatAverage(result.grade7AnnualAverage)}%  •  الثامن ${_formatAverage(result.grade8AnnualAverage)}%  •  $grade9Label ${_formatAverage(result.grade9Average)}%'
                  : 'Grade 7 ${_formatAverage(result.grade7AnnualAverage)}%  •  Grade 8 ${_formatAverage(result.grade8AnnualAverage)}%  •  $grade9Label ${_formatAverage(result.grade9Average)}%'),
              _blue),
          _divider(),
          _academicRow(Icons.assignment_outlined, isArabic ? 'اختبار الميول والاهتمامات' : 'Interests assessment',
              isArabic ? 'تظهر النتيجة بعد إكمال الاختبار وربطه بالنظام' : 'Result appears after completion and integration', _purple),
          _divider(),
          _academicRow(Icons.psychology_outlined, isArabic ? 'اختبار الشخصية' : 'Personality assessment',
              isArabic ? 'تظهر النتيجة بعد إكمال الاختبار وربطه بالنظام' : 'Result appears after completion and integration', const Color(0xFF0EA5A4)),
          _divider(),
          _academicRow(Icons.lightbulb_outline_rounded, isArabic ? 'اختبار المهارات والقدرات' : 'Skills and abilities assessment',
              isArabic ? 'تظهر النتيجة بعد إكمال الاختبار وربطه بالنظام' : 'Result appears after completion and integration', const Color(0xFFEC4899)),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 47,
            child: OutlinedButton.icon(
              onPressed: widget.onOpenGrades,
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: Text(isArabic ? (result == null ? 'إضافة المعدلات الدراسية' : 'تعديل المعدلات الدراسية') : (result == null ? 'Add school averages' : 'Edit school averages')),
              style: OutlinedButton.styleFrom(foregroundColor: _purple, side: BorderSide(color: _purple.withOpacity(0.5)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _academicRow(IconData icon, String title, String subtitle, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 42, height: 42, decoration: BoxDecoration(color: iconColor.withOpacity(widget.isDarkMode ? 0.18 : 0.10), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: iconColor, size: 22)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(color: _text, fontSize: 13, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: _softText, fontSize: 11, height: 1.45)),
        ])),
      ],
    );
  }

  Widget _divider() => Padding(padding: const EdgeInsets.symmetric(vertical: 13), child: Divider(height: 1, color: _border));

  Widget _buildAboutCard(bool isArabic) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(22), border: Border.all(color: _border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 48, height: 48, decoration: BoxDecoration(gradient: const LinearGradient(colors: [_blue, _purple]), borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.explore_rounded, color: Colors.white, size: 27)),
        const SizedBox(height: 14),
        Text(isArabic ? 'مش عارف أي مسار دراسي بناسبك؟ خلّينا نكتشفه مع بعض.' : 'Not sure which study path suits you? Let’s explore it together.',
            style: TextStyle(color: _text, fontSize: 17, height: 1.5, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        Text(isArabic
            ? 'اختيار المسار الدراسي ممكن يحيّرك. يمكن تكون بتحب مواد معيّنة أو عندك اهتمامات وقدرات، بس مش عارف كيف تربطها بمستقبلك. وأحيانًا بتكون محتار بين أكثر من خيار ومش عارف من وين تبدأ.'
            : 'Choosing a study path can feel confusing. You may enjoy certain subjects or have interests and abilities, but still be unsure how they connect to your future. You might also be choosing between several options without knowing where to start.',
            style: TextStyle(color: _softText, fontSize: 12, height: 1.7)),
        const SizedBox(height: 14),
        Text(isArabic ? 'هون بيجي دور NEXORA!' : 'That is where NEXORA comes in!', style: const TextStyle(color: _purple, fontSize: 15, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        Text(isArabic
            ? 'NEXORA تطبيق بيساعدك تتعرّف على نفسك بشكل أفضل، وتفهم خياراتك الأكاديمية من خلال جمع معدلاتك الدراسية مع نتائج اختبارات الميول والاهتمامات، والشخصية، والمهارات والقدرات.'
            : 'NEXORA helps you understand yourself and your academic options by considering your school averages together with your interests, personality, skills, and abilities assessment results.',
            style: TextStyle(color: _softText, fontSize: 12, height: 1.7)),
        const SizedBox(height: 17),
        _aboutStep(1, Icons.bar_chart_rounded, isArabic ? 'بنبدأ من مستواك الدراسي' : 'We start with your school performance',
            isArabic ? 'بتدخل معدلاتك الدراسية حتى تكون جزءًا من الصورة.' : 'Your school averages form one part of the overall picture.', _blue),
        _aboutStep(2, Icons.psychology_alt_rounded, isArabic ? 'بنكتشف جوانبك المختلفة' : 'We explore different sides of you',
            isArabic ? 'بتكمل اختبارات الميول والشخصية والمهارات والقدرات.' : 'You complete assessments about interests, personality, skills, and abilities.', _purple),
        _aboutStep(3, Icons.route_rounded, isArabic ? 'بتصير الصورة أوضح' : 'Your options become clearer',
            isArabic ? 'بعد ربط البيانات وتحليلها، الهدف تقديم توصية بمسار أكاديمي مناسب إلك مع شرح أسبابها.' : 'Once your data is connected and analyzed, the goal is to recommend a suitable academic path and explain why.', const Color(0xFF0EA5A4)),
        const SizedBox(height: 13),
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(color: _purple.withOpacity(widget.isDarkMode ? 0.15 : 0.07), borderRadius: BorderRadius.circular(15)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.favorite_outline_rounded, color: _purple, size: 21),
            const SizedBox(width: 9),
            Expanded(child: Text(isArabic
                ? 'NEXORA مش رح يقرر عنك؛ رح يساعدك تفهم نفسك وخياراتك بشكل أفضل، عشان يكون قرارك مبنيًا على معلومات أوضح.'
                : 'NEXORA will not make the decision for you. It helps you understand yourself and your options so you can make a more informed choice.',
                style: TextStyle(color: _text, fontSize: 11, height: 1.6, fontWeight: FontWeight.w600))),
          ]),
        ),
      ]),
    );
  }

  Widget _aboutStep(int number, IconData icon, String title, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 38, height: 38, decoration: BoxDecoration(color: color.withOpacity(widget.isDarkMode ? 0.18 : 0.10), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 21)),
        const SizedBox(width: 11),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$number. $title', style: TextStyle(color: _text, fontSize: 13, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(description, style: TextStyle(color: _softText, fontSize: 11, height: 1.6)),
        ])),
      ]),
    );
  }

  Widget _buildSettingsCard(bool isArabic) {
    return Container(
      decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(22), border: Border.all(color: _border)),
      child: Column(children: [
        _settingsTile(
          icon: Icons.language_rounded,
          title: isArabic ? 'اللغة' : 'Language',
          subtitle: isArabic ? 'العربية / English' : 'English / العربية',
          trailing: isArabic ? 'English' : 'العربية',
          onTap: widget.onToggleLanguage,
        ),
        Divider(height: 1, indent: 60, endIndent: 16, color: _border),
        _settingsTile(
          icon: widget.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          title: isArabic ? 'مظهر التطبيق' : 'App appearance',
          subtitle: isArabic ? 'اختيار الوضع الفاتح أو الداكن' : 'Choose light or dark mode',
          trailing: widget.isDarkMode ? (isArabic ? 'داكن' : 'Dark') : (isArabic ? 'فاتح' : 'Light'),
          onTap: widget.onToggleTheme,
        ),
      ]),
    );
  }

  Widget _settingsTile({required IconData icon, required String title, required String subtitle, required String trailing, required VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: _purple.withOpacity(widget.isDarkMode ? 0.17 : 0.09), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: _purple, size: 21)),
      title: Text(title, style: TextStyle(color: _text, fontSize: 13, fontWeight: FontWeight.w800)),
      subtitle: Padding(padding: const EdgeInsets.only(top: 4), child: Text(subtitle, style: TextStyle(color: _softText, fontSize: 11))),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        if (trailing.isNotEmpty) Text(trailing, style: const TextStyle(color: _purple, fontSize: 11, fontWeight: FontWeight.w800)),
        const SizedBox(width: 4),
        Icon(_isArabic ? Icons.chevron_left_rounded : Icons.chevron_right_rounded, color: _softText),
      ]),
      onTap: onTap,
    );
  }

}
