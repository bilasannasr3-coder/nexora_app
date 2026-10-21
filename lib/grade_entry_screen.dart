import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradeEntryScreen extends StatefulWidget {
  const GradeEntryScreen({super.key});

  @override
  State<GradeEntryScreen> createState() => _GradeEntryScreenState();
}

class _GradeEntryScreenState extends State<GradeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _grade7 = TextEditingController();
  final _grade8 = TextEditingController();
  final _grade9 = TextEditingController();
  bool _grade9Completed = false;

  static const _blue = Color(0xFF4A6CF7);
  static const _purple = Color(0xFF7C4DFF);

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';
  String t(String ar, String en) => _ar ? ar : en;

  @override
  void dispose() {
    _grade7.dispose();
    _grade8.dispose();
    _grade9.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return t('هذا الحقل مطلوب', 'This field is required');
    }
    final number = double.tryParse(value.trim().replaceAll(',', '.'));
    if (number == null) return t('أدخل رقمًا صحيحًا', 'Enter a valid number');
    if (number < 0 || number > 100) {
      return t('يجب أن يكون المعدل بين 0 و100.', 'The average must be between 0 and 100.');
    }
    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      GradeEntryResult(
        grade7AnnualAverage: _number(_grade7),
        grade8AnnualAverage: _number(_grade8),
        grade9Average: _number(_grade9),
        grade9AverageType: _grade9Completed
            ? Grade9AverageType.annual
            : Grade9AverageType.firstSemester,
      ),
    );
  }

  double _number(TextEditingController controller) =>
      double.parse(controller.text.trim().replaceAll(',', '.'));

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final bg = dark ? const Color(0xFF10121C) : const Color(0xFFF7F8FC);
    final card = dark ? const Color(0xFF1B1E2B) : Colors.white;
    final text = dark ? Colors.white : const Color(0xFF20243A);
    final muted = dark ? const Color(0xFFB7BBD0) : const Color(0xFF737991);
    final font = _ar ? 'Cairo' : 'Poppins';

    return Directionality(
      textDirection: _ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: bg,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(_ar ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
                color: text),
          ),
          title: Text(t('المعدلات الدراسية', 'Academic Averages'),
              style: GoogleFonts.getFont(font, color: text,
                  fontSize: 18, fontWeight: FontWeight.w700)),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_blue, _purple],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(children: [
                    const Icon(Icons.school_rounded, color: Colors.white, size: 38),
                    const SizedBox(width: 14),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t('أدخل معدلاتك الدراسية', 'Enter Your Academic Averages'),
                            style: GoogleFonts.getFont(font, color: Colors.white,
                                fontWeight: FontWeight.w700, fontSize: 16)),
                        const SizedBox(height: 5),
                        Text(t(
                          'أدخل المعدل السنوي النهائي للصفين السابع والثامن، ثم اختر نوع المعدل المناسب للصف التاسع وأدخله.',
                          'Enter the final annual averages for Grades 7 and 8, then select and enter the appropriate Grade 9 average.',
                        ), style: GoogleFonts.getFont(font, color: Colors.white,
                            fontSize: 12, height: 1.6)),
                      ],
                    )),
                  ]),
                ),
                const SizedBox(height: 20),
                _averageField('معدل الصف السابع', 'Grade 7 average',
                    'المعدل السنوي النهائي', 'Final annual average',
                    _grade7, card, text, muted, font, Icons.looks_one_rounded),
                const SizedBox(height: 14),
                _averageField('معدل الصف الثامن', 'Grade 8 average',
                    'المعدل السنوي النهائي', 'Final annual average',
                    _grade8, card, text, muted, font, Icons.looks_two_rounded),
                const SizedBox(height: 22),
                Text(t('وضعك الدراسي في الصف التاسع', 'Your Grade 9 status'),
                    style: GoogleFonts.getFont(font, color: text,
                        fontSize: 15, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                _statusOption(
                  title: t('ما زلت أدرس في الصف التاسع', 'I am currently in Grade 9'),
                  subtitle: t('أدخل معدل الفصل الدراسي الأول', 'Enter the first-semester average'),
                  value: false, card: card, text: text, muted: muted, font: font,
                ),
                const SizedBox(height: 10),
                _statusOption(
                  title: t('أنهيت الصف التاسع', 'I have completed Grade 9'),
                  subtitle: t('أدخل المعدل السنوي النهائي', 'Enter the final annual average'),
                  value: true, card: card, text: text, muted: muted, font: font,
                ),
                const SizedBox(height: 14),
                _averageField(
                  _grade9Completed ? 'معدل الصف التاسع' : 'معدل الفصل الأول للصف التاسع',
                  _grade9Completed ? 'Grade 9 average' : 'Grade 9 first-semester average',
                  _grade9Completed ? 'المعدل السنوي النهائي' :  'معدل الفصل الدراسي الأول',
                  _grade9Completed ? 'Final annual average' :  'First-semester average',
                  _grade9, card, text, muted, font, Icons.looks_3_rounded,
                ),
                const SizedBox(height: 10),
                Text(t(
                  'يرجى إدخال المعدلات كنسب مئوية من 100. ستُستخدم هذه البيانات لاحقًا إلى جانب نتائج الاختبارات لدعم تحليل المسار الأكاديمي.',
                  'Enter each average as a percentage out of 100. These data will later be considered alongside your assessment results to support academic-path analysis.',
                ), style: GoogleFonts.getFont(font, color: muted, fontSize: 12, height: 1.6)),
                const SizedBox(height: 24),
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _blue, foregroundColor: Colors.white,
                      elevation: 0, shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(t('متابعة', 'Continue'),
                          style: GoogleFonts.getFont(font, fontSize: 15,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      Icon(_ar ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _averageField(
      String arTitle, String enTitle, String arSubtitle, String enSubtitle,
      TextEditingController controller, Color card, Color text, Color muted,
      String font, IconData icon,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card, borderRadius: BorderRadius.circular(18),
        border: Border.all(color: text.withValues(alpha: 0.08)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(color: _blue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(13)),
            child: Icon(icon, color: _blue, size: 23),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t(arTitle, enTitle), style: GoogleFonts.getFont(font, color: text,
                fontSize: 14, fontWeight: FontWeight.w700)),
            Text(t(arSubtitle, enSubtitle),
                style: GoogleFonts.getFont(font, color: muted, fontSize: 11)),
          ])),
        ]),
        const SizedBox(height: 14),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textDirection: TextDirection.ltr,
          validator: _validate,
          style: GoogleFonts.getFont('Poppins', color: text, fontSize: 15),
          decoration: InputDecoration(
            hintText: t('أدخل المعدل', 'Enter average'), suffixText: '%',
            filled: true,
            fillColor: text.withValues(alpha: 0.035),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: text.withValues(alpha: 0.08))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13),
                borderSide: const BorderSide(color: _blue, width: 1.5)),
            errorMaxLines: 2,
          ),
        ),
      ]),
    );
  }

  Widget _statusOption({
    required String title, required String subtitle, required bool value,
    required Color card, required Color text, required Color muted, required String font,
  }) {
    final selected = _grade9Completed == value;
    return InkWell(
      onTap: () => setState(() => _grade9Completed = value),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selected ? _blue.withValues(alpha: 0.08) : card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? _blue : text.withValues(alpha: 0.08),
              width: selected ? 1.5 : 1),
        ),
        child: Row(children: [
          Icon(selected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              color: selected ? _blue : muted, size: 23),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: GoogleFonts.getFont(font, color: text,
                fontSize: 13, fontWeight: FontWeight.w700)),
            const SizedBox(height: 3),
            Text(subtitle, style: GoogleFonts.getFont(font, color: muted, fontSize: 11)),
          ])),
        ]),
      ),
    );
  }
}

enum Grade9AverageType { firstSemester, annual }

class GradeEntryResult {
  final double grade7AnnualAverage;
  final double grade8AnnualAverage;
  final double grade9Average;
  final Grade9AverageType grade9AverageType;

  const GradeEntryResult({
    required this.grade7AnnualAverage,
    required this.grade8AnnualAverage,
    required this.grade9Average,
    required this.grade9AverageType,
  });

  Map<String, dynamic> toJson() => {
    'grade7AnnualAverage': grade7AnnualAverage,
    'grade8AnnualAverage': grade8AnnualAverage,
    'grade9Average': grade9Average,
    'grade9AverageType':
    grade9AverageType == Grade9AverageType.annual ? 'annual' : 'first_semester',
  };
}

