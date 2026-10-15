
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexora_app/login_screen.dart';
import 'package:nexora_app/register_screen.dart';
import 'package:nexora_app/l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
final void Function(Locale locale) onLanguageChanged;

const WelcomeScreen({
super.key,
required this.onLanguageChanged,
});

@override
Widget build(BuildContext context) {
final local = AppLocalizations.of(context);

final isArabic =
Localizations.localeOf(context).languageCode == 'ar';

final baseTextTheme = Theme.of(context).textTheme;

final textTheme = isArabic
? GoogleFonts.cairoTextTheme(baseTextTheme)
    : GoogleFonts.poppinsTextTheme(baseTextTheme);

TextStyle appTextStyle({
required double fontSize,
required FontWeight fontWeight,
required Color color,
double height = 1.4,
double letterSpacing = 0,
}) {
return (isArabic
? GoogleFonts.cairo()
    : GoogleFonts.poppins())
    .copyWith(
fontSize: fontSize,
fontWeight: fontWeight,
color: color,
height: height,
letterSpacing: letterSpacing,
);
}

return Theme(
data: Theme.of(context).copyWith(
textTheme: textTheme,
),
child: Directionality(
textDirection:
isArabic ? TextDirection.rtl : TextDirection.ltr,
child: Scaffold(
backgroundColor: const Color(0xFF02030A),
body: SafeArea(
child: Stack(
children: [
// TOP GLOW

Positioned(
top: -120,
right: -100,
child: Container(
width: 300,
height: 300,
decoration: BoxDecoration(
shape: BoxShape.circle,
color: const Color(0xFF6C2BFF)
    .withOpacity(0.18),
boxShadow: [
BoxShadow(
color: const Color(0xFF6C2BFF)
    .withOpacity(0.25),
blurRadius: 120,
spreadRadius: 40,
),
],
),
),
),

// BOTTOM GLOW

Positioned(
bottom: -150,
left: -100,
child: Container(
width: 320,
height: 320,
decoration: BoxDecoration(
shape: BoxShape.circle,
color: const Color(0xFF008CFF)
    .withOpacity(0.14),
boxShadow: [
BoxShadow(
color: const Color(0xFF008CFF)
    .withOpacity(0.2),
blurRadius: 120,
spreadRadius: 40,
),
],
),
),
),

// LANGUAGE BUTTON

Positioned(
top: 16,
right: isArabic ? null : 20,
left: isArabic ? 20 : null,
child: Container(
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.08),
borderRadius: BorderRadius.circular(14),
border: Border.all(
color: Colors.white.withOpacity(0.15),
),
),
child: TextButton(
onPressed: () {
onLanguageChanged(
isArabic
? const Locale('en')
    : const Locale('ar'),
);
},
child: Row(
mainAxisSize: MainAxisSize.min,
children: [
const Icon(
Icons.language,
color: Colors.white,
size: 19,
),
const SizedBox(width: 7),
Text(
isArabic ? 'English' : 'العربية',
style: appTextStyle(
fontSize: 14,
fontWeight: FontWeight.w600,
color: Colors.white,
),
),
],
),
),
),
),

// MAIN CONTENT

Padding(
padding: const EdgeInsets.symmetric(
horizontal: 28,
),
child: Column(
children: [
const Spacer(),

// APP NAME

Text(
'NEXORA',
textDirection: TextDirection.ltr,
style: GoogleFonts.poppins(
fontSize: 42,
fontWeight: FontWeight.w800,
letterSpacing: 5,
color: Colors.white,
),
),

const SizedBox(height: 18),

// GRADIENT LINE

Container(
width: 80,
height: 3,
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [
Color(0xFF008CFF),
Color(0xFF7B3FFF),
Color(0xFFFF2DA6),
],
),
borderRadius: BorderRadius.circular(10),
),
),

const SizedBox(height: 28),

// TITLE

Text(
local.discoverPath,
textAlign: TextAlign.center,
style: appTextStyle(
fontSize: 25,
fontWeight: FontWeight.bold,
color: Colors.white,
height: 1.4,
),
),

const SizedBox(height: 16),

// DESCRIPTION

Text(
local.pathDescription,
textAlign: TextAlign.center,
style: appTextStyle(
fontSize: 16,
fontWeight: FontWeight.normal,
color: Colors.white70,
height: 1.7,
),
),

const Spacer(),

// START NOW BUTTON

SizedBox(
width: double.infinity,
height: 58,
child: DecoratedBox(
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [
Color(0xFF008CFF),
Color(0xFF7B3FFF),
Color(0xFFFF2DA6),
],
),
borderRadius: BorderRadius.circular(18),
),
child: ElevatedButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
const RegisterScreen(),
),
);
},
style: ElevatedButton.styleFrom(
backgroundColor: Colors.transparent,
shadowColor: Colors.transparent,
shape: RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(18),
),
),
child: Text(
local.startNow,
textAlign: TextAlign.center,
style: appTextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
),
),
),

const SizedBox(height: 16),

// LOGIN BUTTON

SizedBox(
width: double.infinity,
height: 55,
child: OutlinedButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
const LoginScreen(),
),
);
},
style: OutlinedButton.styleFrom(
side: const BorderSide(
color: Color(0xFF5E6BFF),
width: 1.2,
),
shape: RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(18),
),
),
child: Text(
local.login,
textAlign: TextAlign.center,
style: appTextStyle(
fontSize: 16,
fontWeight: FontWeight.w600,
color: Colors.white,
),
),
),
),

const SizedBox(height: 28),
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
}
